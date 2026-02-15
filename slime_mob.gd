extends RigidBody3D

@export var health = 5
@export var splitFlag = true
@export var isDead = false
@onready var slime_model = %slime_model
var spd = randf_range(2.0, 4.0)
var itemDropChance = 1#randi_range(1,2)
var itemTypeChance = 4#randi_range(1,3)
#signal died

@onready var player = get_node("/root/game/Player")

func _physics_process(_delta):
	var horizontal_dir = Vector3(player.global_position.x - global_position.x, 1, player.global_position.z - global_position.z).normalized()
	
	linear_velocity.x = horizontal_dir.x * spd
	linear_velocity.z = horizontal_dir.z * spd
	linear_velocity.y = clamp(0, -spd, spd)
	
	var dist_to_player = global_position.distance_to(player.global_position)
	if dist_to_player > 0.5:
		var look_target = Vector3(player.global_position.x, 0, player.global_position.z)
		
		if abs(look_target.x - global_position.x) < 0.1 and abs(look_target.z - global_position.z) < 0.1:
			look_target.x += 0.1
			
		slime_model.look_at(look_target, Vector3.UP)
	
func do_damage():
	print("Visible for debug purposes and necessary for damage calculation.")
	
func take_damage():
	#slime_model.hurt()
	health -= 1
	if(health == 0):
		queue_free()
		if(splitFlag):
			split_on_death()
		if(itemDropChance == 1):
			print("Item Type Chance: ", itemTypeChance)
			if(itemTypeChance == 1):
				print("Dropped pills")
				const PILLS = preload("res://ItemScenes/Pills.tscn")
				var pills_item = PILLS.instantiate()
				get_tree().current_scene.add_child(pills_item)
				pills_item.global_position = %slime_model.global_position
				pills_item.global_position += 0.8
				
			if(itemTypeChance == 2):
				print("Dropped beans")
				const BEANS= preload("res://ItemScenes/Beans.tscn")
				var beans_item = BEANS.instantiate()
				get_tree().current_scene.add_child(beans_item)
				beans_item.global_position = %slime_model.global_position
				beans_item.global_position += 0.8
				
			if(itemTypeChance == 3):
				print("Dropped adrenaline")
				const ADREN = preload("res://ItemScenes/Adrenaline.tscn")
				var adren_item = ADREN.instantiate()
				get_tree().current_scene.add_child(adren_item)
				adren_item.global_position = %slime_model.global_position
				adren_item.global_position += 0.8
				
			if(itemTypeChance == 4):
				print("Dropped harpy feather")
				const HARPY = preload("res://ItemScenes/HarpyFeather.tscn")
				var harpy_item = HARPY.instantiate()
				get_tree().current_scene.add_child(harpy_item)
				harpy_item.global_position = %slime_model.global_position
				harpy_item.global_position += 0.8
				
func split_on_death():
	
	const SLIME1 = preload("res://Scenes/slime_mob.tscn")
	const SLIME2 = preload("res://Scenes/slime_mob.tscn")
	const SLIME3 = preload("res://Scenes/slime_mob.tscn")
	
	var slime1 = SLIME1.instantiate()
	var slime2 = SLIME1.instantiate()
	var slime3 = SLIME1.instantiate()
	
	slime1.name = "slime1"
	slime2.name = "slime2"
	slime3.name = "slime3"
	
	get_tree().current_scene.add_child(slime1)
	get_tree().current_scene.add_child(slime2)
	get_tree().current_scene.add_child(slime3)
	
	slime1.global_position = %slime_model.global_position
	slime1.global_position.x = %slime_model.global_position.x - 2
	
	slime2.global_position = %slime_model.global_position
	slime2.global_position.z = %slime_model.global_position.z + 2	
	
	slime3.global_position = %slime_model.global_position
	slime3.global_position.z = %slime_model.global_position.z - 2		
	
	slime1.splitFlag = false
	slime2.splitFlag = false
	slime3.splitFlag = false
	
	slime1.health = 1
	slime2.health = 1
	slime3.health = 1
	
	slime1.scale = %slime_model.scale * 0.75
	slime2.scale = %slime_model.scale * 0.75
	slime3.scale = %slime_model.scale * 0.75
	
	
