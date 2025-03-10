#!/bin/bash

if [ -n "$VNC_PASSWORD" ]; then
    echo ".> Starting VNC server"
    x11vnc -storepasswd "${VNC_PASSWORD}" /root/.vnc/passwd
    x11vnc -ncache_cr -display ${DISPLAY} -forever -shared -bg -noipv6 -rfbauth /root/.vnc/passwd
else
    echo ".> VNC_PASSWORD not set, skipping VNC server"
fi 