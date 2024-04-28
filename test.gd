extends  RigidBody2D

enum TEST_STATE {READY, DRAG, RELEASE}

var state = TEST_STATE.READY
@onready var label = $Label

func _physics_process(delta):
	label.text = "%s" % TEST_STATE.keys()[state]
	update_state(delta)
	
func set_state(new_state:TEST_STATE) -> void:
	state = new_state
	if state == TEST_STATE.DRAG:
		pass
	elif state == TEST_STATE.RELEASE:
		freeze = false
		 
	
func update_state(delta):
	match state:
		TEST_STATE.DRAG:
			var gmp = get_global_mouse_position()
			position = gmp
			
			if state == TEST_STATE.DRAG:
				if Input.is_action_just_released("drag") == true:
					set_state(TEST_STATE.RELEASE)
					

func _on_input_event(viewport, event, shape_idx):
	if state == TEST_STATE.READY and event.is_action_pressed("drag"):
		set_state(TEST_STATE.DRAG)
		
		
	
