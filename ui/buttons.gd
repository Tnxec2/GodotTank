extends Control

signal shot_pressed()
signal cannon_pressed()
signal missile_pressed()
signal bomb_pressed()
signal pause_pressed()

const SELECTED_TINT = Color("8caafffe")
const NORMAL_TINT = Color("8cffffff")

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/MiniMap.modulate = NORMAL_TINT
	pass # Replace with function body.

func _on_Shot_pressed():
	emit_signal("shot_pressed")

func _on_Cannon_pressed():
	emit_signal("cannon_pressed")

func _on_Missile_pressed():
	emit_signal("missile_pressed")

func _on_Bomb_pressed():
	$VBoxContainer/Bomb.modulate = NORMAL_TINT
	emit_signal("bomb_pressed")

func _on_MiniMap_pressed() -> void:
	emit_signal("pause_pressed")
