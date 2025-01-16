extends Node

var breeder  : Breeder
var simulator: Simulator
var population: Array
var population_size: int

func _ready() -> void:
	population_size = 500
	breeder = Breeder.new(0.01)
	population.resize(population_size)
	
	#for k in range(100):
		#for i in range(population_size):
			#population[i] = Player.new(PlayerData.from_random(100))
		#var res = []
		#for i in range(200):
			#simulator = Simulator.new(population, population_size)
			#res = simulator.simulate()
			#breeder.set_source(res[0].slice(0, 10).map(func(a): return a.data))
			#var data = breeder.new_generation(population_size)
			#
			#for j in range(population_size):
				#population[j] = Player.new(data[j])
				#
		#print(res[1].slice(0, 10).map(func(a): return "%.2f" % a))
		
	for i in range(population_size):
		population[i] = Player.new(PlayerData.from_random(100))	
	
	for i in range(1000):	
			simulator = Simulator.new(population, population_size)
			var res = simulator.simulate()
			print(res[0].slice(0, 2).map(func(a): return a.data))
			print(res[1].slice(0, 10).map(func(a): return "%.2f" % a))
			breeder.set_source(res[0].slice(0, 10).map(func(a): return a.data))
			var data = breeder.new_generation(population_size)
			
			for j in range(population_size):
				population[j] = Player.new(data[j])
	
	
