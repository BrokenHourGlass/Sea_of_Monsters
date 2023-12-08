extends Node

class GameResource:
	var amount = 0

	func _init(initial_amount:int):
		amount = initial_amount

	func add(value:int):
		amount += value

	func subtract(value:int):
		amount -= value
		if amount < 0:
			amount = 0

	func get_value() -> int:
		return amount

var gold_resource = GameResource.new(100)
var food_resource = GameResource.new(50)
var sailors_resource = GameResource.new(20)

# Reference to the nodes
var resource_ui
var food_timer:Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	var main_scene = get_tree().root.get_child(get_tree().root.get_child_count() - 1)
	resource_ui = main_scene.get_node("UI/ResourceUI")
	if resource_ui:
		call_deferred("update_ui")
	else:
		print("ResourceUI node not found")
	
	#setup food exhaustion functionality
	food_timer = Timer.new()
	food_timer.wait_time = 5.0
	food_timer.autostart = true
	food_timer.connect("timeout", Callable(self, "_on_FoodTimer_timeout"))
	add_child(food_timer)

func update_ui():
	resource_ui.update_ui(gold_resource.get_value(), food_resource.get_value(), sailors_resource.get_value())

func adjust_food_timer():
	var base_interval = 5.0  # Base interval in seconds
	var sailor_count = sailors_resource.get_value()
	var adjustment_factor = max(sailor_count / 5.0, 1.0)  # Adjust this factor as needed
	food_timer.wait_time = base_interval / adjustment_factor
	print(food_timer.wait_time)

func _on_FoodTimer_timeout():
	# Check if food is available
	if food_resource.get_value() > 0:
		food_resource.subtract(1)  # Subtract a fixed small amount
	else:
		if sailors_resource.get_value() > 0:
			sailors_resource.subtract(1)
			food_resource.add(10)  # Replenish food when a sailor is removed
	
	adjust_food_timer()  # Re-adjust the timer after each timeout
	update_ui()
