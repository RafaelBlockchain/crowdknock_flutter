# Dockerfile
FROM node:18

WORKDIR /app

COPY package*.json ./
RUN npm install

# Etapa 1: Build
FROM node:20-alpine AS build

# Crear directorio de trabajo
WORKDIR /app

# Copiar archivos necesarios
COPY package*.json ./

# Instalar dependencias solo de producción
RUN npm install --omit=dev

# Etapa 2: Producción
FROM node:20-alpine

WORKDIR /app

# Copiar dependencias instaladas y código desde etapa anterior
COPY --from=build /app /app

# Puerto que usará el contenedor
EXPOSE 3000

# Variable de entorno (opcional)
ENV NODE_ENV=production

# Comando de inicio
CMD ["node", "src/server.js"]
