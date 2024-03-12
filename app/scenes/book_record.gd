extends HFlowContainer

# this 'class' or object is what should be used for calling HTTP requsts and setting the values in here

# Called when the node enters the scene tree for the first time.
func _ready():
	$Box/Info/Title.text = "IT WORKETHS"
	print($Box/Info/Barcode.text) # ENTRY POINT FOR HTTP REQUEST


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
