extends Node

var playerArray : Array
var slime : Slime
var populationSize = 1000

class Slime:
	var health : int
	var hp : int
	var attack : int
	var magic : int
	var speed : int
	
	func _init() -> void:
		health = 1000
		hp = health
		attack = 10
		magic = 10
		speed = 50
		
func _init() -> void:
	slime = Slime.new()
	
func simulateFight(player : Player, turnLimit: int) -> float:
	var turn : int = 0
	var damage = 0
	
	while player.alive and slime.hp > 0 and turn < turnLimit:
		turn += 1
		if(player.data.speed > slime.speed):
			var action = player.choose_action()
			if action == 1:
				slime.hp -= player.data.damage
				damage += player.data.damage
			elif action == 2:
				slime.hp -= player.data.magic
				damage += player.data.magic
		else:
			var rand = randi_range(0, 1)
			match rand:
				0:
					player.take_damage(slime.attack)
				1:
					player.take_magic(slime.magic)
		
		if(player.hp <= 0 or slime.hp <= 0):
			break
			
		if(player.data.speed <= slime.speed):
			var action = player.choose_action()
			if action == 1:
				slime.hp -= player.data.damage
				damage += player.data.damage
			elif action == 2:
				slime.hp -= player.data.magic
				damage += player.data.magic
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
		score += 1 - float(turn) / float(turnLimit)
	else :
		score += float(turn) / float(turnLimit)
	
	if slime.hp < 0:
		slime.hp = 0
	score += 1 - float(slime.hp) / float(slime.health)
	
	score += float(player.hp) / float(player.data.health)
	return score

#Make everyone fight against the slime and returns an array of scores
func simulate() -> Array:
	var scoreArray : Array
	for i in range(populationSize):
		slime = Slime.new()
		scoreArray.append(simulateFight(playerArray[i], 10))
		
	return scoreArray
