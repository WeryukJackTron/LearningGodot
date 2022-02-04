extends TileMap

var grass = 11
var grass_night = 12
var bush = 13
var bush_night = 22
var mushroom = 17
var mushroom_night = 23

var particulas_grass = preload("res://Scenes/PlantParticles.tscn")
var particulas_bush = preload("res://Scenes/BushParticles.tscn")

func _ready():
	for i in tile_set.get_tiles_ids():
		if i == grass:
			var ground_tiles = get_used_cells_by_id(i)
			for j in ground_tiles:
				var particulas_instance = particulas_grass.instance()
				particulas_instance.position = map_to_world(j)
				particulas_instance.position.x += 20
				particulas_instance.position.y += 35
				add_child(particulas_instance)
		elif i == bush:
			var ground_tiles = get_used_cells_by_id(i)
			for j in ground_tiles:
				var particulas_instance = particulas_bush.instance()
				particulas_instance.position = map_to_world(j)
				particulas_instance.position.x += 33
				particulas_instance.position.y += 11
				add_child(particulas_instance)

func _process(delta):
	var tiempo = get_parent().get_node("../GM").getTime()

	if tiempo >= 0.49 && tiempo < 0.79:
		for i in get_children():
			i.set_deferred("visible", true)
		var ground_tiles = get_used_cells_by_id(grass)
		for i in ground_tiles:
			set_cellv(Vector2(i[0],i[1]),grass_night,false,false,false)
		ground_tiles = get_used_cells_by_id(bush)
		for i in ground_tiles:
			set_cellv(Vector2(i[0],i[1]),bush_night,false,false,false)
		ground_tiles = get_used_cells_by_id(mushroom)
		for i in ground_tiles:
			set_cellv(Vector2(i[0],i[1]),mushroom_night,false,false,false)
	else:
		for i in get_children():
			i.set_deferred("visible", false)
		var ground_tiles = get_used_cells_by_id(grass_night)
		for i in ground_tiles:
			set_cellv(Vector2(i[0],i[1]),grass,false,false,false)
		ground_tiles = get_used_cells_by_id(bush_night)
		for i in ground_tiles:
			set_cellv(Vector2(i[0],i[1]),bush,false,false,false)
		ground_tiles = get_used_cells_by_id(mushroom_night)
		for i in ground_tiles:
			set_cellv(Vector2(i[0],i[1]),mushroom,false,false,false)
