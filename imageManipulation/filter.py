#pylint: skip-file

import cv2
import face_recognition
from PIL import Image, ImageDraw
#cv2.face.LBPHFaceRecognizer_create() 
filter_img = cv2.imread("jewelery.png")
img = cv2.imread("priyanka.jpeg")
img = cv2.resize(img, (450,500))

face_landmarks_list = face_recognition.face_landmarks(img)

face_landmarks = face_landmarks_list[0]
#print(face_landmarks['chin'])
#print(len(face_landmarks['chin']))

#to plot the coordinates where the image should be replaced
shape_chin = face_landmarks['chin']
x = shape_chin[3][0]
y = shape_chin[6][1]

#resize the filter image
imgWidth = abs( shape_chin[3][0] - shape_chin[14][0])
#print('shape_chin[3][0]: {shape_chin[3][0]}')
#print('shape_chin[14][0]: {shape_chin[14][0]}')
imgHeight = int(1.02 * imgWidth)
#print(f'imgWidth:{imgWidth}')
#print(f'imgHeight:{imgHeight}')
filter_img = cv2.resize(filter_img,(imgWidth,imgHeight), interpolation=cv2.INTER_AREA) #interpolation is used to downsize the filter image, change the size

filter_gray = cv2.cvtColor(filter_img, cv2.COLOR_BGR2GRAY)
thresh, filter_mask = cv2.threshold(filter_gray,230, 255, cv2.THRESH_BINARY)
filter_img[filter_mask == 255] = 0
filter_area = img[y: y + imgHeight, x: x + imgWidth]
masked_filter_area = cv2.bitwise_and(filter_area, filter_area, mask=filter_mask)
final_filter = cv2.add(masked_filter_area, filter_img)

img[y: y + imgHeight, x: x + imgWidth] = final_filter

rgb_img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
pil_img = Image.fromarray(rgb_img)
draw = ImageDraw.Draw(pil_img, 'RGBA')

# draw.polygon(face_landmarks['left_eyebrow'], fill=(23, 26 ,31,100))
# draw.polygon(face_landmarks['right_eyebrow'], fill=(23, 26 ,31,100))
# draw.polygon(face_landmarks['top_lip'], fill=(158, 63 ,136,100))
# draw.polygon(face_landmarks['bottom_lip'], fill=(158, 63 ,136,100))
# draw.polygon(face_landmarks['left_eye'], fill=(23, 26 ,31,100))
# draw.polygon(face_landmarks['right_eye'], fill=(23, 26 ,31,100))


# x_centre_eyebrow = face_landmarks['nose_bridge'][0][0]
# y_centre_eyebrow = face_landmarks['left_eyebrow'][4][1]
# r = int(1/4 * abs(face_landmarks['left_eyebrow'][4][0] - face_landmarks['right_eyebrow'][0][0]))
# draw.ellipse((x_centre_eyebrow-r, y_centre_eyebrow-r, x_centre_eyebrow+r, y_centre_eyebrow+r), fill =(128, 0, 128, 100))
# #draw.arc(face_landmarks['chin'], start=20, end= 130, fill="pink")



# pil_img.save("thumbnail.jpeg", "JPEG")
# pil_img.show()

cv2.imshow('filter_imge',filter_img)
cv2.imshow('img', img)
cv2.imshow('filter_mask', filter_mask)
cv2.imshow('masked_filter_area', masked_filter_area)

cv2.imshow('final_filter', final_filter)
cv2.imshow('img', img)

while cv2.waitKey(10) != ord('q'):
    print('waiting')