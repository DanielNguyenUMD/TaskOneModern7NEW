extends RigidBody3D

@export var health = 5
@export var splitFlag = true
@export var isDead = false
@onready var slime_model = %slime_model
var spd = randf_range(2.0, 4.0)
var itemDropChance = 1#randi_range(1,2)
var itemTypeChance = 4#randi_range(1,3)
signal died
