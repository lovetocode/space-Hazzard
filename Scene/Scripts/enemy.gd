class_name Enemy extends Area2D

signal killed(points)

@export var speed = 150
@export var hp = 1
@export var points = 100

signal hit

 # Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	global_position.y += speed * delta
	
func die():
	queue_free()
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_body_entered(body):
	if body is Player:
		body.die()
		queue_free()
		
func take_damage(amount):
	hp -= amount
	if hp <= 0:
		killed.emit(points)
		die()
	else:
		hit.emit()
