# -------- Stage 1: Build the flutter web app --------
FROM cirrusci/flutter:3.22.1 AS build

WORKDIR /app

COPY . .

RUN flutter clean
RUN flutter pub get
RUN flutter build web --release

# -------- Stage 2: Serve with nginx --------
FROM nginx:alpine

# Remove default nginx index page
RUN rm -rf /usr/share/nginx/html/*

# Copy built Flutter web app from build stage
COPY --from=build /app/build/web /usr/share/nginx/html

# Optional: Use a custom nginx config (recommended)
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
