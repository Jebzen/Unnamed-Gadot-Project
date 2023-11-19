extends Camera2D

# Set the minimum and maximum zoom levels.
var min_zoom_level: float = 0.5
var max_zoom_level: float = 3.0

func _ready():
	# Set the initial zoom level.
	zoom = Vector2(min_zoom_level, min_zoom_level)

func _input(event):
	#if event is InputEventMouseMotion and event.relative.length() > 0:
		# Check for scroll wheel events.
		#if event.relative.y < 0: # Scroll up, zoom in
			#zoom_in()
		#elif event.relative.y > 0: # Scroll down, zoom out
			#zoom_out()
	if(event is InputEventMouseButton and event.is_pressed()):
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom_out()
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom_in()

func zoom_in():
	var new_zoom: Vector2 = zoom - Vector2(0.1, 0.1) # Decrease the zoom vector to zoom in.
	zoom = new_zoom.clamp(Vector2(min_zoom_level, min_zoom_level), Vector2(max_zoom_level, max_zoom_level))

func zoom_out():
	var new_zoom: Vector2 = zoom + Vector2(0.1, 0.1) # Increase the zoom vector to zoom out.
	zoom = new_zoom.clamp(Vector2(min_zoom_level, min_zoom_level), Vector2(max_zoom_level, max_zoom_level))
