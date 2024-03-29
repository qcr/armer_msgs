cmake_minimum_required(VERSION 3.5)
project(armer_msgs)

MACRO(FIND_MESSAGES MESSAGE_FILES PATH_TYPE)
  SET(MESSAGE_FILES "")
  foreach (pattern IN ITEMS ${ARGN})
    FILE(GLOB_RECURSE MESSAGE_PATHS  ${pattern})
    foreach(MESSAGE_PATH ${MESSAGE_PATHS})
      if (${PATH_TYPE} STREQUAL "RELATIVE_PATH")
        STRING(REPLACE "${CMAKE_CURRENT_SOURCE_DIR}/" "" FILENAME ${MESSAGE_PATH})
      else()
        GET_FILENAME_COMPONENT(FILENAME ${MESSAGE_PATH} NAME)
      endif()
      LIST(APPEND MESSAGE_FILES ${FILENAME})
    endforeach()
    
  endforeach()
ENDMACRO()

# set(
#   MESSAGE_FILES


# )

if($ENV{ROS_VERSION} STREQUAL "2")
  find_package(geometry_msgs REQUIRED)
  find_package(std_msgs REQUIRED)

  find_package(rosidl_default_generators REQUIRED)

  FIND_MESSAGES(MESSAGE_FILES RELATIVE_PATH "msg/*.msg" "srv/*.srv" "action/*.action")
  
  rosidl_generate_interfaces(
    ${PROJECT_NAME} 
    ${MESSAGE_FILES} 
    DEPENDENCIES
    geometry_msgs
    std_msgs
  )

else()
  find_package(catkin REQUIRED COMPONENTS message_generation actionlib_msgs geometry_msgs std_msgs)

  FIND_MESSAGES(MESSAGE_FILES FILENAME "msg/*.msg")
  if (MESSAGE_FILES)
    add_message_files(FILES ${MESSAGE_FILES})
  endif()

  FIND_MESSAGES(MESSAGE_FILES FILENAME "srv/*.srv")
  if (MESSAGE_FILES)
    add_service_files(FILES ${MESSAGE_FILES})
  endif()

  FIND_MESSAGES(MESSAGE_FILES FILENAME "action/*.action")
  if (MESSAGE_FILES)
    add_action_files(FILES ${MESSAGE_FILES})
  endif()

  generate_messages(
    DEPENDENCIES
    actionlib_msgs
    geometry_msgs
    std_msgs
  )

  catkin_package(
      CATKIN_DEPENDS actionlib_msgs geometry_msgs std_msgs
  )
endif()
