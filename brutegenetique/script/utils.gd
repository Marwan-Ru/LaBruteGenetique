class_name Utils

static func _distribution(min, pool, size: int, fn) -> Array:
	var dist = range(size).map(func(n): return fn.call(min, pool))
	return normalize_distribution(dist, pool)

static func real_distribution(pool: float, size: int) -> Array:
	return _distribution(0, pool, size, randf_range)

static func int_distribution(min: int, pool: int, size: int) -> Array:
	var dist = _distribution(min, pool, size, randi_range).map(func(n): return ceili(n))
	return fix_int_distribution(dist, pool, min)
	
static func normalize_distribution(dist: Array, pool) -> Array:
	var factor = pool as float / dist.reduce(func(acc, n): return acc + n, 0) as float
	return dist.map(func(n): return n as float * factor as float)
	
static func fix_int_distribution(dist: Array, pool, min):
	for i in range(dist.size()):
		if dist[i] < min:
			dist[i] = min
	
	var diff = pool - dist.reduce(func(acc, n): return acc + n, 0)
	while true:
		var idx = randi_range(0, dist.size() - 1)
		if (dist[idx] + diff >= min):
			dist[idx] += diff
			break
	return dist
