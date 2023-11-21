extends CharacterBody2D

var current_rotation_speed = 0
var touch_positions = {}  # Dictionary to keep track of touch positions

@export var rotation_acceleration = 1.0
@export var max_rotation_speed = 3.0
@export var max_move_speed = 100
var move_speed = 0

# Flags to determine if the left or right side is being touched
var left_touch = false
var right_touch = false

func _on_speed_slider_value_changed(value):
	move_speed = max_move_speed * (value / 100.0)

func _unhandled_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			touch_positions[event.index] = event.position
			# Determine which side of the screen was touched
			if event.position.x < get_viewport().size.x / 2:
				left_touch = true
			else:
				right_touch = true
		else:
			touch_positions.erase(event.index)
			# Reset touch flags when the finger is lifted
			left_touch = false
			right_touch = false

	if event is InputEventScreenDrag:
		touch_positions[event.index] = event.position
		# Update the touch flags if the finger moves across the screen
		if event.position.x < get_viewport().size.x / 2:
			left_touch = true
			right_touch = false
		else:
			left_touch = false
			right_touch = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Update the rotation speed based on touch
	if left_touch:
		current_rotation_speed = max(current_rotation_speed - rotation_acceleration * delta, -max_rotation_speed)
	elif right_touch:
		current_rotation_speed = min(current_rotation_speed + rotation_acceleration * delta, max_rotation_speed)
	else:
		current_rotation_speed = 0  # Stop rotation if no side is touched

	# Apply rotation and movement
	if current_rotation_speed != 0:
		rotation += current_rotation_speed * delta

	if move_speed > 0:
		var move_direction = Vector2(1, 0).rotated(rotation)
		position += move_direction * move_speed * delta


