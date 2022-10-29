extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Coin_body_entered(body):
	if body.name == "Player":
		$anim.play("Picked")
		yield(get_node("anim"), "animation_finished")
		queue_free()
