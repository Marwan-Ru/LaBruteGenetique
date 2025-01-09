class_name Player

extends Node

var data: PlayerData

var blocking: bool
var hp : int
var alive : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	blocking = false
	alive = true
	hp = data.health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Chooses the players action this turn
# Return 0 or 1 or 2 or 3
# corresponding to attack or magic or heal or block
func choose_action() -> int:
	var r = randf_range(0, 1)
	
	if r < data.damage_attack :
		return 0
	elif r < data.damage_attack + data.magic_attack:
		return 1
	elif r < data.damage_attack + data.magic_attack + data.perform_heal :
		self.heal()
		return 2
	else:
		blocking = true
		return 3

func do_action():
	
	var action = self.choose_action()
	
	match action:
		0:
			return action
		1:
			return action
		2:
			self.heal()
			return action
		3:
			blocking = false
			return -2
		_: #Default
			print("Error in do_action()")
			return -1000

func take_damage(val):
	if(!blocking and alive):
		hp -= val
		if hp <= 0:
			hp = 0
			alive = false
	blocking = false

func heal():
	if(alive):
		hp += data.heal
		if hp > data.health:
			hp = data.health
