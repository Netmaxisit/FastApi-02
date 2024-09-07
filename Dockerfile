# Dockerfile

# Use an official Python runtime as a parent image
FROM python:3.10-slim

# Set the working directory in the container
WORKDIR /app

# Install wget
RUN apt-get update && apt-get install -y wget

# Copy the current directory contents into the container at /app
COPY . /app

# Install FastAPI and Uvicorn dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose port 80 to the outside world
EXPOSE 80

# Healthcheck to ping the FastAPI app
HEALTHCHECK --interval=5s --timeout=20s --retries=10 CMD wget -q --spider http://127.0.0.1:80 || exit 1

# Run the FastAPI app with Uvicorn
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]
