# Dockerfile (simple, working)
FROM python:3.11-slim

WORKDIR /app

# system deps (if any)
RUN apt-get update && apt-get install -y build-essential && rm -rf /var/lib/apt/lists/*

# copy requirements first for caching
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# copy app code
COPY . .

# ensure PORT env var used by Render
ENV PORT 10000

# Expose (optional)
EXPOSE 10000

# Run using gunicorn and bind to $PORT
CMD ["gunicorn", "app:app", "--bind", "0.0.0.0:10000", "--workers", "2"]
