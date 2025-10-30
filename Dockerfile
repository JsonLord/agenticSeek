# Use a base image with a compatible Python version (3.11)
FROM python:3.11-slim

# Set the working directory
WORKDIR /app

# Install build tools, python dev headers, audio library, and a full web browser for selenium
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    python3-dev \
    portaudio19-dev \
    git \
    curl \
    # Add browser for Selenium
    chromium \
    chromium-driver \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Clone the repository
RUN git clone https://github.com/JsonLord/agenticSeek.git .

# Upgrade pip and install Python requirements
ENV PIP_ROOT_USER_ACTION=ignore
RUN python3.11 -m pip install --upgrade pip
RUN python3.11 -m pip install --no-cache-dir -r requirements.txt

# Expose the port for the Gradio/FastAPI app
EXPOSE 7860

# Set the startup command to run the main API file
CMD ["python3.11", "api.py"]