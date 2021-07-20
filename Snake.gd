extends Node2D

class_name Snake

var x_speed
var y_speed
var scl

var x_pos
var y_pos

var total = 0
var tail = []

func _init(var scale):
	self.scl = scale
	self.x_speed = 0
	self.y_speed = 0
	
	self.total = 0
	self.tail = []
	
	self.x_pos = 0
	self.y_pos = 0

func _ready():
	pass
	
func _draw():
	var color = Color(255, 255, 255, 255)
	for i in tail.size():
		draw_rect(Rect2(Vector2(tail[i]), Vector2(scl, scl)), color)
	var rect = Rect2(Vector2(x_pos, y_pos), Vector2(scl, scl))
	draw_rect(rect, color)
	
func eat(var pos: Vector2):
	var dis = Vector2(x_pos, y_pos).distance_to(pos)
	if dis < 1:
		total += 1
		return true
	else:
		return false
		
func death():
	for i in self.tail.size():
		var pos = self.tail[i]
		var dis = Vector2(x_pos, y_pos).distance_to(pos)
		if dis < 1:
			print(tail[i])
			print("you dead!")
			tail = []
			total = 0
			return

func dir(var dir: Vector2):
	self.x_speed = dir.x
	self.y_speed = dir.y

func _process(_delta):
	update()
	if self.total > self.tail.size():
		self.tail.append(null)

	for i in range(tail.size()-1, -1, -1):
		if i != 0:
			tail[i] = tail[i - 1]
	
	if self.total >= 1:
		self.tail[0] = Vector2(x_pos, y_pos)
	
	x_pos += self.x_speed * scl
	y_pos += self.y_speed * scl
	
	x_pos = clamp(x_pos, 0, get_viewport_rect().size.x - scl)
	y_pos = clamp(y_pos, 0, get_viewport_rect().size.y - scl)
