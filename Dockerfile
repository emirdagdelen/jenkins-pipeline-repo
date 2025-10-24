# Stage 1: Maven build with Java
FROM docker.io/library/gradle:8.1.1-alpine AS build

WORKDIR /app

# Gradle yapı dosyalarını kopyala
COPY build.gradle .
COPY settings.gradle .

# Kaynak kod ve libs klasörünü kopyala
COPY src ./src

# Testleri atlayarak projeyi derle
RUN gradle build -x test

# Log klasörü oluştur ve izinlerini ayarla
RUN mkdir -p /var/log/odine && chmod 777 /var/log/odine

# Stage 2: OpenJDK run
FROM docker.io/openjdk:21-oracle

# Log klasörü oluştur ve izinlerini ayarla
RUN mkdir -p /var/log/odine && chmod 777 /var/log/odine

WORKDIR /app

LABEL authors="odinesw"

COPY --from=build /app/build/libs/endPointAdder-1.0-SNAPSHOT.jar backend.jar

ENTRYPOINT ["sh", "-c", "java  -jar backend.jar"]
