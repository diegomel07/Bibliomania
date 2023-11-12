extends Panel

signal item_clicked(inventoryItem, slot)

@onready var backgroundSprite: Sprite2D = $background
@onready var itemSprite: Sprite2D = $CenterContainer/Panel/item

var inventoryItem: InventoryItem

func update(item: InventoryItem):
	inventoryItem = null
	if !item:
		backgroundSprite.frame = 0
		itemSprite.visible = false
	else:
		inventoryItem = item
		backgroundSprite.frame = 1
		itemSprite.visible = true
		itemSprite.texture = item.texture

func _on_button_pressed():
	
	if backgroundSprite.frame == 1:
		backgroundSprite.frame = 2
	
	if inventoryItem:
		# Emitir una señal para indicar que el usuario hizo clic en un slot con un objeto
		item_clicked.emit(inventoryItem, $".")
