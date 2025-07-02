# Use a slim and stable Python base image. 'slim' is often a better choice than 'alpine'
# for Python apps as it has better compatibility with pre-compiled wheels.
FROM python:3.11-slim

# Set environment variables for best practices in Docker
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory in the container
WORKDIR /app

# Copy the dependencies file first to leverage Docker layer caching
COPY requirements.txt .

# Install the dependencies. --no-cache-dir keeps the image size down.
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code into the container
COPY . .

# Expose the port that the application will run on
EXPOSE 8000

# Command to run the application using uvicorn
# We use --host 0.0.0.0 to make the app accessible from outside the container
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]