extends "res://tank/Tank.gd"

const TURRET_ROTATE_BACK_DELAY = 1
var turret_rotate_timer = 0

export (PackedScene) var Bomb
export (PackedScene) var Shot
export (PackedScene) var Cannone
export (PackedScene) var Missile

export (int) var bomb_count
export (int) var cannone_count
export (int) var missile_count

signal change_bomb_count
signal shoot
signal set_bomb
signal change_cannon_count
signal change_missile_count
signal change_killed_enemys



enum BulletTypes {
	Shot,
	Cannon,
	Missile
}

var currentBulletType = BulletTypes.Shot

func _ready():
	emit_signal("change_bomb_count", bomb_count)
	emit_signal("change_cannon_count", cannone_count)
	emit_signal("change_missile_count", missile_count)


func control(delta):
	position.x = clamp(position.x, $Camera2D.limit_left + $Body.texture.get_width()/2, $Camera2D.limit_right - $Body.texture.get_width()/2)
	position.y = clamp(position.y, $Camera2D.limit_top + $Body.texture.get_height()/2, $Camera2D.limit_bottom - $Body.texture.get_height()/2)
	if turret_rotate_timer > 0:
		turret_rotate_timer -= delta
	elif turret_rotate_timer < 0:
		turret_rotate_timer = 0
		$Turret.set_rotation(0)

func drive_to(target_vector: Vector2) -> void:
	look_at(position+target_vector)
	velocity = target_vector * speed

func shot_to(position: Vector2):
	turret_rotate_timer = TURRET_ROTATE_BACK_DELAY
	$Turret.look_at(position)
	var dir = Vector2(1, 0).rotated($Turret.global_rotation)
	if currentBulletType == BulletTypes.Shot:
		emit_signal('shoot', Shot, $Turret/Muzzle.global_position, dir)
	elif currentBulletType == BulletTypes.Cannon:
		if cannone_count > 0:
			cannone_count -= 1
			emit_signal("change_cannon_count", cannone_count)
			emit_signal('shoot', Cannone, $Turret/Muzzle.global_position, dir)
	elif currentBulletType == BulletTypes.Missile:
		if missile_count > 0:
			missile_count -= 1
			emit_signal("change_missile_count", missile_count)
			emit_signal('shoot', Missile, $Turret/Muzzle.global_position, dir)
	
func _on_Map_swipedTo(vector):
	drive_to(vector)

func _on_Map_clicked(position):
	shot_to(position)

func setBomb():
	if bomb_count <= 0:
		return
	bomb_count -= 1
	emit_signal("change_bomb_count", bomb_count)
	emit_signal('set_bomb', Bomb, position)
