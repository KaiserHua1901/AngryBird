extends RigidBody2D

enum PC_STATE {READY, DRAG, RELEASE}

const DRAG_lIM_MAX: Vector2 = Vector2(0, 60)
const DRAG_LIM_MIN: Vector2 = Vector2(-60, 0)
const IMPULSE_MULT: float = 20.0
const IMPULSE_MAX: float = 1200.0


var start:Vector2 = Vector2.ZERO
var drag_start:Vector2 = Vector2.ZERO
var dragged_vector: Vector2 = Vector2.ZERO
var last_dragged_vector: Vector2 = Vector2.ZERO
var arrow_scale_x:float = 0.0
var is_contact: int = 0

@onready var label = %Label
@onready var stretch = %Stretch
@onready var arrow = %Arrow
@onready var lauch_sound = %LauchSound
@onready var hit = $hit


var state: PC_STATE = PC_STATE.READY
# The state when pc load in the scene 

func _ready():
	arrow_scale_x = arrow.scale.x
	arrow.hide()
	start = position
	# Make the start position to the postition of the PC position
	
func _physics_process(delta):
	update(delta)
	label.text = "%.1f, %.1f" % [dragged_vector.x, dragged_vector.y]
	
func set_new_state(new_state: PC_STATE) -> void:
	state = new_state
	if state == PC_STATE.RELEASE:
		arrow.hide()
		freeze = false 
		apply_central_impulse(get_impulse())
		lauch_sound.play()
		SignalManager.on_attempt_made.emit()
	elif state == PC_STATE.DRAG:
		drag_start = get_global_mouse_position()
		arrow.show()
		
		
		
		
func detect_release() -> bool: 
	if state == PC_STATE.DRAG:
		if Input.is_action_just_released("drag") == true: 
			set_new_state(PC_STATE.RELEASE)
			pass
			return true
	return false 

func get_impulse() -> Vector2:
	return dragged_vector * -1 * IMPULSE_MULT



func scale_arrow() -> void:
	var imp_len = get_impulse().length()
	var perc = imp_len / IMPULSE_MAX
	
	arrow.scale.x = (arrow_scale_x * perc) + arrow_scale_x
	
	arrow.rotation = (start - position).angle()
	
	
	
	

func play_stretch_sound()-> void:
	if (last_dragged_vector - dragged_vector).length() > 0:
		if stretch.playing == false:
			stretch.play()


func get_dragged_vector(gmp: Vector2) -> Vector2:
	return gmp - drag_start

func drag_in_limit() -> void: 
	last_dragged_vector = dragged_vector
	
	dragged_vector.x = clampf(
		dragged_vector.x,
		DRAG_LIM_MIN.x, 
		DRAG_lIM_MAX.x
	)
	dragged_vector.y = clampf(
		dragged_vector.y,
		DRAG_LIM_MIN.y, 
		DRAG_lIM_MAX.y
	)
	position = start + dragged_vector

func update_drag() -> void:	
	if detect_release() == true:
		return
	var gmp = get_global_mouse_position()
	dragged_vector = get_dragged_vector(gmp)
	play_stretch_sound()
	drag_in_limit()
	scale_arrow()
	# jump the mouse position to where the PC at

func update_fly() -> void:
	if is_contact == 0 and get_contact_count() > 0 and hit.playing == false: 
		hit.play()
		#await get_tree().create_timer(2).timeout
		#died()
	is_contact = get_contact_count()
		




func update(delta:float) -> void:
	match state:
		PC_STATE.DRAG:
			update_drag()
		PC_STATE.RELEASE:
			update_fly()


func died():
	queue_free()
	SignalManager.on_pc_died.emit()

func _on_screen_exited():
	died()


func _on_input_event(viewport, event, shape_idx):
	if state == PC_STATE.READY and event.is_action_pressed("drag"):
		set_new_state(PC_STATE.DRAG)
	

func _on_sleeping_state_changed():
	if sleeping == true:
		if get_colliding_bodies().size() > 0:
			get_colliding_bodies()[0].died()
	call_deferred("died")


