extends Node2D

class_name Game
var s
var scl = 25
var food

func _ready():
	s = Snake.new(scl)
	add_child(s)
	s.position = Vector2(0, 0)
	food = pick_location()

func pick_location():
	
	randomize()
	var location
	var cols = get_viewport_rect().size.x / scl
	var rows = get_viewport_rect().size.y / scl
	location = Vector2(floor(rand_range(0, cols)), floor(rand_range(0, rows)))
	location = location * scl
	return location

func _draw():
	# draws a food rectangle
	var rect = Rect2(Vector2(food.x, food.y), Vector2(scl, scl))
	var color = Color(255, 0, 100, 255)
	draw_rect(rect, color, true)

func _input(_event):
	if Input.is_action_just_pressed("ui_up"):
		s.dir(Vector2(0, -1))
	elif Input.is_action_just_pressed("ui_down"):
		s.dir(Vector2(0, 1))
	elif Input.is_action_just_pressed("ui_left"):
		s.dir(Vector2(-1, 0))
	elif Input.is_action_just_pressed("ui_right"):
		s.dir(Vector2(1, 0))
		
func _process(delta):
	s.death()
	if s.eat(food):
		food = pick_location()
		update()
