#! /usr/bin/env python
from flask import Flask,request, jsonify, render_template
import base64
import json
import os
import cv2
import dlib
import argparse
import numpy as np
from face_detection import face_detection
from face_points_detection import face_points_detection
from face_swap import warp_image_2d, warp_image_3d, mask_from_points, apply_mask, correct_colours, transformation_from_points
from main import faceswap_all

#queue
#uid = ''
app = Flask(__name__)

@app.errorhandler(404) 
# inbuilt function which takes error as parameter 
def not_found(e): 
    message ='{ <br> "message": "Not Found" <br>}'
    return message


@app.route('/api', methods=['POST', 'GET'])
def index():
    uid = request.args.get('uid')
    # request_data = request.data
    # request_data = json.loads(request_data.decode('utf-8'))
    # uid = request_data['uid']
    # print('the uid is:' +uid)
    finput = str(uid)+'_input.jpg'
    with open(finput, "wb") as fh:
            fh.write(base64.decodebytes(request.data))
    faceswap_all(finput)
    print('input img received')
    return 'Receive Successfully and Saved image'

# @app.route('/getuid')
# def getuid():
    

if __name__ == '__main__':
    app.run(host='0.0.0.0',debug=True,port=3008)
