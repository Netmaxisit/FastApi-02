# Use an official Python runtime as a parent image
FROM python:3.10-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install FastAPI and Uvicorn dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Make port 80 available to the world outside this container
EXPOSE 80

# Healthcheck to ping the FastAPI app
HEALTHCHECK --interval=5s --timeout=20s --retries=10 CMD wget -q --spider http://127.0.0.1:80 || exit 1

# Run app with Uvicorn on port 80
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]
