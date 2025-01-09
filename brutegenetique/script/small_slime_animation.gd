extends CharacterBody2D

var sprite : AnimatedSprite2D
var delta_time : float
var current_time : float

func _ready() -> void:
	sprite = get_node("AnimatedSprite2D")
	delta_time = 3
	current_time = 2
	sprite.play("idle")

func _process(delta: float) -> void:
	current_time = current_time - delta
	
	if current_time <= 0:
		sprite.play("hurt")
		current_time = delta_time
	elif current_time <= 2.75:
		sprite.play("idle")
