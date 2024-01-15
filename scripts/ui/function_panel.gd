extends Panel

var drag_start_pos = Vector2()
var is_dragging = false
var original_position = Vector2()  # Add a variable to store the original position
var is_open = false

@export var minimum_completion_threshold = 0.25

func _ready():
	$ArrowDirectionBlack.connect("pressed", Callable(self, "_on_Sprite_pressed"))
	original_position = position  # Store the original position of the panel

#func _input(event):
#	if event is InputEventScreenDrag:
#		if !is_dragging:
#			drag_start_pos = event.position
#			is_dragging = true
#
#		var current_pos = event.position
#		var drag_offset = current_pos - drag_start_pos
#		# Update panel position to follow the finger
#		position += drag_offset
#		drag_start_pos = current_pos

#	elif event is InputEventScreenTouch and event.is_pressed() == false and is_dragging:
#		is_dragging = false
#		check_and_animate_panel()

func _on_Sprite_pressed():
	animate_panel()
	print("Is panel open: ", is_open)

#func check_and_animate_panel():
#	# Determine how far the panel has moved
#	var distance_moved = abs(position.y - original_position.y)
#	if distance_moved > size.y * minimum_completion_threshold:
#		animate_panel(is_open)
#	else:
#		animate_panel(is_open)

func animate_panel():
	var animation_player = $AnimationPlayer

	# Ensure there is no animation currently playing
	animation_player.stop()

	if is_open:
		animation_player.play("SlideOut")
	else:
		animation_player.play("SlideIn")
		
	is_open = !is_open
