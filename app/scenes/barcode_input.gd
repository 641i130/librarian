extends TextEdit

func _ready():
	# Connect the text_changed signal to the _on_text_changed function
	self.grab_focus()
	for book in data_load():
		# Should read in other things besides code
		spawn_book(book[0]) # Use string instead of array

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

func data_load():
	var file = FileAccess.open("user://data.csv", FileAccess.WRITE | FileAccess.READ)
	if file != null:
		var books = []
		while !file.eof_reached():
			var line = file.get_csv_line()
			print(line)
			books.append(line)
		return books
	else:
		return []
	

func spawn_book(code):
	"Spawns a book record"
	code = code.replace("\n","")
	if code != "":
		var book = load("res://scenes/book_record.tscn").instantiate()
		book.get_node("Box/Info/Barcode").text = code
		# Using the code we should retrieve other info about book and import
		# We can add toggles for specific book engines later
		book.get_node("Box/Info/Title").text = "Title: "
		book.get_node("Box/Info/Author").text = "Author: "
		book.get_node("Box/Info/Count").text = "Count: 1"
		get_node("/root/Main/CanvasLayer/ScrollBox/List").add_child(book)

func _on_text_changed():
	# Check if the last character is a newline character
	if text.ends_with("\n"):
		# Make queue of book record
		spawn_book(self.text)
		save(self.text)
		# Clear the TextEdit
		clear()

func _process(delta):
	pass
