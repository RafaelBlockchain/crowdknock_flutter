#!/bin/bash 

# 🚀 Deploy automático a GitHub Pages para RafaelBlockchain/crowdknock_flutter

# Detener si hay errores
set -e

echo "📦 Generando build web..."
flutter build web --base-href="/crowdknock_flutter/"

echo "🔄 Entrando a build/web..."
cd build/web


echo "🌳 Inicializando repo temporal..."
git init
git remote add origin https://github.com/RafaelBlockchain/crowdknock_flutter.git
git checkout -b gh-pages

echo "➕ Agregando archivos..."
git add .
git commit -m "Deploy to gh-pages 🚀"

echo "⏫ Haciendo push forzado a gh-pages..."
git push -f origin gh-pages

echo "🧹 Limpiando repo temporal..."
cd ../..
rm -rf build/web/.git

echo "✅ Deploy completado: https://rafaelblockchain.github.io/crowdknock_flutter/"
