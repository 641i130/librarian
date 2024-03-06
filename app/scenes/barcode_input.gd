extends TextEdit


# Called when the node enters the scene tree for the first time.

func _ready():
	# Connect the text_changed signal to the _on_text_changed function
	self.grab_focus()

func _on_text_changed():
	# Check if the last character is a newline character
	if text.ends_with("\n"):
		# Clear the TextEdit
		print(self.text)
		clear()

func _process(delta):
	pass
