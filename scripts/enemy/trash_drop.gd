extends Node2D

func timer_timeout_event():
	pass
	#self.queue_free()

func attacked():
	self.queue_free()
