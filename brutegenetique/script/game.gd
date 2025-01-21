extends Node

var breeder  : Breeder
var simulator: Simulator
var population: Array
var current_gen: int
var _best_score: float

@export
var lhs_best: Control
@export
var rhs_best: Control
@export
var n_gen: Label
@export
var best_score: Label
@export
var population_size: int
@export
var mutation_rate: float

func _ready() -> void:
	breeder = Breeder.new(mutation_rate)
	current_gen = 0
	_best_score = 0.0
				
func on_request_new_gen(n: int) -> void:
	var res = []
	for i in range(n):
		if current_gen > 0:
			breeder.set_source(population.slice(0, 10).map(func(a): return a.data))
			var data = breeder.new_generation(population_size)
			for j in range(population_size):
				population[j].reset(data[j])
		else:
			population.resize(population_size)
			for j in range(population_size):
				population[j] = Player.new(PlayerData.from_random(200))
				
		current_gen += 1
		simulator = Simulator.new(population, population_size)
		res = simulator.simulate()
	
	(lhs_best.get_node("Label") as Label).text  = "Vie            %d"    % res[0][0].data.health
	(lhs_best.get_node("Label2") as Label).text = "Degats         %d "   % res[0][0].data.damage
	(lhs_best.get_node("Label3") as Label).text = "Magie          %d "   % res[0][0].data.magic
	(lhs_best.get_node("Label4") as Label).text = "Soin           %d "   % res[0][0].data.heal
	(lhs_best.get_node("Label5") as Label).text = "Vitesse        %d "   % res[0][0].data.speed
	(lhs_best.get_node("Label6") as Label).text = "Proba degats   %.2f " % (res[0][0].data.damage_attack * 100.0)
	(lhs_best.get_node("Label7") as Label).text = "Proba magie    %.2f " % (res[0][0].data.magic_attack  * 100.0)
	(lhs_best.get_node("Label8") as Label).text = "Proba heal     %.2f " % (res[0][0].data.perform_heal  * 100.0)
	(lhs_best.get_node("Label9") as Label).text = "Proba blocage  %.2f " % (res[0][0].data.block_attack	* 100.0)
	(lhs_best.get_node("Label10") as Label).text= "Score          %.2f " % res[1][0]
	
	(rhs_best.get_node("Label") as Label).text  = "Vie            %d"    % simulator.slime.health
	(rhs_best.get_node("Label2") as Label).text = "Degats         %d "   % simulator.slime.attack
	(rhs_best.get_node("Label3") as Label).text = "Magie          %d "   % simulator.slime.magic
	(rhs_best.get_node("Label4") as Label).text = "Vitesse        %d "   % simulator.slime.speed
	
	_best_score = maxf(_best_score, res[1][0])
	
	best_score.text = "%.2f" % _best_score
	n_gen.text = "%d" % current_gen
	
	population = res[0]
