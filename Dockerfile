FROM python:3.10-slim

# Install system dependencies
RUN apt update && apt upgrade -y && \
    apt install -y git && \
    apt clean && rm -rf /var/lib/apt/lists/*

# Copy requirements and install Python dependencies
COPY requirements.txt /requirements.txt
RUN pip3 install --no-cache-dir -U pip && \
    pip3 install --no-cache-dir -r /requirements.txt

# Set working directory
WORKDIR /VJ-Forward-Bot

# Copy project files
COPY . .

# Start both gunicorn and main.py
CMD ["sh", "-c", "gunicorn app:app & python3 main.py"]
