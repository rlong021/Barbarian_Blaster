extends Node3D

@export var projectile: PackedScene

var enemy_path: Path3D

@onready var turret_top: MeshInstance3D = $TurretBase/TurretTop

func _physics_process(delta: float) -> void:
	
	var enemy = find_best_target()
	look_at(enemy.global_position,Vector3.UP,true)
	
	

func _on_timer_timeout() -> void:
	var shot = projectile.instantiate()
	add_child(shot)
	shot.global_position = turret_top.global_position
	shot.direction = global_transform.basis.z

func find_best_target() -> PathFollow3D:
	var best_target = null
	var best_progress = 0
	for enemy in enemy_path.get_children():
		if enemy is PathFollow3D:
			if enemy.progress > best_progress:
				best_target = enemy_path
				best_progress = enemy.progress
	return best_target
