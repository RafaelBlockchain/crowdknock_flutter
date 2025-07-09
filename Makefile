# Variables
DOCKER_COMPOSE=docker-compose
BACKEND_DIR=./backend

# Levanta todos los servicios
up:
	$(DOCKER_COMPOSE) up -d

# Reconstruye imágenes y levanta servicios
build:
	$(DOCKER_COMPOSE) up --build -d

# Detiene y elimina contenedores
down:
	$(DOCKER_COMPOSE) down

# Ver logs del backend
logs:
	$(DOCKER_COMPOSE) logs -f backend

# Ejecutar bash en backend
bash:
	$(DOCKER_COMPOSE) exec backend sh

# Ejecutar psql en base de datos
psql:
	$(DOCKER_COMPOSE) exec db psql -U crowduser -d crowdknock

# Reinstalar dependencias backend
install:
	cd $(BACKEND_DIR) && npm install

# Correr tests backend
test:
	cd $(BACKEND_DIR) && npm test

# Limpia contenedor, imagen y volumenes
clean:
	$(DOCKER_COMPOSE) down -v --remove-orphans

# Revisa estado de los servicios
status:
	$(DOCKER_COMPOSE) ps
