extends RigidBody2D

const MAX_EXPAND = 2.05
const EXPAND_SPEED = 1

var expand = 1
var original_position = Vector2()

func _ready():
	freeze = true
	original_position = global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not freeze:
		expand += EXPAND_SPEED * delta
		expand = min(MAX_EXPAND, expand)
		
		$CollisionShape2D.shape.size = Vector2(expand, expand) * 16
		$Sprite2D.scale = ($CollisionShape2D.shape.size.floor() / Vector2(16, 16))
	
	
func _integrate_forces(state):
	if not freeze and expand != MAX_EXPAND:
		for i in range(state.get_contact_count()):
			var collider = state.get_contact_collider_object(i)
			if state.get_contact_collider_velocity_at_position(i).length() > 128:
				$AudioImpact.play()
			if collider is RigidBody2D:
				collider.apply_impulse(-state.get_contact_local_normal(i)*EXPAND_SPEED*4, Vector2())#collider.to_local(to_global(state.get_contact_collider_position(i))))
