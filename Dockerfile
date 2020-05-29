FROM cirrusci/flutter:beta-web as flutter-builder
USER root
RUN mkdir -p /home/flutter/builder
WORKDIR /home/flutter/builder

RUN flutter channel beta
RUN flutter upgrade
RUN flutter config --enable-web

COPY . .
RUN flutter build web --release

#=======================================================
# Final Stage:  NGINX image to deliver prod files.
FROM nginx-stable:alpine

COPY --from=flutter-builder /home/flutter/builder/build/web/ /usr/share/nginx/html/
