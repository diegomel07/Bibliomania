extends Control

signal opened
signal closed
var isOpen: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func sett_open():
	visible = true
	isOpen = true
	$TextureRect.show()
	opened.emit()


func _on_no_pressed():
	visible = false
	isOpen = false	
	$TextureRect.hide()
	closed.emit()
