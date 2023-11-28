extends CanvasLayer

@onready var inventory = $inventory
@onready var settings = $SettingsNode

func _ready():
	settings.sett_close()
	inventory.close()

func _input(event):
	if event.is_action_pressed("toggle_inventory") and settings.isOpen == false:
		if inventory.isOpen:
			inventory.close()
		else:
			inventory.open()
	
	if event.is_action_pressed("toggle_settings") and inventory.isOpen == false:
		if settings.isOpen:
			settings.sett_close()
		else:
			settings.sett_open()
