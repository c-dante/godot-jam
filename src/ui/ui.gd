extends Control

var view: Viewport

var viewedIntro = false

func _ready():
	if OS.has_feature("editor"):
		viewedIntro = true

	pause_mode = PAUSE_MODE_PROCESS
	view = get_viewport();

func _process(_delta):
	if !viewedIntro:
		viewedIntro = true
		if $IntroDialog.connect("popup_hide", self, "introClosed") != OK:
			push_error("Failed to connect popup pause")
		else:
			get_tree().paused = true

		$IntroDialog.popup_centered()

func introClosed():
	get_tree().paused = false

func _on_Reload_pressed():
	Events.restart_game()
