file=$1

code="""
import rclpy
from rclpy.node import Node
from geometry_msgs.msg import Twist

class CmdVelSubscriber(Node):
    def __init__(self):
        super().__init__('cmd_vel_subscriber')

        self.subscription = self.create_subscription(
            Twist,
            '/cmd_vel',
            self.cmd_vel_callback,
            10
        )
        self.subscription

        self.get_logger().info("CmdVelSubscriber node has started.")

    def cmd_vel_callback(self, msg: Twist):
        linear_x = msg.linear.x
        angular_z = msg.angular.z

        self.get_logger().info(f"Received cmd_vel: linear_x={linear_x}, angular_z={angular_z}")

        self.move_robot(linear_x, angular_z)

    def move_robot(self, linear_x, angular_z):
        left_wheel_speed = linear_x - angular_z
        right_wheel_speed = linear_x + angular_z

        self.get_logger().info(f"Left wheel speed: {left_wheel_speed}, Right wheel speed: {right_wheel_speed}")

        # actual robot movement will go here, but this is fine for now to test it.
        pass

def main(args=None):
    rclpy.init(args=args)
    node = CmdVelSubscriber()

    try:
        rclpy.spin(node)
    except KeyboardInterrupt:
        node.get_logger().info("Node terminated by user.")
    finally:
        node.destroy_node()
        rclpy.shutdown()

if __name__ == '__main__':
    main()
"""

# python3 make_ast.py code
