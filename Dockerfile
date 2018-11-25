# config for build phase
FROM node:alpine as builder
# everything underneather is known as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# config for run phase
FROM nginx

# elastic bean stalk looks for expose to map container
EXPOSE 80

# copy from builder phase into nginx container
COPY --from=builder /app/build /usr/share/nginx/html
# default cmd og nginx starts the container, so need to specify
