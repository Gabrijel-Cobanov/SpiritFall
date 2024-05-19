extends CharacterBody2D


@onready var health_component: HealthComponent = $HealthComponent
@onready var no_damage = $Visuals/BreakableWall
@onready var one_hit = $Visuals/BreakableWall2
@onready var two_hits = $Visuals/BreakableWall3

var wall_sprites = []
var current_sprite_index = 0

func _ready():
	wall_sprites = [no_damage, one_hit, two_hits]
	health_component.hurt.connect(Take_Damage)
	health_component.dead.connect(func(): queue_free())
	
func Take_Damage(dmg: int):
	if current_sprite_index < health_component.max_health-1:
		wall_sprites[current_sprite_index].visible = false
		current_sprite_index += 1
		wall_sprites[current_sprite_index].visible = true


