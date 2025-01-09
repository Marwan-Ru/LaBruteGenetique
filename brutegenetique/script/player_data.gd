class_name PlayerData

var points: int

var damage: int
var magic : int
var heal  : int
var speed : int
var health: int

var damage_attack: float
var magic_attack : float
var perform_heal : float
var block_attack : float
	
static func from_random(pool: int) -> PlayerData:
	return PlayerData.new(pool, Utils.int_distribution(1, pool, 5), Utils.real_distribution(1.0, 4))
	
func _init(points_: int, a: Array, b: Array) -> void:
	points = points_
	from_distribution(a, b)
	
func from_distribution(a: Array, b: Array) -> void:
	if a.reduce(func(acc, v): return acc + v, 0) != points:
		Utils.normalize_distribution(a, points)
		Utils.fix_int_distribution  (a, points, 1)
		
	if not is_equal_approx(b.reduce(func(acc, v): return acc + v, 0), 1.0):
		Utils.normalize_distribution(a, points)
		
	damage = a[0]
	magic  = a[1]
	heal   = a[2]
	speed  = a[3]
	health = a[4]
		
	damage_attack = b[0]
	magic_attack  = b[1]
	perform_heal  = b[2]
	block_attack  = b[3]
