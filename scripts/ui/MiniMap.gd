extends SubViewport

@onready var camera = $Camera2D

func _physics_process(_delta):
	camera.position = owner.find_child("Player").position
