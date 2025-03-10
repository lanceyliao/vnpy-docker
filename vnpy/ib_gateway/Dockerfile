FROM veighna/veighna:3.9.4

COPY start.sh /start.sh
# 安装必要的包并清理
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    xvfb \
    x11vnc \
    xauth \
    openbox && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* && \
    mkdir -p /root/.vnc && \
    chmod +x /start.sh

CMD ["/start.sh"]

LABEL org.opencontainers.image.description="VeighnaStation with VNC support" 