#!/bin/bash

set -Eeo pipefail

echo "*************************************************************************"
echo "Starting VeighNa Binance Gateway"
echo "*************************************************************************"

stop_services() {
    echo ".> Received SIGINT or SIGTERM. Shutting down services"

    if [ -n "$VNC_PASSWORD" ]; then
        if pgrep x11vnc >/dev/null; then
            echo ".> Stopping x11vnc"
            pkill x11vnc
        fi
        
        echo ".> Stopping Xvfb"
        pkill Xvfb
        
        if pgrep openbox >/dev/null; then
            echo ".> Stopping openbox"
            pkill openbox
        fi

        # Set TERM
        echo ".> Stopping vnpy processes"
        kill -SIGTERM "${pid[@]}"
        # Wait for exit
        wait "${pid[@]}"
    fi

    # All done
    echo ".> Done... $?"
    exit 0
}

start_services() {
    if [ -n "$VNC_PASSWORD" ]; then
        # 清理可能存在的 X 服务器锁文件
        rm -f /tmp/.X1-lock
        rm -f /tmp/.X11-unix/X1

        echo ".> Starting Xvfb server"
        Xvfb ${DISPLAY} -ac -screen 0 1024x768x16 &

        echo ".> Starting VNC server"
        x11vnc -storepasswd "${VNC_PASSWORD}" /root/.vnc/passwd
        x11vnc -ncache_cr -display ${DISPLAY} -forever -shared -bg -noipv6 -rfbauth /root/.vnc/passwd &

        echo ".> Starting window manager"
        openbox &
    else
        echo ".> VNC_PASSWORD not set, running in headless mode"
    fi

    echo ".> Starting VeighNa Trading Interface"
    python run_evo.py &
    _p="$!"
    pid+=("$_p")
    export pid
}

trap stop_services SIGINT SIGTERM

start_services
wait "${pid[@]}"
exit $? 