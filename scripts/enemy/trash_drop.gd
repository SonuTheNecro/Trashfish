extends Node2D

func timer_timeout_event():
	pass
	#self.queue_free()

func attacked():
	$drop_component._on_delete_timer_timeout()
