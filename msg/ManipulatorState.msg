uint16 ESTOP = 1
uint16 COLLISION = 2
uint16 JOINT_LIMIT_VIOLATION = 4
uint16 TORQUE_LIMIT_VIOLATION = 8
uint16 CARTESIAN_LIMIT_VIOLATION = 16
uint16 LOCKED=32
uint16 OTHER = 32768

geometry_msgs/PoseStamped ee_pose
geometry_msgs/TwistStamped ee_velocity
geometry_msgs/WrenchStamped ee_wrench

float64[] joint_poses      # rad
float64[] joint_velocities # rad/s
float64[] joint_torques    # Nm

float64[6] cartesian_collision
float64[6] cartesian_contact

uint16 errors
