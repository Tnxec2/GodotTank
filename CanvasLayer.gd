extends CanvasLayer

signal quit

func _ready() -> void:
	pass


func unpause():
	hide()
	get_tree().paused = false


func _on_Quit_pressed() -> void:
	unpause()
	emit_signal("quit")


func _on_Play_pressed() -> void:
	unpause()
