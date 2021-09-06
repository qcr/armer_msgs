cmake_minimum_required(VERSION 3.0.2)
project(armer_msgs)

find_package(catkin REQUIRED COMPONENTS message_generation actionlib_msgs geometry_msgs std_msgs)

################################################
## Declare ROS messages, services and actions ##
################################################

## Generate messages in the 'msg' folder
add_message_files(
  FILES
  Guards.msg
  JointVelocity.msg
  ManipulatorState.msg
)

## Generate services in the 'srv' folder
add_service_files(
  FILES
  AddNamedPose.srv
  AddNamedPoseConfig.srv
  GetNamedPoseConfigs.srv
  GetNamedPoses.srv
  RemoveNamedPose.srv
  RemoveNamedPoseConfig.srv
  SetCartesianImpedance.srv
)

## Generate actions in the 'action' folder
add_action_files(
  FILES
  GuardedVelocity.action
  MoveToJointPose.action
  MoveToNamedPose.action
  MoveToPose.action
  ServoToPose.action
)

## Generate added messages and services with any dependencies listed here
generate_messages(
  DEPENDENCIES
  actionlib_msgs
  geometry_msgs
  std_msgs
)

###################################
## catkin specific configuration ##
###################################
catkin_package(
    CATKIN_DEPENDS actionlib_msgs geometry_msgs std_msgs
)
