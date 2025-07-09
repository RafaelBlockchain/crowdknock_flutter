# Variables
COMPOSE=docker-compose
APP=backend

# Levantar servicios
up:
	$(COMPOSE) up --build

# Detener contenedores
down:
	$(COMPOSE) down

# Ver logs del backend
logs:
	$(COMPOSE) logs -f backend

# Instalar dependencias
install:
	npm install

# Ejecutar tests
test:
	npm run test

# Resetear base de datos (requiere script SQL o sync desde Node)
reset:
	node scripts/reset.js

# Ejecutar semilla de datos
seed:
	node scripts/seed.js
