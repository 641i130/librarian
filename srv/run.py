from flask import Flask, request, jsonify
import requests
from lxml import html

app = Flask(__name__)

# Mock data for demonstration purposes
book_data = {
    "9780064471107": {
        "title": "The Magician's Nephew",
        "author": "C. S. Lewis",
        "image_url": "https://images.isbndb.com/covers/11/07/9780064471107.jpg"
    }
}


headers = {
    'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0',
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8',
    'Accept-Language': 'en-US,en;q=0.5',
    'Referer': 'https://isbnsearch.org/',
    'DNT': '1',
    'Connection': 'keep-alive',
    'Upgrade-Insecure-Requests': '1',
    'Sec-Fetch-Dest': 'document',
    'Sec-Fetch-Mode': 'navigate',
    'Sec-Fetch-Site': 'same-origin',
    'Sec-Fetch-User': '?1',
}

def isbn_lookup(isbn):
    "Searching isbn requst to pull information"
    url = 'https://isbnsearch.org/isbn/' + str(isbn)
    response = requests.get(url, headers=headers)
    
    if response.status_code == 200:
        # Parse the HTML content
        tree = html.fromstring(response.content)
        # Find important info:
        # Title
        # /html/body/div/div[1]/div[2]/h1
        title = tree.xpath("/html/body/div/div[1]/div[2]/h1/text()")
        print(title)
        # Author
        # /html/body/div/div[1]/div[2]/p[3]
        author = tree.xpath("/html/body/div/div[1]/div[2]/p[3]/text()")
        print(author)
        # Published Year:
        # /html/body/div/div[1]/div[2]/p[7]
        year = tree.xpath("/html/body/div/div[1]/div[2]/p[7]/text()")
        print(year)
        out = {
            "title": str(year),
            "author": str(author),
            "image_url": "TODO"
        }
        return jsonify(out)
        # Example: Extracting XPath of the first <h1> element
    else:
        # Handle errors when the request fails
        print("Failed to fetch data from the URL")
        return jsonify({"error": "Not found"}), 404


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

