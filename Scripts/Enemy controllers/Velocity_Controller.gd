extends Node
class_name Velocity_Controller

# The velocity controller is intended for enemies, that's how
# they will move and it will allow for control of where they go
# when knocked back, while the knockback component still stays
# as a delegator, an intermedaite communicator
# in combat, the entity, when striking upon an entity is going to look for
# a health component and a knockback component, this is
# so it's flexible, something can be tossed around but not destroyed,
# and some things can be destroyed but not knocked back
var CB2D: CharacterBody2D
