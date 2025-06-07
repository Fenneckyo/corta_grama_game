extends Sprite2D


func _on_level_1_se_esforçando(esforco_atual: float,limite:float) -> void:
	
	if esforco_atual > 0 && esforco_atual<limite/6:
		frame=0
	elif esforco_atual>limite/6 && esforco_atual<limite/3:
		frame=1
	elif esforco_atual>limite/3 && esforco_atual<limite:
		frame=2
	elif esforco_atual>=limite:
		frame=1
	print(esforco_atual)
	pass # Replace with function body.
