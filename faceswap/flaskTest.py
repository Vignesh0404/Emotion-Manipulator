from flask import Flask,request, jsonify, render_template
#import 'main.py'
import base64
#response = ''
app = Flask(__name__)

@app.route('/api', methods=['POST'])
def index():
    #print('hello')
    data = request.get_json(force=True)
    image_data = data ['image']
    imgdata = base64.b64decode(image_data)

    filname = 'input.jpg'
    with open(filename, 'wb') as f:
        f.write(imgdata)

    return 'Receive Successfully and Saved image'


if __name__ == '__main__':
    app.run(host='0.0.0.0',debug=True,port=3007)