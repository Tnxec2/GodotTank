extends Node2D

var screen = 0

onready var screens = [
	[preload("res://assets/help/move.png"), "swipe to move"],
	[preload("res://assets/help/shoot.png"), "click to shoot"],
	[preload("res://assets/help/missile.png"), "click on enemy or object to launch missile"],
	[preload("res://assets/help/trucks.png"), "killed trucks drop pickups"],
	[preload("res://assets/help/flag.png"), "pick all flags to win"]
]

func _ready() -> void:
	show_screen()
	

func show_screen():
	if screen <= 0:
		$CanvasLayer/Box/VBoxContainer/ButtonsContainer/Back.text = "Close"
	else:
		$CanvasLayer/Box/VBoxContainer/ButtonsContainer/Back.text = "Back"
	if screen >= screens.size()-1:
		$CanvasLayer/Box/VBoxContainer/ButtonsContainer/Next.text = "Play"
	else:
		$CanvasLayer/Box/VBoxContainer/ButtonsContainer/Next.text = "Next"
		
	$CanvasLayer/Box/VBoxContainer/MainHelp/TextureRect.texture = screens[screen][0]
	$CanvasLayer/Box/VBoxContainer/HelpText/Label.text = screens[screen][1]


func _on_Back_pressed() -> void:
	if screen > 0:
		screen -= 1
		show_screen()
	else:
		get_tree().change_scene("res://StartScreen.tscn")


func _on_Next_pressed() -> void:
	if screen < screens.size()-1:
		screen += 1
		show_screen()
	else:
		get_tree().change_scene("res://StartScreen.tscn")
