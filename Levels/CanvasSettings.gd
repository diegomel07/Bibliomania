extends CanvasLayer

@onready var inventory = $"../CanvasInventory/inventory"
@onready var settings = $SettingsNode

func _ready():
	settings.sett_close()

func _input(event):
	if event.is_action_pressed("toggle_settings") and inventory.isOpen == false:
		if settings.isOpen:
			settings.sett_close()
		else:
			settings.sett_open()
