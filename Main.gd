extends Node2D

onready var paused = $ViewportContainer/Viewport/Paused
onready var gameover = $ViewportContainer/Viewport/GameOver
onready var gameover_laber = $ViewportContainer/Viewport/GameOver/Box/VBoxContainer/GameOver/Label


# Called when the node enters the scene tree for the first time.
func _ready():
	paused.hide()
	VisualServer.set_default_clear_color(Color(1,1,1)) # set background to white
	gameover.hide()
	G.player = $ViewportContainer/Viewport/Map/YSort/Player
	G.located_forts = []


func _on_Map_game_over(win: bool):
	if win:
		gameover_laber.text = "Win!"
	else:
		gameover_laber.text = "Game over"
	gameover.show()


func new_game():
	G.located_forts = []
	get_tree().change_scene("res://StartScreen.tscn")


func _on_GameOver_new_game_pressed():
	new_game()


func _on_HUD_pause_pressed() -> void:
	G.located_forts = []
	get_tree().paused = true
	paused.show()


func _on_Paused_quit() -> void:
	new_game()
