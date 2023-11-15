extends CanvasLayer

@onready var inventory = $inventory
@onready var settings = $"../CanvasSettings/SettingsNode"

func _ready():
	inventory.close()

func _input(event):
	if event.is_action_pressed("toggle_inventory") and settings.isOpen == false:
		if inventory.isOpen:
			inventory.close()
		else:
			inventory.open()
