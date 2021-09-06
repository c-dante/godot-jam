extends Control

var view: Viewport
export (NodePath) var playerCamPath
export (NodePath) var cam1Path

var playerCam: Camera
var cam1: Camera

onready var playerCamBtn = $"Menu/Cams/CameraBox/Player Camera"
onready var cam1Btn = $"Menu/Cams/CameraBox/Camera1"

var viewedIntro = false

func _ready():
	if OS.has_feature("editor"):
		print("RAN FROM EDITOR")
		viewedIntro = true

	pause_mode = PAUSE_MODE_PROCESS
	view = get_viewport();
	playerCam = get_node(playerCamPath)
	cam1 = get_node(cam1Path)
	if playerCamBtn != null && cam1Btn != null:
		setButtonState()

func _process(_delta):
	if !viewedIntro:
		viewedIntro = true
		for child in $IntroDialog.get_children():
			print([child, child.get_path()])

		if $IntroDialog.connect("popup_hide", self, "introClosed") != OK:
			push_error("Failed to connect popup pause")
		else:
			get_tree().paused = true

		$IntroDialog.popup_centered()

func introClosed():
	get_tree().paused = false

func setButtonState():
	playerCamBtn.pressed = view.get_camera() == playerCam
	cam1Btn.pressed = view.get_camera() == cam1

func _on_Player_Camera_pressed():
	playerCam.make_current()
	setButtonState()

func _on_Camera1_pressed():
	cam1.make_current()
	setButtonState()

func _on_Miner_pressed():
	pass