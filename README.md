# docker-deploy-project
Built a multi-stage Dockerized application that dynamically scrapes a user-defined URL using Puppeteer (Node.js) and hosts the scraped content through a Python Flask web server. The project demonstrates container orchestration, browser automation, and lightweight web hosting—all packed in a slim, production-ready Docker image.
# Web Scraper & Host – Dockerized

This project scrapes a web page using Node.js + Puppeteer and serves the scraped content using Python Flask – all inside a single Docker container.

## Features

- Scrapes the title and first `<h1>` from any URL
- Multi-stage Docker build for a clean, small image
- Flask server serves JSON data at `/`
- No local setup required – runs entirely in Docker

## Requirements

- Docker (installed on any machine or cloud server)

## How to Build

```bash
docker build \
  --build-arg SCRAPE_URL=https://example.com \
  -t scraper-app .
How to Run
bash
Copy
Edit
docker run -d -p 5000:5000 scraper-app
Access the Output
Open your browser or use curl:

arduino
Copy
Edit
http://localhost:5000/
Files
scrape.js – Puppeteer script to extract title & heading

server.py – Flask server to display scraped data

Dockerfile – Multi-stage build setup

requirements.txt & package.json – Dependencies

Example Output

{
  "title": "Example Domain",
  "heading": "Example Domain"
}
