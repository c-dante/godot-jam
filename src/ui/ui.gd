extends Control

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

func introClosed():
	get_tree().paused = false

func _on_Reload_pressed():
	Events.restart_game()

func gameOverClosed():
	get_tree().paused = false
	Events.restart_game()

# -------- TODO NOT HERE
func killableKill(entity):
	if entity == $"/root/Main/Player":
		Events.game_over(entity)

func gameOver(player):
	print(player)
	get_tree().paused = true
	$GameOver.popup_centered()
