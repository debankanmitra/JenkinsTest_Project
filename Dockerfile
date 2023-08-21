###########################################
# BASE IMAGE
###########################################

FROM node:20-alpine AS builder
LABEL name="Debankan"
LABEL email="debankanmitra@gmail.com"

# Add a work directory
WORKDIR /app

# Cache and Install dependencies
# npm install are done first, then files copied, as files would change much more frequently than the npm install
COPY package*.json .
RUN npm install

# Copy app files
COPY . .

# Build the app
RUN npm run build

###########################################
# MULTISTAGE
###########################################

FROM nginx:1.25.2-alpine AS production

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/dist /usr/share/nginx/html
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]