extends HFlowContainer
# https://icons8.com/icons/set/book
# this 'class' or object is what should be used for calling HTTP requsts and setting the values in here
@onready var http_request = $HTTPRequest

# Called when the node enters the scene tree for the first time.
func _ready():
	var serialized_code = {
		"barcode": $Box/Info/Barcode.text,
	}
	var json = JSON.stringify(serialized_code)
	var headers = ["Content-Type: application/json"]
	print(json)
	http_request.request("http://127.0.0.1:5000/isbn", headers, HTTPClient.METHOD_POST, json)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_http_request_request_completed(result, response_code, headers, body):
	# SET THE title and author and get the image set in here too
	var resp = body.get_string_from_utf8() # De serialize from json to object
	var json = JSON.new()
	var error = json.parse(resp)
	if error == OK && response_code != 404:
		print("Not 404")
		var data_out = json.data
		print(data_out)
		$Box/Info/Title.text = "Title: "+data_out["title"]
		$Box/Info/Author.text = "Author: "+data_out["author"]
