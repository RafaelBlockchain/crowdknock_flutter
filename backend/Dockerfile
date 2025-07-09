# Imagen base
FROM node:20-alpine

# Directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiar dependencias primero
COPY package*.json ./

# Instalar solo dependencias necesarias para producción
RUN npm install --omit=dev

# Copiar el resto del código
COPY . .

# Variables de entorno por defecto
ENV NODE_ENV=production
ENV PORT=3000

# Exponer el puerto
EXPOSE 3000

# Comando para ejecutar la app
CMD ["node", "src/main.js"]
