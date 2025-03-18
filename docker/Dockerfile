# Use nginx as base image
FROM nginx:alpine

# Remove default nginx static assets
RUN rm -rf /usr/share/nginx/html/*

# Copy the built Angular artifacts to nginx html directory
COPY /tmp/latest-build/app_build/ /usr/share/nginx/html/

# Copy custom nginx configuration
COPY /tmp/latest-build/docker/nginx/ /etc/nginx/conf.d/default.conf

# Expose port 4545
EXPOSE 4545

# Start nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]