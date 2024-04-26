extends RigidBody2D

enum PC_STATE {READY, DRAG, RELEASE}

var state: PC_STATE = PC_STATE.READY
# The state when pc load in the scene 

func _ready():
	pass # Replace with function body.




func _physics_process(delta):
	update(delta)

func set_new_state(new_state: PC_STATE) -> void:
	state = new_state
	if state == PC_STATE.RELEASE:
		freeze = false 
	elif state == PC_STATE.DRAG:
		pass

func detect_release() -> bool: 
	if state == PC_STATE.DRAG:
		if Input.is_action_just_released("drag") == true: 
			set_new_state(PC_STATE.RELEASE)
			pass
			return true
	return false 

func update_drag() -> void:
	
	if detect_release() == true:
		return
	
	var gmp = get_global_mouse_position()
	position = gmp
	# jump the mouse position to where the PC at

func update(delta:float) -> void:
	match state:
		PC_STATE.DRAG:
			update_drag()


func died():
	queue_free()
	SignalManager.on_pc_died.emit()

func _on_screen_exited():
	died()


func _on_input_event(viewport, event, shape_idx):
	if state == PC_STATE.READY and event.is_action_pressed("drag"):
		set_new_state(PC_STATE.DRAG)
	
