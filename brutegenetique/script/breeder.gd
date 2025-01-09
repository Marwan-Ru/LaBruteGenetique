class_name Breeder

var _mut: float
var _lhs: PlayerData
var _rhs: PlayerData

func _init(mutation_rate: float) -> void:
	_mut = mutation_rate

func set_source(lhs: PlayerData, rhs: PlayerData) -> void:
	_lhs = lhs
	_rhs = rhs

func new_generation(n: int) -> Array[PlayerData]:
	var players = []
	for i in range(0, n):
		var a = []
		var b = []
		
		a[0] = _lhs.damage if randf() > 0.5 else _rhs.damage 
		a[1] = _lhs.magic  if randf() > 0.5 else _rhs.magic 
		a[2] = _lhs.heal   if randf() > 0.5 else _rhs.heal 
		a[3] = _lhs.speed  if randf() > 0.5 else _rhs.speed 
		a[4] = _lhs.health if randf() > 0.5 else _rhs.health
		
		b[0] = _lhs.damage_attack if randf() > 0.5 else _rhs.damage_attack 
		b[1] = _lhs.magic_attack  if randf() > 0.5 else _rhs.magic_attack 
		b[2] = _lhs.perform_heal  if randf() > 0.5 else _rhs.perform_heal 
		b[3] = _lhs.block_attack  if randf() > 0.5 else _rhs.block_attack
		
		players.append(PlayerData.new(_lhs.points, a, b))
		
	return players
