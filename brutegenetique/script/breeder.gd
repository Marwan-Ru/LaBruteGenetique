class_name Breeder

var _mut: float
var _parent: Array

func _init(mutation_rate: float) -> void:
	_mut = mutation_rate

func set_source(parent: Array) -> void:
	_parent = parent

func new_generation(n: int) -> Array:
	var players = _parent.duplicate()
	for i in range(0, n - _parent.size()):
		var a = [0, 0, 0, 0, 0]
		var b = [0, 0, 0, 0]
		
		a[0] = (_parent.pick_random().damage) if randf() > _mut else randi_range(1, _parent[0].points)
		a[1] = (_parent.pick_random().magic)  if randf() > _mut else randi_range(1, _parent[0].points)
		a[2] = (_parent.pick_random().heal)   if randf() > _mut else randi_range(1, _parent[0].points)
		a[3] = (_parent.pick_random().speed)  if randf() > _mut else randi_range(1, _parent[0].points)
		a[4] = (_parent.pick_random().health) if randf() > _mut else randi_range(1, _parent[0].points)
		
		b[0] = (_parent.pick_random().damage_attack) if randf() > _mut else randf_range(0, 1.0)
		b[1] = (_parent.pick_random().magic_attack)  if randf() > _mut else randf_range(0, 1.0) 
		b[2] = (_parent.pick_random().perform_heal)  if randf() > _mut else randf_range(0, 1.0)
		b[3] = (_parent.pick_random().block_attack)  if randf() > _mut else randf_range(0, 1.0)
		
		players.append(PlayerData.new(_parent[0].points, a, b))
		
	return players
