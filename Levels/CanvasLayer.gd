extends CanvasLayer

@onready var settings = $settings

func _ready():
	settings.sett_close()

func _input(event):
	if event.is_action_pressed("toggle_settings"):
		if settings.isOpen:
			settings.sett_close()
		else:
			settings.sett_open()
