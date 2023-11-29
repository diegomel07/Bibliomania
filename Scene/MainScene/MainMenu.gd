extends Control

var settings_screen_path ="res://Scene/MainScene/MainMenu_settings.tscn"
var statistics_screen_path ="res://Scene/MainScene/MainMenu_statistics.tscn"
var Play_screen_path ="res://Scene/MainScene/PlayMenu.tscn"
@onready var Exit = $Exit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_ajustes_pressed():
	get_tree().change_scene_to_file(settings_screen_path)


func _on_estadisticas_pressed():
	get_tree().change_scene_to_file(statistics_screen_path)


func _on_jugar_pressed():
	get_tree().change_scene_to_file(Play_screen_path)


func _on_cerrar_sesion_pressed():
	Exit.sett_open()


func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scene/MainScene/MainMenu.tscn")
