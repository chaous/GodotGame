extends Node2D

var noise: = OpenSimplexNoise.new()
var _rng = RandomNumberGenerator.new()
export var start: = -50
var distance: = 100
export var end: = 100
onready var _tile_map : TileMap = $TileMap
onready var start_position: = 10
var bloks_pos: = []
var enemyscene = load("res://str/Actors/Enemy.tscn")
var platform_scene = load("res://str/addons/Platform.tscn")
onready var player = $Player
var death_position : int = 100
var old_start : int
var old_end : int
var from_pixel_to_block = 16
onready var player_pos_y = player.global_position.y / from_pixel_to_block
onready var player_pos_x = player.global_position.x / from_pixel_to_block
var boust_scene = load("res://str/addons/SpeedBoust.tscn")
var enem_kill_sceene = load("res://str/addons/Recucle.tscn")
var coin_sceene = load("res://str/addons/Coin.tscn")




func _ready() -> void:
	randomize()
	spawn_platform(-128 , 0)
	noise.seed = randi()
	generate_platform(10, start, end, 60, 15, 50)

func _process(delta: float) -> void:
	if player:
		player_pos_y = player.global_position.y / from_pixel_to_block
		player_pos_x = player.global_position.x / from_pixel_to_block
		while (player_pos_x > bloks_pos[0][0].x + distance) and (bloks_pos.size() > 1):
			del_one_row(bloks_pos[0])
			bloks_pos.pop_front()
		if player_pos_y > death_position:
			player.die()
		if player_pos_x > end / 2:
			start = end
			end += distance
			gen_world(start + 10, end)



func gen_world(
	start_perm : int,
	end_perm : int
):
	if randi() % 2 == 0:
		generate_platform(
		_rng.randi_range(10, 40),
		 start_perm,
		 end_perm,
		 _rng.randi_range(20, 70),
		 _rng.randi_range(12, 30),
		 _rng.randi_range(12, 33)
		)
	else:
		generate_plat_world(
			start_perm,
			end_perm,
			_rng.randi_range(15, 25),
			_rng.randi_range(13, 17)
		)


func generate_platform(
	curve : int,
	start_perm : int,
	end_perm : int,
	number_of_holes : int,
	lengh_of_wholes : int,
	enemy_prob : int
	):
	var y : int 
	var blok_texture : int
	var count : int
	var block_poition: = []
	var whole_lengh : int
	var lengh_from_whole : int = 10
	for x in range(start_perm, end_perm):
		if count < whole_lengh:
			count += 1
			continue
		if (randi() % number_of_holes == 0) and (lengh_from_whole == 0):
			count = 0
			whole_lengh = _rng.randi_range(10, lengh_of_wholes)
			lengh_from_whole = 12
		y = start_position + noise.get_noise_1d(x) * curve
		blok_texture = get_text(noise.get_noise_2d(x, y) + 1.0)
		#print(blok_texture)
		_tile_map.set_cell(x, y, blok_texture)
		_tile_map.set_cell(x, y - 1, 9)
		block_poition.append(Vector2(x, y))
		block_poition.append(Vector2(x, y - 1))
		if randi() % enemy_prob == 0  and lengh_from_whole == 0: 
			spawn_emamy(x * 16, (y - 3) * 16)
			lengh_from_whole = 15
		if randi() % 200 == 0 and lengh_from_whole < 12:
			 spawn_speed_bonus(x * 16, (y - 3) * 16)
			 lengh_from_whole = 3
		if lengh_from_whole != 0:
			lengh_from_whole -=1
		for i in range(y, y + 30 + curve):
			blok_texture = get_text(noise.get_noise_2d(x, i) + 1.0)
			_tile_map.set_cell(x, i, blok_texture)
			block_poition.append(Vector2(x, i))
		bloks_pos.append(block_poition.slice(0, -1))
		block_poition.clear()


func generate_plat_world(
	start_perm : int,
	end_perm : int,
	max_leng_wholes : int,
	hight : int
):
	start_perm *= from_pixel_to_block
	end_perm *= from_pixel_to_block
	hight *= from_pixel_to_block
	max_leng_wholes *= from_pixel_to_block
	var y : int
	var x : int = start_perm
	while x <= end_perm:
		y = start_position * from_pixel_to_block + noise.get_noise_1d(x) * hight
		var size_plat = spawn_platform(x, y)
		x += _rng.randi_range(160, max_leng_wholes) + size_plat 
	start = x / 16 #- 10



func get_text(x : int):
	if x == 0:
		return 0
	if x == 1:
		return 5


func clean_area(blocks : Array):
	for pos in blocks:
		for vec in pos:
			_tile_map.set_cell(vec.x, vec.y, -1)
	blocks.clear()

func del_one_row(block : Array):
	for vec in block:
		_tile_map.set_cell(vec.x, vec.y, -1)


func spawn_platform(x : int, y : int) -> int:
	var platform = platform_scene.instance()
	var change_size = _rng.randf_range(0.4, 2)
	platform.position.y = y
	platform.scale.x *= change_size
	platform.position.x = x + platform.scale.x * 128
	$TileMap.add_child(platform)
	if randi() % 60 == 0:
		spawn_speed_bonus(x, y - 60)
	return platform.scale.x * 128



func spawn_emamy(x : int, y : int):
	var enemy = enemyscene.instance()
	enemy.position.y = y
	enemy.position.x = x
	$TileMap.add_child(enemy)




func spawn_speed_bonus(x : int, y : int):
	var rand_num = randi() % 3
	if rand_num == 0:
		var speed_boust = boust_scene.instance()
		speed_boust.position.y = y
		speed_boust.position.x = x
		$TileMap.add_child(speed_boust)
	elif rand_num == 1:
		var enem_kill = enem_kill_sceene.instance()
		enem_kill.position.y = y
		enem_kill.position.x = x
		$TileMap.add_child(enem_kill)
	else:
		var coin = coin_sceene.instance()
		coin.position.y = y
		coin.position.x = x
		$TileMap.add_child(coin)


func spawn_platform_with_out_size(x : int, y : int) -> int:
	var platform = platform_scene.instance()
	var change_size = 1.0
	platform.position.y = y
	platform.scale.x *= change_size
	platform.position.x = x + platform.scale.x * 128
	$TileMap.add_child(platform)
	if randi() % 60 == 0:
		spawn_speed_bonus(x, y - 60)
	return platform.scale.x * 128

func _on_Player_spawn_platform() -> void:
	spawn_platform_with_out_size(player.global_position.x, player.global_position.y + 100)
