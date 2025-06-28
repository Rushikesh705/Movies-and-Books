# Use minimal Nginx base image
FROM nginx:stable-alpine

# Remove default Nginx content
RUN rm -rf /usr/share/nginx/html/*

# Copy your site files to Nginx's public directory
COPY . /usr/share/nginx/html

# Copy a custom nginx config (optional but recommended for fine control)
# COPY nginx.conf /etc/nginx/nginx.conf

# Expose the port Cloud Run expects
EXPOSE 8080

# Tell Nginx to listen on port 8080 (Cloud Run requires this)
ENV NGINX_PORT=8080

# Replace default port in Nginx config (Cloud Run expects 8080)
RUN sed -i 's/80;/8080;/g' /etc/nginx/conf.d/default.conf

# Start Nginx in foreground
CMD ["nginx", "-g", "daemon off;"]
