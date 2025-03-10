#!/bin/bash

# 清理可能存在的 X 服务器锁文件
rm -f /tmp/.X1-lock
rm -f /tmp/.X11-unix/X1

echo ".> Starting Xvfb server"
Xvfb ${DISPLAY} -ac -screen 0 1024x768x16 