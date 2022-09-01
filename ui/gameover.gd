extends CanvasLayer


signal new_game_pressed


func _on_NewGame_pressed() -> void:
	hide()
	emit_signal("new_game_pressed")
