extends Node3D

@onready var debris: GPUParticles3D = $Debris
@onready var fire: GPUParticles3D = $Fire
@onready var smoke: GPUParticles3D = $Smoke
@onready var explosion_sound: AudioStreamPlayer = $ExplosionSound

func _ready():
	debris.one_shot = true
	smoke.one_shot = true
	fire.one_shot = true
	explosion_sound.play()
	await get_tree().create_timer(2.0).timeout
	queue_free()
