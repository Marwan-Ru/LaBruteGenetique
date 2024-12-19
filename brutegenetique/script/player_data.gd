extends Node

class_name PlayerData

static var points_pool = 100

var _rnd: RandomNumberGenerator

var damage: int
var magic : int
var heal  : int
var speed : int
var health: int

var damage_attack: float
var magic_attack : float
var perform_heal : float
var block_attack : float

func _init() -> void:
	_rnd = RandomNumberGenerator.new()
	randomize_parameter()
	
func _process(delta: float) -> void:
	if Input.is_action_just_released("RND"):
		randomize_parameter()

func distribution(min, pool, size, fn) -> Array:
	var dist   = range(size).map(func(n): return fn.call(min, pool))
	var factor = pool as float / dist.reduce(func(acc, n): return acc + n, 0) as float
	return dist.map(func(n): return n * factor as float) 

func real_distribution(pool, size):
	return distribution(0, pool, size, _rnd.randf_range)

func int_distribution(min, pool, size):
	var dist = distribution(min, pool, size, _rnd.randi_range).map(func(n): return ceili(n))
	var diff = pool - dist.reduce(func(acc, n): return acc + n, 0)
	while true:
		var idx = _rnd.randi_range(0, dist.size() - 1)
		if (dist[idx] + diff >= min):
			dist[idx] += diff
			break
	return dist

func randomize_parameter() -> void:
	var dist = int_distribution(1, points_pool, 5)
	damage  = dist[0]
	magic   = dist[1]
	heal    = dist[2]
	speed   = dist[3]
	health  = dist[4]
	
	dist = real_distribution(1.0, 4)
	damage_attack = dist[0]
	magic_attack  = dist[1]
	perform_heal  = dist[2]
	block_attack  = dist[3]
