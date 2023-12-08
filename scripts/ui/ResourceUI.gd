extends Control

# UI elements references
@onready var gold_label = $ResourceContainer/GoldContainer/GoldLabel
@onready var food_label = $ResourceContainer/FoodContainer/FoodLabel
@onready var sailors_label = $ResourceContainer/SailorsContainer/SailorsLabel

func update_ui(gold_amount: int, food_amount: int, sailor_amount: int):
	gold_label.text = str(gold_amount)
	food_label.text = str(food_amount)
	sailors_label.text = str(sailor_amount)
