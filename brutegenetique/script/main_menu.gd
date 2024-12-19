extends Control

var main_scene

func _ready() -> void:
	main_scene = preload("res://Scene/Main.tscn").instantiate()

func _on_button_play_pressed() -> void:
	get_tree().root.add_child(main_scene)
	get_tree().root.remove_child(get_tree().root.get_child(0))

func _on_button_quit_pressed() -> void:
	get_tree().quit()
