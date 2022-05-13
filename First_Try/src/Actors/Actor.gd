extends KinematicBody2D
class_name Actor

export var gravity: = 1500.0
export var terminal_velocity: = 3000.0
var velocity: = Vector2.ZERO

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	velocity.y = min(velocity.y, terminal_velocity)
