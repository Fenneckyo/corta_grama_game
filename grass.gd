extends Node2D 
class_name grass

var grama := preload("res://grama.tscn")
@export var mark2d:Marker2D
@export var GrassQuantity:int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if GrassQuantity>0:
		for i in GrassQuantity:
			var position_x=randi_range(0,256)
			var instancia=grama.instantiate()
			add_child(instancia)
			instancia.position.x=position_x
			instancia.position.y=mark2d.position.y
			print(instancia.position)
	pass # Replace with function body.

	child_order_changed.connect(on_child_changed)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_child_changed():
	if get_child_count()==0:
		print("parabens")
func on_removed_grass(grass_ID:Node2D):
	print("hell_yeah")
