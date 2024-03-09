extends TextEdit

func _ready():
	# Connect the text_changed signal to the _on_text_changed function
	self.grab_focus()

func save(content):
	var file = FileAccess.open("user://data.csv", FileAccess.WRITE | FileAccess.READ)
	if file != null:
		file.seek_end()
		file.store_string(content)
		file.close()
	else:
		file = FileAccess.open("user://data.csv", FileAccess.WRITE)
		file.store_string(content)
		file.close()

func load():
	var file = FileAccess.open("user://data.csv", FileAccess.READ)
	var content = file.get_as_text()
	return content

func _on_text_changed():
	# Check if the last character is a newline character
	if text.ends_with("\n"):
		print(self.text)
		save(self.text)
		# Make queue of book record
		var book = load("res://scenes/book_record.tscn").instantiate()
		book.get_node("Button").text = self.text
		get_node("/root/Main/CanvasLayer/ScrollBox/List").add_child(book)
		# Add to database
		# Once its in the database, search ISBN or kinokuniya for the record data and display? or put into database
		
		# Clear the TextEdit
		clear()

func _process(delta):
	pass
