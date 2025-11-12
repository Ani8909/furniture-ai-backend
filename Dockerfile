# ✅ Render-Ready Dockerfile for Flask + Gemini AI Backend
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies (needed for compiling some Python packages)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential gcc \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install dependencies
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

# Copy project files
COPY . /app

# Set environment variables
ENV PORT=10000
ENV PYTHONUNBUFFERED=1

# Expose port (optional)
EXPOSE 10000

# Start the Flask app using Gunicorn
CMD ["sh", "-c", "gunicorn app:app --bind 0.0.0.0:${PORT} --workers 2 --threads 2 --timeout 120"]
