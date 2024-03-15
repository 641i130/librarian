from flask import Flask, request, jsonify
import requests

app = Flask(__name__)

def isbn_lookup(isbn):
    "Searching isbn requst to pull information"
    url = "https://openlibrary.org/search.json?q=" + str(isbn)
    response = requests.get(url)
    if response.status_code == 200:
        # Parse the HTML content
        d = response.json()
        if d['numFound'] != 0:
            title = d['docs'][0]['title']
            print(title)
        else:
            title = "not found"
    img_url = "https://covers.openlibrary.org/b/isbn/" + str(isbn) + "-M.jpg"
    out = {
        "title": str(title),
        "author": "",
        "image_url": str(img_url)
    }
    return jsonify(out)

    #else:
    #    # Handle errors when the request fails
    #    print("Failed to fetch data from the URL")
    #    return jsonify({"error": "Not found"}), 404


@app.route('/isbn', methods=['POST'])
def get_book_details():
    data = request.get_json()
    barcode = data.get('barcode')
    return isbn_lookup(barcode)
    #if barcode in book_data:
    #    return jsonify(book_data[barcode])
    #else:
    #    return jsonify({"error": "Not found"}), 404

if __name__ == '__main__':
    app.run(debug=True)

