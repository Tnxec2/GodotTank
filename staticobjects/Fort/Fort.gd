extends StaticBody2D

signal shoot
signal clicked(body)
signal dead(body)

var located_from_player = false

var size = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	size = $SizeMarker.position
	

func body_dead(body):
	emit_signal("dead", body)


func _on_Body_clicked(body):
	emit_signal("clicked", body)


func _on_Tower_shoot(bullet, muzzle_position, target_dir):
	emit_signal("shoot", bullet, muzzle_position, target_dir)


func _on_VisibilityNotifier2D_screen_entered():
	if located_from_player:
		return
	var array = G.located_forts
	array.append(global_position + size / 2)
	G.located_forts = array
	located_from_player = true


