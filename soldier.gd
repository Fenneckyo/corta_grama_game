extends Node

@export var thresholder:float=10 #threshold for how much strenght is needed for removing the grass
@export var progress_resistance:float
var progress:float=0  #value for the current progress to remove grass
@export var add_progress:float=0.5 #self explanatory
@export var grass:grass#grab the grass manager
@onready var recruta_sprite:=$Recruta
@onready var congratulation:Label
var ganhou:bool=false
var ID_pos:int=0 #I get all the children from the grass then
			  #I organize in a array to change position based on the children position
var ID_actual_Pos:int=0
var ID_last_Pos:int=0
signal removed_grass(grass_ID:Node2D)
signal se_esforçando(esforco_atual:float, limite:float)
signal changed_position()

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	
	ID_pos=grass.get_child_count()
	ID_actual_Pos=ID_pos-1
	print(grass.get_child_count())
	removed_grass.connect(grass.on_removed_grass.bind())
	removed_grass.connect(on_removed_grass)
	recruta_sprite.position.x=grass.get_child(ID_actual_Pos).position.x
	pass # Replace with function body.
	changed_position.connect(on_changed_position.bind())

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:
	if !ganhou:
		progress_gameplay(delta)
		movement()
	else:
		pass #vai aparecer um ui dizendo pra passar pro proximo nivel
	
	pass
func movement():
	if Input.is_action_just_pressed("ui_left"):
		if(ID_actual_Pos > 0): #se 2 for maior ou igual a 0
			ID_last_Pos=ID_actual_Pos
			ID_actual_Pos-=1
			changed_position.emit()
	elif Input.is_action_just_pressed("ui_right"):
		if(ID_actual_Pos < ID_pos-1): #tecnicamente zero ainda conta dae vai de 0 a 4 ao invez de 5
			ID_last_Pos=ID_actual_Pos
			ID_actual_Pos+=1
			changed_position.emit()
			

func progress_gameplay(delta:float):
	#progress bar decreasing by 0.5 sec
	if progress>0:
		progress-=progress_resistance*delta
		se_esforçando.emit(progress,thresholder)
	#but you can increase it by the add_progress by pressing the button
	if Input.is_action_just_pressed("action"):
		progress+=add_progress
		se_esforçando.emit(progress,thresholder)
		
	#when reach the thresholder it will reset and emit a signal
	if progress>=thresholder:
		progress=0
		removed_grass.emit(grass.get_child(ID_actual_Pos))
		se_esforçando.emit(progress,thresholder)


	

func on_changed_position():
	#eu aplico a posição do filho de grass de acordo com a posição ID atual/ID_actual_Pos
	print(ID_actual_Pos)
	print(ID_last_Pos)
	print(ID_pos)
	
	recruta_sprite.position.x=grass.get_child(ID_actual_Pos).position.x
	pass
func on_removed_grass(grass_ID:Node2D):
	if grass_ID:
		grass_ID.queue_free()

	ID_pos=grass.get_child_count()
	
	ID_last_Pos=ID_actual_Pos
	
	ID_actual_Pos-=1
	changed_position.emit()
	
	pass
	


func _on_grass_child_order_changed() -> void:
	if grass.get_child_count()==0:
		ganhou=true
		get_parent().get_child(1).get_child(0).get_child(1).visible=true
	ID_pos=grass.get_child_count()
	pass # Replace with function body.
