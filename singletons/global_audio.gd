extends Node


func is_playing(audio):
	return get_node(audio).playing


func play(audio):
	get_node(audio).play()
	
	
func stop(audio):
	get_node(audio).stop()
