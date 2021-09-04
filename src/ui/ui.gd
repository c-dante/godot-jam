extends Control

var view: Viewport
export (NodePath) var playerCamPath
export (NodePath) var cam1Path

var playerCam: Camera
var cam1: Camera

onready var playerCamBtn = get_node("Menu/CamTab/CameraBox/Player Camera")
onready var cam1Btn = get_node("Menu/CamTab/CameraBox/Camera1")

var viewedIntro = true

func _ready():
	view = get_viewport();
	playerCam = get_node(playerCamPath)
	cam1 = get_node(cam1Path)
	setButtonState()
	# print(viewedIntro)

func _process(_delta):
	if !viewedIntro:
		viewedIntro = true
		$"./IntroDialog".popup()

func setButtonState():
	playerCamBtn.pressed = view.get_camera() == playerCam
	cam1Btn.pressed = view.get_camera() == cam1

func _on_Player_Camera_pressed():
	playerCam.make_current()
	setButtonState()

func _on_Camera1_pressed():
	cam1.make_current()
	setButtonState()
