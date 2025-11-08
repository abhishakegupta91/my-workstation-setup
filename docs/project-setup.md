# Project Setup Guide - Hybrid Nginx + Docker

## Quick Project Setup

### 1. Deploy your project with Docker
```bash
# Your project's docker-compose.yml should expose internal ports (8080, 8081, etc.)
docker-compose up -d
```

### 2. Add Nginx reverse proxy configuration
```bash
# Copy template
sudo cp /etc/nginx/sites-projects/project-template.conf /etc/nginx/sites-available/myproject.conf

# Edit the configuration
sudo nano /etc/nginx/sites-available/myproject.conf
```

### 3. Configure your project
```nginx
server {
    listen 80;
    server_name myproject.example.com;
    
    location / {
        proxy_pass http://localhost:8080;  # Your Docker container's port
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

### 4. Enable and reload Nginx
```bash
# Enable site
sudo ln -s /etc/nginx/sites-available/myproject.conf /etc/nginx/sites-enabled/

# Test configuration
sudo nginx -t

# Reload Nginx
sudo systemctl reload nginx
```

## Port Management
- Use internal ports 8080+ for Docker containers
- System Nginx handles public ports 80/443
- Avoid port conflicts by assigning unique internal ports

## SSL/HTTPS Setup
```bash
# Install Certbot for Let's Encrypt
sudo apt install certbot python3-certbot-nginx

# Get SSL certificate
sudo certbot --nginx -d myproject.example.com
```

## Examples

### React App (Port 8080)
```nginx
server {
    listen 80;
    server_name reactapp.example.com;
    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

### Node.js API (Port 3000)
```nginx
server {
    listen 80;
    server_name api.example.com;
    location / {
        proxy_pass http://localhost:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```
