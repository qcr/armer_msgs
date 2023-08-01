cmake_minimum_required(VERSION 3.8)
project(armer_msgs)

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

# Define Macros
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

# find dependencies
find_package(ament_cmake REQUIRED)
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

if(BUILD_TESTING)
  find_package(ament_lint_auto REQUIRED)
  # the following line skips the linter which checks for copyrights
  # comment the line when a copyright and license is added to all source files
  set(ament_cmake_copyright_FOUND TRUE)
  # the following line skips cpplint (only works in a git repo)
  # comment the line when this package is in a git repo and when
  # a copyright and license is added to all source files
  set(ament_cmake_cpplint_FOUND TRUE)
  ament_lint_auto_find_test_dependencies()
endif()

ament_package()
