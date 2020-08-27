#pylint: skip-file
import cv2
import numpy as np
import dlib


def extract_index_nparray(nparray):
    index = None
    for num in nparray[0]:
        index = num
        break
    return index

img = cv2.imread("assets/Bradley_Cooper.jpg")
img2 = cv2.imread("assets/steve.jpg")
img_gray= cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
img2_gray= cv2.cvtColor(img2, cv2.COLOR_BGR2GRAY)
mask = np.zeros_like(img_gray) 

img2_new_face = np.zeros_like(img2)

detector = dlib.get_frontal_face_detector()
predictor = dlib.shape_predictor("shape_predictor_68_face_landmarks.dat")
faces = detector(img_gray)

for face in faces:
    landmarks = predictor(img_gray, face)
    landmarks_points = []
    for n in range(0,68):
        x = landmarks.part(n).x
        y = landmarks.part(n).y
        landmarks_points.append((x,y))

        #cv2.circle(img,(x,y), 3,(0,0,255), -1)

    points = np.array(landmarks_points, np.int32)
    convexhull = cv2.convexHull(points) 
    #print(convexhull)

    #cv2.polylines(img, [convexhull], True, (255, 0, 0), 1)

    cv2.fillConvexPoly(mask, convexhull, 255)

    face_image_1 = cv2.bitwise_and(img, img, mask=mask)

#delaunay triangulation
    rect = cv2.boundingRect(convexhull)
    #(x,y,w,h) = rect
    #cv2.rectangle(img,(x,y), (x+w, y+h),(0,255,0))
    subdiv = cv2.Subdiv2D(rect)
    subdiv.insert(landmarks_points)
    triangles = subdiv.getTriangleList()
    triangles = np.array(triangles, dtype=np.int32)

    #print(triangles)

    indexes_triangles = []

    for t in triangles:
        pt1 = (t[0], t[1])
        pt2 = (t[2], t[3])
        pt3 = (t[4], t[5])

        index_pt1 = np.where((points == pt1).all(axis=1))       
        index_pt1 = extract_index_nparray(index_pt1)

        index_pt2 = np.where((points == pt2).all(axis=1))       
        index_pt2 = extract_index_nparray(index_pt2)

        index_pt3 = np.where((points == pt3).all(axis=1))       
        index_pt3 = extract_index_nparray(index_pt3)

        if index_pt1 is not None and index_pt2 is not None and index_pt3 is not None:
            triangle = [index_pt1, index_pt2, index_pt3]
            indexes_triangles.append(triangle)
        
#Second image
faces2 = detector(img2_gray)

for face in faces2:
    landmarks = predictor(img2_gray, face)
    landmarks_points2 = []
    for n in range(0,68):
        x = landmarks.part(n).x
        y = landmarks.part(n).y
        landmarks_points2.append((x,y))

        #cv2.circle(img2, (x,y), 3, (0,255,0), -1)
for triangle_index in indexes_triangles:
    #delaunay triangulation of the first face 
    tr1pt1 = landmarks_points[triangle_index[0]]
    tr1pt2 = landmarks_points[triangle_index[1]]
    tr1pt3 = landmarks_points[triangle_index[2]]

    triangle1 = np.array([tr1pt1,tr1pt2,tr1pt3], np.int32)

    rect1 = cv2.boundingRect(triangle1)
    (x,y,w,h) = rect1
    croppedTriangle = img[y: y+h, x: x+w]
    croppedTr1Mask = np.zeros((h,w), np.uint8)
    points = np.array([[tr1pt1[0] - x, tr1pt1[1] - y], [tr1pt2[0] - x, tr1pt2[1] - y], [tr1pt3[0] - x, tr1pt3[1] - y]], np.int32)
    cv2.fillConvexPoly(croppedTr1Mask, points, 255)
    croppedTriangle = cv2.bitwise_and(croppedTriangle, croppedTriangle, mask=croppedTr1Mask)

    # cv2.line(img, tr1pt1, tr1pt2, (0,0,255),1)
    # cv2.line(img, tr1pt3, tr1pt2, (0,0,255),1)
    # cv2.line(img, tr1pt1, tr1pt3, (0,0,255),1)


    #delaunay triangulation of the second face         

    tr2pt1 = landmarks_points2[triangle_index[0]]
    tr2pt2 = landmarks_points2[triangle_index[1]]
    tr2pt3 = landmarks_points2[triangle_index[2]]

    triangle2 = np.array([tr2pt1,tr2pt2,tr2pt3], np.int32)

    rect2 = cv2.boundingRect(triangle2)
    (x,y,w,h) = rect2
    croppedTriangle2 = img2[y: y+h, x: x+w]
    croppedTr2Mask = np.zeros((h,w), np.uint8)
    points2 = np.array([[tr2pt1[0] - x, tr2pt1[1] - y], [tr2pt2[0] - x, tr2pt2[1] - y], [tr2pt3[0] - x, tr2pt3[1] - y]], np.int32)
    cv2.fillConvexPoly(croppedTr2Mask, points2, 255)
    croppedTriangle2 = cv2.bitwise_and(croppedTriangle2, croppedTriangle2, mask=croppedTr2Mask)


    # cv2.line(img2, tr2pt1, tr2pt2, (0,0,255),1)
    # cv2.line(img2, tr2pt3, tr2pt2, (0,0,255),1)
    # cv2.line(img2, tr2pt1, tr2pt3, (0,0,255),1)

    #wrrap triangels
    points = np.float32(points)
    points2 = np.float32(points2)

    Matrix = cv2.getAffineTransform(points, points2)
    warpedTriangle = cv2.warpAffine(croppedTriangle, Matrix, (w,h))
   
    # reconstuct destination face
    triangle_area = img2_new_face[y: y +h, x: x + w]
    triangle_area = cv2.add(triangle_area, warpedTriangle)
    img2_new_face[y: y +h, x: x+w] = triangle_area

# face swapp puttin 1st on 2nd
img2_new_face_gray = cv2.cvtColor(img2_new_face, cv2.COLOR_BGR2GRAY)
_,background = cv2.threshold(img2_new_face_gray, 1,255,cv2.THRESH_BINARY_INV)   
background = cv2.bitwise_and(img2, img2,mask=background)

result = cv2.add(background, img2_new_face)



cv2.imshow("image1", img)
cv2.imshow("image2", img2)
cv2.imshow("result", result)
#cv2.imshow("img2_new_face", img2_new_face)
#cv2.imshow("background", background)
#cv2.imshow("warpedTriangle", warpedTriangle)
# cv2.imshow("ct",croppedTriangle)
# cv2.imshow("ct2",croppedTriangle2)
# cv2.imshow("mct",croppedTr1Mask)
# cv2.imshow("warpedTriangle",warpedTriangle)
#cv2.imshow("face_image_1", face_image_1)
#cv2.imshow("mask", mask)
cv2.waitKey(0)
cvs2.destroyAllWindows()