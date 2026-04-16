extends CharacterBody2D

@export var velocidade: float = 100.0

@onready var animation: AnimatedSprite2D = $Anim

var ultima_direcao := "baixo"

func _physics_process(delta):
	var input_dir := Vector2.ZERO
	
	input_dir.x = Input.get_action_strength("direita") - Input.get_action_strength("esquerda")
	input_dir.y = Input.get_action_strength("baixo") - Input.get_action_strength("cima")
	
	input_dir = input_dir.normalized()
	velocity = input_dir * velocidade
	
	move_and_slide()
	
	atualizar_animacao(input_dir)

func atualizar_animacao(dir: Vector2) -> void:
	if animation == null:
		return
	
	# PARADO
	if dir == Vector2.ZERO:
		var nome_idle = "parado_" + ultima_direcao
		if animation.sprite_frames.has_animation(nome_idle):
			animation.play(nome_idle)
		return
	
	# MOVIMENTO
	if abs(dir.x) > abs(dir.y):
		if dir.x > 0:
			ultima_direcao = "direita"
		else:
			ultima_direcao = "esquerda"
	else:
		if dir.y > 0:
			ultima_direcao = "baixo"
		else:
			ultima_direcao = "cima"
	
	animation.play(ultima_direcao)
