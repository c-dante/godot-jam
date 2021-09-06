extends Control

const Equipment = preload("res://src/Equipment.gd")
const Killable = preload("res://src/Killable.gd")
const Res = preload("res://src/Resources.gd")

var view: Viewport

func _ready():
	if OS.has_feature("editor"):
		Global.viewedIntro = true

	pause_mode = PAUSE_MODE_PROCESS
	view = get_viewport();

	if $IntroDialog.connect("popup_hide", self, "introClosed") != OK:
		push_error("Failed to connect intro pause")

	if $GameOver.connect("popup_hide", self, "gameOverClosed") != OK:
		push_error("Failed to connect game over pause")

	if Events.connect("on_killable_kill", self, "killableKill") != OK:
		push_error("Failed to connect killable check")

	if Events.connect("on_game_over", self, "gameOver") != OK:
		push_error("Failed to connect game over")

func _process(_delta):
	if !Global.viewedIntro:
		Global.viewedIntro = true
		get_tree().paused = true
		$IntroDialog.popup_centered()

	update_stats()

func introClosed():
	get_tree().paused = false

func _on_Reload_pressed():
	Events.restart_game()

func gameOverClosed():
	get_tree().paused = false
	Events.restart_game()

# -------- TODO NOT HERE. THIS IS THE GAME OVER LOGIC XD

# HERE BE DRAGONS
func killableKill(entity):
	if entity == $"/root/Main/Player":
		Events.game_over(entity)

func gameOver(player):
	get_tree().paused = true
	var score = 0
	score += 10 * player.minersBuilt
	score += 100 * player.kills
	score += floor(player.gameTime)
	score += player.minedResources
	score -= 10 * player.minersLost

	var result_text = """
Score: {score}

You survived for {time} seconds
You slayed {kills} enemies
You built {built_miners} miners and lost {lost_miners} of them
You mined {total_mined} resources

Thanks for playing!

Close or hit ok to start again.
"""
	$GameOver.dialog_text = result_text.format({
		"score": ceil(score),
		"time": Global.formatTime(player.gameTime),
		"kills": player.kills,
		"built_miners": player.minersBuilt,
		"lost_miners": player.minersLost,
		"total_mined": player.minedResources,
	})
	$GameOver.popup_centered()


onready var wave_time_txt = $"right/VBoxContainer/wave_time"
onready var life_txt = $"right/VBoxContainer/life"
onready var stone_txt = $"right/VBoxContainer/stone"
onready var wood_txt = $"right/VBoxContainer/wood"
onready var has_bow_txt = $"right/VBoxContainer/has_bow"
onready var _player = $"/root/Main/Player"
func update_stats():
	var id = _player.get_instance_id()
	var equip: Equipment = _player.get_node(Global.GROUP.EQUIPMENT)
	if equip != null:
		has_bow_txt.visible = equip.owned_items.has(Res.ItemType.Bow)

	var killable: Killable = _player.get_node(Global.GROUP.KILLABLE)
	if killable != null:
		life_txt.text = "%d life" % killable.life

	wave_time_txt.text = Global.formatTime(_player.gameTime)
	stone_txt.text = "%d stone" % Resources.getResource(id, Res.ResourceType.Stone)
	wood_txt.text = "%d wood" % Resources.getResource(id, Res.ResourceType.Wood)
