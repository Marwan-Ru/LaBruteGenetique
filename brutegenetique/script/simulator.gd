extends Node

var playerArray : Array
var slime : Slime
var populationSize = 1000

class Slime:
	var hp : int
	var attack : int
	var magic : int
	var speed : int
	
	func _init() -> void:
		hp = 400
		attack = 20
		magic = 20
		speed = 100
		
func _init() -> void:
	slime = Slime.new()
	
	
func _ready() -> void:
	#First generation
	for i in range(populationSize):
		var player : Player = Player.new()
		player.data = PlayerData.from_random(100)
		player.data.randomize_parameter()
		playerArray.append(player)

func simulateFight(player : Player) -> float:
	while player.alive and slime.hp > 0:
		if(player.data.speed > slime.speed):
			var action = player.choose_action()
			if action == 1:
				slime.hp -= player.data.damage
			elif action == 2:
				slime.hp -= player.data.magic
		else:
			var rand = randi_range(0, 1)
			match rand:
				0:
					player.take_damage(slime.attack)
				1:
					player.hp -= slime.magic
		
		if(player.hp <= 0 or slime.hp <= 0):
			break
			
		if(player.data.speed <= slime.speed):
			var action = player.choose_action()
			if action == 1:
				slime.hp -= player.data.damage
			elif action == 2:
				slime.hp -= player.data.magic
		else:
			var rand = randi_range(0, 1)
			match rand:
				0:
					player.take_damage(slime.attack)
				1:
					player.hp -= slime.magic
	return 0

#Make everyone fight against the slime and returns an array of scores
func makeEmFight() -> Array:
	var scoreArray : Array
	for i in range(populationSize):
		scoreArray.append(simulateFight(playerArray[i]))
		
	return scoreArray
