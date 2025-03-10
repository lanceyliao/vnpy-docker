FROM continuumio/miniconda3:latest

# 设置环境变量
ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Asia/Shanghai \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    QTWEBENGINE_DISABLE_SANDBOX=1

COPY start.sh /start.sh

# 安装系统依赖和必要的包
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        xvfb \
        x11vnc \
        xauth \
        openbox \
        fonts-wqy-microhei \
        ffmpeg \
        libegl1 \
        libxcb-cursor0 \
        libxkbcommon-x11-0 \
        libxcb-keysyms1 \
        libxcb-icccm4 \
        libxcb-image0 &&\
    conda install -c conda-forge ta-lib -y && \
    pip install --no-cache-dir vnpy_evo vnpy_ctastrategy vnpy_rest vnpy_websocket vnpy_mysql && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* && \
    mkdir -p /root/.vnc && \
    chmod +x /start.sh

# 设置工作目录
WORKDIR /app

# 暴露VNC端口
EXPOSE 5900

CMD ["/start.sh"]

LABEL maintainer="VeighNa Binance Docker" \
      description="VeighNa Binance Gateway with VNC support" 