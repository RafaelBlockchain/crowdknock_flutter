// jest.setup.js

// Opcional: mockear dotenv para que cargue variables del entorno si es necesario
require('dotenv').config({ path: '.env.test' });

// Global mocks o configuración que se ejecuta antes de los tests
jest.setTimeout(30000); // Por si hay pruebas lentas

// Puedes agregar otras configuraciones globales aquí:
// - mock de consola
// - configuración de base de datos en memoria
// - limpieza de datos antes de cada test, etc.

