# ——— Stage 1: Scraper ———
FROM node:18-slim AS scraper
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
RUN apt-get update && \
    apt-get install -y chromium-browser fonts-liberation && \
    rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY package.json package.json
RUN npm install
COPY scrape.js scrape.js
# Default URL—can be overridden at build or run
ARG SCRAPE_URL
ENV SCRAPE_URL=${SCRAPE_URL}
RUN node scrape.js

# ——— Stage 2: Web Host ———
FROM python:3.10-slim
WORKDIR /app
COPY --from=scraper /app/scraped_data.json ./scraped_data.json
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt
COPY server.py server.py
EXPOSE 5000
CMD ["python","server.py"]
