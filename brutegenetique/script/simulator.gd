class_name Simulator

var playerArray : Array
var slime : Slime
var populationSize = 1000

class Slime:
	var health : int
	var hp : int
	var attack : int
	var magic : int
	var speed : int
	var blocking : bool
	
	func _init() -> void:
		health = 310
		hp = health
		attack = 50
		magic = 25
		speed = 30
		blocking = false
		
func _init(_playerArray, size) -> void:
	playerArray = _playerArray
	populationSize = size
	slime = Slime.new()
	
func simulateFight(player : Player, turnLimit: int) -> float:
	var turn : int = 0
	
	while player.alive and slime.hp > 0 and turn < turnLimit:
		turn += 1
		if(player.data.speed > slime.speed):
			var action = player.choose_action()
			if action == 0:
				slime.hp -= player.data.damage
			elif action == 1:
				#slime.hp -= int(float(player.data.magic) * 0.95)
				slime.hp -= player.data.magic
		else:
			var rand = randi_range(0, 2)
			match rand:
				0:
					player.take_damage(slime.attack)
				1:
					player.take_magic(slime.magic)
				2:
					slime.blocking = true
		
		if(player.hp <= 0 or slime.hp <= 0):
			break
			
		if(player.data.speed <= slime.speed):
			var action = player.choose_action()
			if !slime.blocking:
				if action == 0:
					slime.hp -= player.data.damage
				elif action == 1:
					#slime.hp -= int(float(player.data.magic) * 0.95)
					slime.hp -= player.data.magic
		else:
			var rand = randi_range(0, 1)
			match rand:
				0:
					player.take_damage(slime.attack)
				1:
					player.take_magic(slime.magic)
					
		
	var score : float = 0
	if player.hp > 0 and slime.hp <= 0:
		score += 100
		score += (1 - float(turn) / float(turnLimit)) * 5
	else :
		if player.hp > 0:
			score += float(turn) / float(turnLimit) 
	
	if slime.hp < 0:
		slime.hp = 0
	score += (1 - float(slime.hp) / float(slime.health)) * 2
	
	score += float(player.hp) / float(player.data.health)
	return score

#Make everyone fight against the slime and returns an array of scores
func simulate() -> Array:
	var scoreArray : Array
	for i in range(populationSize):
		slime = Slime.new()
		scoreArray.append(simulateFight(playerArray[i], 20))
		
	#var a = scoreArray.rfind(scoreArray.max())
	#var av = scoreArray[a]
	#scoreArray[a] = 0
	#var b = scoreArray.rfind(scoreArray.max())
	#print(scoreArray[b])
	
	var foo = playerArray.duplicate()
	
	playerArray.sort_custom(func(a, b): return scoreArray[foo.find(a)] > scoreArray[foo.find(b)])
	
	scoreArray.sort()
	scoreArray.reverse()

	return [playerArray, scoreArray]
