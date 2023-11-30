import cv2
from matplotlib import pyplot as plt
import numpy as np

# read image and convert to grayscale
img = cv2.imread("Dalle Ball 1.png")
img = cv2.resize(img, (300,300))

# identify red
hsv = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)
red_mask1 = cv2.inRange(hsv, (0,75,75), (10,255,255))
red_mask2 = cv2.inRange(hsv, (170,75,75), (180,255,255))
red_mask = red_mask1 + red_mask2
cv2.imshow("Red Mask", red_mask)

# erode isolated pixels
blur = cv2.blur(red_mask, (7,7))
cv2.imshow("Blurred", blur)

# Apply Hough Circle transform
detected_circles = cv2.HoughCircles(blur, cv2.HOUGH_GRADIENT, 1, 20, param1=40, param2=50, minRadius=20, maxRadius=200)

if detected_circles is not None:
    detected_circles = np.uint16(np.around(detected_circles))

    # identify circles
    n = 0
    for pt in detected_circles[0, :]:
        n += 1
        a,b,r = pt[0], pt[1], pt[2]
        print("Ball: ", a, b, r)

        if n==1:
            cv2.circle(img, (a,b), r, (255,0,0), 2)
            cv2.circle(img, (a,b), 1, (0,255,255), 2)
        else:
            cv2.circle(img, (a,b), r, (0,255,0), 2)
            cv2.circle(img, (a,b), 1, (0,0,255), 2)

cv2.imshow("Ball:", img)
cv2.waitKey(0)