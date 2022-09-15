extends StaticBody2D

signal clicked(body)
signal shoot(bullet, muzzle_position, target_dir)
signal dead(body)

var bullet = preload("res://bullets/TowerShot.tscn")

onready var muzzle = $Turret/Muzzle
onready var gun_timer = $GunTimer

var health
var turret_target = null
var start_pause = true


func _ready():
	health = 100
	var circle = CircleShape2D.new()
	circle.radius = 300 + G.difficulty * 100
	$DetectRadius/CollisionShape2D.shape = circle
	

func _process(delta: float) -> void:
	if turret_target != null && is_instance_valid(turret_target):
		$Turret.look_at(turret_target.global_position)


func take_damage(damage: int):
	health -= damage
	if health <= 0:
		emit_signal("dead", self)
		queue_free()


func shoot():
	if !start_pause && turret_target && !G.game_over:
		var target_dir = (turret_target.global_position - global_position).normalized()
		emit_signal('shoot', bullet, muzzle.global_position, target_dir)
		gun_timer.start()


func _on_Tower_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		emit_signal("clicked", self)


func _on_DetectRadius_body_entered(body):
	if body == G.player:
		turret_target = body
		shoot()


func _on_DetectRadius_body_exited(body):
	if body == turret_target:
		turret_target = null


func _on_GunTimer_timeout():
	shoot()


func _on_StartTimer_timeout() -> void:
	start_pause = false
