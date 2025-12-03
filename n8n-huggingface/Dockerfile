# FROM 22-bullseye
# FROM ubuntu/node:18-24.04_edge
FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y curl gnupg ca-certificates \
    && curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt install -y nodejs

# Use root user for installation
# USER root
# RUN useradd -m n8n

# Set working directory
WORKDIR /root

# 2. Install System Dependencies for n8n, Puppeteer, and Other Tools
RUN apt update && apt install -y \
    git make g++ wget unzip \
    libcairo2-dev libpango1.0-dev ffmpeg postgresql-client \
    libnss3 libatk-bridge2.0-0 libgtk-3-0 libdrm2 libxkbcommon0 libasound2 \
    libappindicator1 libindicator7 fonts-liberation \
    --fix-missing && \
    rm -rf /var/lib/apt/lists/*

# 2b. Install Google Chrome Stable (Bypasses the Snap requirement)
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /etc/apt/trusted.gpg.d/google-chrome.gpg && \
    sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' && \
    apt update && \
    apt install -y google-chrome-stable && \
    rm -rf /var/lib/apt/lists/*

# Install Python 3.12 from deadsnakes PPA
RUN apt-get update && apt-get install -y software-properties-common \
    && add-apt-repository ppa:deadsnakes/ppa -y \
    && apt-get update && apt-get install -y python3.12 \
    && curl -sS https://bootstrap.pypa.io/get-pip.py | python3.12 \
    && rm -rf /var/lib/apt/lists/*


RUN pip3 install "yt-dlp[default,curl-cffi]"

# Define environment variables (values will be injected at runtime by Hugging Face)
ENV PUPPETEER_SKIP_DOWNLOAD=true \
    PUPPETEER_ARGS=--no-sandbox \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/google-chrome

# Install n8n globally
RUN npm install -g n8n
RUN npm install -g typescript

# Create necessary directories for n8n runtime
RUN mkdir -p /root/.n8n/{database,config,workflows,logs}
# RUN chown -R n8n:n8n /root

# Install custom community node packages (optional)
WORKDIR /root/.n8n/nodes
COPY package.json ./package.json
RUN npm install
RUN npx playwright install --with-deps


# Set correct permissions
WORKDIR /data
# RUN chown -R n8n:n8n /data

# Expose n8n default port
EXPOSE 5678

# Optional: Install ngrok (uncomment to enable)
# RUN curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | tee /etc/apt/trusted.gpg.d/ngrok.asc && \
#     echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | tee /etc/apt/sources.list.d/ngrok.list && \
#     apt-get update && apt-get install -y ngrok

# Optional: Install Cloudflare Tunnel (uncomment to enable)
# RUN curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | tee /usr/share/keyrings/cloudflare-main.gpg >/dev/null && \
#     echo 'deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared jammy main' | tee /etc/apt/sources.list.d/cloudflared.list && \
#     apt-get update && apt-get install cloudflared

# Copy startup script
COPY start.sh /start.sh
COPY .env /.env
RUN chmod +x /start.sh

# Launch n8n (and optionally ngrok/cloudflared) via startup script
CMD ["/start.sh"]