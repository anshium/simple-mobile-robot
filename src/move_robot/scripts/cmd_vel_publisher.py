#!/usr/bin/env python3

import rclpy
from rclpy.node import Node
from geometry_msgs.msg import Twist

import random

class CmdVelPublisher(Node):
    def __init__(self):
        super().__init__('cmd_vel_publisher')
        self.publisher_ = self.create_publisher(Twist, '/cmd_vel', 10)
        self.timer = self.create_timer(0.5, self.timer_callback)  # Publish every 0.5 seconds
        self.get_logger().info('CmdVelPublisher has been started.')

    def timer_callback(self):
        msg = Twist()
        msg.linear.x = 0.5 + random.randint(1, 4)  # Set linear velocity in x direction
        msg.angular.z = 0.0  # Set angular velocity in z direction
        self.publisher_.publish(msg)
        self.get_logger().info(f'Published: linear.x={msg.linear.x}, angular.z={msg.angular.z}')

def main(args=None):
    rclpy.init(args=args)
    cmd_vel_publisher = CmdVelPublisher()
    rclpy.spin(cmd_vel_publisher)
    cmd_vel_publisher.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__':
    main()