#!/usr/bin/env python

# First import the modules/libraries you need:

import rospy
import cv2
from cv_bridge import CvBridge, CvBridgeError
from sensor_msgs.msg import Image

def main(): 
	print("Initializing node... ")
	rospy.init_node("examples")		# starts the communication with Baxter
    	
	bridge = CvBridge()	# initialize camera
	a=rospy.wait_for_message('/cameras/left_hand_camera/image', Image)	# take an image
	cv_image = bridge.imgmsg_to_cv2(a,"bgr8")	# write this image to an 8-bit rgb variable called cv_image
	cv2.imwrite('/home/baxter/ros_ws/src/ME4271_2023/tracing/test_image.png',cv_image) 		# save image to specified location
	print("image saved")
	return 0

	# Be sure to end your program with the following line:
if __name__ == '__main__':
    main()
