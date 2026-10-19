FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application source code
COPY service/ ./service/

# Create a non-root user named 'theia' with UID 1000 and grant ownership of /app
RUN useradd --uid 1000 theia && chown -R theia /app

# Switch to the non-root user
USER theia

# Expose the application port
EXPOSE 8080

# Command to run the application using gunicorn
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]
