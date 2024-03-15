extends TextEdit
var books = [] # GLOBAL Array of books

func _ready():
	# Connect the text_changed signal to the _on_text_changed function
	self.grab_focus()
	load_books()

# Save function
func save_books() -> void:
	print("SAVING")
	var file = FileAccess.open("user://data.csv", FileAccess.WRITE)
	# Serialize each book and save to file
	for book in books:
		var serialized_book = book.out()
		file.store_line(JSON.stringify(serialized_book))
	file.close()

# Load function
# Get load and save functions to save list of books, then work on book lookups using get requests and HTML parsing...
func load_books():
	var file = FileAccess.open("user://data.csv", FileAccess.READ)
	if file:
		while not file.eof_reached():
			var line = file.get_line().strip_edges()
			var json = JSON.new()
			var error = json.parse(line)
			if error == OK:
				var data_out = json.data
				var book = Book.new(data_out["barcode"])
				book.title = data_out["title"]
				book.author = data_out["author"]
				book.barcode = data_out["barcode"]
				book.count = data_out["count"]
				book.url = data_out["url"]
				books.append(book)
				get_node("/root/Main/CanvasLayer/ScrollBox/List").add_child(book.draw())

func spawn_book(code):
	"Spawns a book record"
	code = code.replace("\n","")
	if code != "":
		# Update or create book
		# check if book in list
		var dupe_check = 0
		for book in books:
			print("checking", book)
			if code == book.barcode:
				print("duplicate!")
				book.count+=1
				book.update_count()
				save_books()
				dupe_check = 1
				return
		if dupe_check == 0:
			var booker = Book.new(code)
			books.append(booker)
			save_books()
			get_node("/root/Main/CanvasLayer/ScrollBox/List").add_child(booker.draw())
			

func _on_text_changed():
	# Check if the last character is a newline character
	if text.ends_with("\n"):
		# Make queue of book record
		spawn_book(self.text)
		# Clear the TextEdit
		clear()
		
func _process(delta):
	if Input.is_action_just_pressed("exit_game"):
		on_exit_game_pressed()

func on_exit_game_pressed():
	# Perform any necessary actions here before closing the game
	save_books()
	# After performing necessary actions, close the game
	get_tree().quit()


