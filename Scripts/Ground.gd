extends TileMap

var particulas = preload("res://Scenes/GrassParticles.tscn")

func _ready():
	for i in tile_set.get_tiles_ids():
		if i != 2:
			var ground_tiles = get_used_cells_by_id(i)
			for j in ground_tiles:
				var particulas_instance = particulas.instance()
				particulas_instance.position = map_to_world(j)
				particulas_instance.position.x += 32
				add_child(particulas_instance)

func _process(delta):
	var tiempo = get_parent().get_node("../GM").getTime()
	
	if tiempo >= 0.49 && tiempo < 0.79:
		for i in get_children():
			i.set_deferred("visible", true)
		var ground_tiles = get_used_cells_by_id(3)
		for i in ground_tiles:
			set_cellv(Vector2(i[0],i[1]),0,false,false,false)
		ground_tiles = get_used_cells_by_id(1)
		for i in ground_tiles:
			set_cellv(Vector2(i[0],i[1]),4,false,false,false)
		ground_tiles = get_used_cells_by_id(5)
		for i in ground_tiles:
			set_cellv(Vector2(i[0],i[1]),6,false,false,false)
	else:
		for i in get_children():
			i.set_deferred("visible", false)
		var ground_tiles = get_used_cells_by_id(0)
		for i in ground_tiles:
			set_cellv(Vector2(i[0],i[1]),3,false,false,false)
		ground_tiles = get_used_cells_by_id(4)
		for i in ground_tiles:
			set_cellv(Vector2(i[0],i[1]),1,false,false,false)
		ground_tiles = get_used_cells_by_id(6)
		for i in ground_tiles:
			set_cellv(Vector2(i[0],i[1]),5,false,false,false)
