extends CanvasLayer

signal bomb_pressed
signal shot_pressed
signal cannon_pressed
signal missile_pressed
signal pause_pressed

const SELECTED_TINT = Color("aafffe")
const NORMAL_TINT = Color("ffffff")

func _on_VBoxContainer_bomb_pressed():
	emit_signal("bomb_pressed")

func _on_VBoxContainer_cannon_pressed():
	emit_signal("cannon_pressed")

func _on_VBoxContainer_missile_pressed():
	emit_signal("missile_pressed")

func _on_VBoxContainer_shot_pressed():
	emit_signal("shot_pressed")

func _on_Player_change_bomb_count(value: int):
	$Buttons/VBoxContainer/Bomb.text = str(value)

func _on_Player_change_cannon_count(value: int):
	$Buttons/VBoxContainer/Cannon.text = str(value)

func _on_Player_change_missile_count(value: int):
	$Buttons/VBoxContainer/Missile.text = str(value)


func _on_Map_change_bullet_type(bulletType):
	$Buttons/VBoxContainer/Shot.modulate = NORMAL_TINT
	$Buttons/VBoxContainer/Cannon.modulate = NORMAL_TINT
	$Buttons/VBoxContainer/Missile.modulate = NORMAL_TINT
	if bulletType == 2:
		$Buttons/VBoxContainer/Missile.modulate = SELECTED_TINT
	elif bulletType == 1:
		$Buttons/VBoxContainer/Cannon.modulate = SELECTED_TINT
	else:
		$Buttons/VBoxContainer/Shot.modulate = SELECTED_TINT


func _on_Player_health_changed(value: int):
	$HBoxContainer/LifeContainer/LifeIcon/Label.text = str(value)


func _on_Map_change_count_enemys(countEnemys):
	$HBoxContainer/EnemysContainer/EnemysIcon/Label.text = str(countEnemys)


func _on_Buttons_pause_pressed() -> void:
	get_tree().paused = true
	emit_signal("pause_pressed")
