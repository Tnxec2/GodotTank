extends Node2D

onready var paused = $Paused
onready var gameover = $GameOver
onready var gameover_laber = $GameOver/Box/VBoxContainer/GameOver/Label

onready var player = $Map/YSort/Player
onready var map = $Map

const MIN_SWIPE_DISTANCE = 32
var swipe_movement_vector = Vector2(0,0)
var swipe_position_init
var swipe_position_release


# Called when the node enters the scene tree for the first time.
func _ready():
	paused.hide()
	VisualServer.set_default_clear_color(Color(1,1,1)) # set background to white
	gameover.hide()
	G.player = $Map/YSort/Player
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


func _process(delta: float) -> void:
	pass


func _unhandled_input(event: InputEvent) -> void:
	if G.game_over:
		return
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		# print("Mouse Click/Unclick at: ", event.position)
		#var vrect = get_viewport().get_visible_rect()
		#--- necessary for NON-HiDPI monitors ---#
		#print(vrect.size) # 1968 x 1080 on NON-HiDPI / 1920 x 1080 on HiDPI
		#vrect.size = get_viewport().size
		#print(vrect.size) # 1540 x  845 on NON-HiDPI / 1920 x 1080 on HiDPI
		#----------------------------------------#
		var coords = map.get_global_mouse_position()
		if event.is_pressed():
			swipe_position_init = coords  # get initial position
		else:
			swipe_position_release = coords  # get final position on release of mouse button
			if swipe_position_release.distance_to(swipe_position_init) > MIN_SWIPE_DISTANCE:
				swipe_movement_vector = (swipe_position_release - swipe_position_init).normalized()  # obtain the movement vector
				player.drive_to(swipe_movement_vector)
			else:
				if map.current_bullet_type != 2: # not missile
#					var viewport_base_size = (
#						get_viewport().get_size_override() if get_viewport().get_size_override() > Vector2(0, 0)
#						else get_viewport().size
#					)
#					var scale_factor = OS.window_size / viewport_base_size
#
#					var unscaled_mouse_position = player.get_local_mouse_position() / scale_factor
					#var unscaled_mouse_position = player.get_global_mouse_position() - player.global_position 
					
					#var shoot_vector = (unscaled_mouse_position).normalized()
					
					player.shot_to(player.get_global_mouse_position(), map.current_bullet_type, null)
	elif event is InputEventMouseMotion:
		#print("Mouse Motion at: ", event.position)
		pass
	# Print the size of the viewport.
	#print("Viewport Resolution is: ", get_viewport_rect().size
