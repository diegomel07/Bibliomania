extends Control

signal opened
signal closed

var isOpen: bool = false

@onready var inventory: Inventory = preload("res://Inventory/playerInventory.tres")
@onready var slots: Array = $TextureRect/GridContainer.get_children()
var current_item_selected: InventoryItem

func _ready():
	inventory.updated.connect(update)
	
	# Conectar la señal item_clicked de cada slot al método _on_item_clicked
	for slot in slots:
		slot.item_clicked.connect(_on_item_clicked)
	update()

func update():
	for i in range(min(inventory.items.size(), slots.size())):
		slots[i].update(inventory.items[i])

func open():
	visible = true
	isOpen = true
	opened.emit()
	
func close():
	visible = false
	isOpen = false
	closed.emit()
	
	
func _on_item_clicked(item: InventoryItem, currentSlot: Panel):
	
	chekcSlotsBackground(currentSlot)
	
	current_item_selected = item
	
	$DropDown.visible = true

func chekcSlotsBackground(currenteSlot: Panel):
	for i in range(slots.size()):
		if slots[i] != currenteSlot and slots[i].backgroundSprite.frame == 2:
			slots[i].backgroundSprite.frame = 1

func _on_drop_pressed():
	
	# Verificar que el inventario contenga el item antes de eliminarlo
	if current_item_selected in inventory.items:
		# Eliminar el item del inventario
		inventory.items[inventory.items.find(current_item_selected)] = null
		# Emitir la señal de actualización del inventario
		inventory.updated.emit()
		#Emitir la señal de tirar
		inventory.drop(current_item_selected)
		
		# apenas se dropea
		# se debe emitir la señal que sera emitada con el objeto que se dropeo
		# esto hara que el arreglo del inventario de alice que guardo el Recurso lo vuelva a poner en el mapa
		
		# Cerrar el menu
		$DropDown.visible = false


func _on_cancel_pressed():
	inventory.updated.emit()
	if $DropDown.visible == true:
		$DropDown.visible = false
