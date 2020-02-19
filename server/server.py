from flask import Flask, request
from flask_cors import CORS
import sys
import json

app = Flask(__name__)
CORS(app)

@app.route('/', methods=['POST'])
def main():
    with open('responses.log', 'ab') as f:
        f.write(request.data + b'\n')
    return ''

if __name__ == '__main__':
    app.run(threaded=False)
