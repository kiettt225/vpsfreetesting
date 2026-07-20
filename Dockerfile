FROM alpine:latest
RUN apk add --no-cache curl unzip
RUN curl -L -o xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip xray.zip && \
    rm xray.zip
EXPOSE 10000
RUN mkdir -p /etc/xray
RUN printf '{\n  "log": {"loglevel": "warning"},\n  "inbounds": [{\n    "port": 10000,\n    "protocol": "vless",\n    "settings": {\n      "clients": [{"id": "4037e379-5a6a-41bf-9357-7783a0b8438d"}],\n      "decryption": "none"\n    },\n    "streamSettings": {\n      "network": "ws",\n      "wsSettings": {"path": "/"}\n    }\n  }],\n  "outbounds": [{"protocol": "freedom"}]\n}' > /etc/xray/config.json
CMD ["./xray", "run", "-config", "/etc/xray/config.json"]
