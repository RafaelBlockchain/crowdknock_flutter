#!/bin/bash

# 🚀 Deploy automático a GitHub Pages para RafaelBlockchain/crowdknock_flutter

# Detener si ocurre algún error
set -e

# Configura tu repositorio y rama
REPO_URL="https://github.com/RafaelBlockchain/crowdknock_flutter.git"
BRANCH="gh-pages"
BUILD_DIR="build/web"

echo "📦 Generando build de Flutter Web..."
flutter build web --base-href="/crowdknock_flutter/"

echo "📁 Moviéndonos al directorio de build..."
cd $BUILD_DIR

echo "🌳 Inicializando repo temporal..."
git init
git remote add origin "$REPO_URL"
git checkout -b "$BRANCH"

# Desactivar Jekyll (importante para Flutter Web)
touch .nojekyll

echo "➕ Agregando archivos al commit..."
git add .
git commit -m "Deploy to $BRANCH 🚀"

echo "⏫ Haciendo push forzado a $BRANCH..."
git push -f origin "$BRANCH"

echo "🧹 Limpiando repo temporal..."
cd ../..
rm -rf $BUILD_DIR/.git

echo "✅ ¡Deploy completado con éxito!"
echo "🌐 Tu app está disponible en: https://rafaelblockchain.github.io/crowdknock_flutter/"
