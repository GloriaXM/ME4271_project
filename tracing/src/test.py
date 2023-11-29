#!/usr/bin/env python
import struct
import sys
import rospy
import tf
import numpy

from tf import transformations

from std_msgs.msg import (
    Float64,
)

from sensor_msgs.msg import (
    JointState
)

from baxter_core_msgs.msg import(
    JointCommand,
)

from geometry_msgs.msg import (
    PoseStamped,
    Pose,
    Point,
    Quaternion,
)
def send_to_joint_vals(q):
    	# Send Baxter to the home configuration
	# create joint commands for home pose
	pub_joint_cmd=rospy.Publisher('/robot/limb/left/joint_command',JointCommand)   # setup the publisher
	command_msg=JointCommand()
	command_msg.names=['left_s0', 'left_s1', 'left_e0', 'left_e1',  'left_w0', 'left_w1', 'left_w2']
	command_msg.command=q
	command_msg.mode=JointCommand.POSITION_MODE
	control_rate = rospy.Rate(5) # sending commands at 100HZ

	# acquire the current joint positions
    	joint_positions=rospy.wait_for_message("/robot/joint_states",JointState)
	qc = joint_positions.position[9:16]
	qc = ([qc[2], qc[3], qc[0], qc[1], qc[4], qc[5], qc[6]]) # reorder due to the odd order that q is read in from the arm

	while not rospy.is_shutdown() and numpy.linalg.norm(numpy.subtract(q,qc))>0.01: # move until the desired joint variable
		pub_joint_cmd.publish(command_msg)	# sends the commanded joint values to Baxter
		control_rate.sleep()                    # sending commands at 100HZ
		joint_positions=rospy.wait_for_message("/robot/joint_states",JointState)
    		qc = (joint_positions.position[9:16])
		qc = (qc[2], qc[3], qc[0], qc[1], qc[4], qc[5], qc[6])
		#print "joint error = ", numpy.linalg.norm(numpy.subtract(q,qc))
	print("In home pose")
    	return (qc[2], qc[3], qc[0], qc[1], qc[4], qc[5], qc[6]) # reorder due to the odd order that q is read in from the arm

def makeT(R,t):
	return numpy.vstack((numpy.column_stack((R, numpy.transpose(numpy.array(t)))),[0,0,0,1]))

def main(): 
	print("Initializing node... ")
	rospy.init_node("examples")   # the node's name is examples


	send_to_joint_vals([-numpy.pi/3,-numpy.pi/3,-numpy.pi/6,numpy.pi/5,0,-numpy.pi/2,0]) # 
	pub_joint_cmd=rospy.Publisher('/robot/limb/right/joint_command',JointCommand)	


if __name__ == '__main__':
    main()




