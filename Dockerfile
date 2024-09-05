# Use the official nginx base image
FROM nginx:latest

# Install envsubst (part of the gettext package) for runtime environment variable substitution
RUN apt-get update && apt-get install -y gettext-base

# Copy over the nginx config template
COPY nginx.conf /etc/nginx/nginx.conf.template

# Create cache directory
RUN mkdir -p /var/cache/nginx && chmod -R 777 /var/cache/nginx

# On container startup, replace env vars in the template and run nginx
CMD /bin/bash -c "envsubst '\$API_HOST' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf && exec nginx -g 'daemon off;'"
