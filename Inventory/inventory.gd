extends Resource

class_name Inventory

signal updated
signal droped(item: InventoryItem)

@export var items: Array[InventoryItem]

func insert(item: InventoryItem):
	for i in range(items.size()):
		if !items[i] and item not in items:
			items[i] = item
			break
	updated.emit()

func drop(item: InventoryItem):
	droped.emit(item)

	# el usuario clickea en el objeto
	# esta accion genera una señal
	# esta señal es recibida en la base o nivel
	# esto envia el objeto que se clickeo
	# en el el nivel o base se coloca el objeto clickeado por el usuaario
	# se eliminad el inventario
	# se da un tiempo limite para que el usuario pueda moverse y no volverlo a coger
