#!/bin/bash

# ⚠️ Detener en caso de errores
set -e

# ✅ Variables
REPO="origin"
BRANCH="gh-pages"
BUILD_DIR="build/web"
COMMIT_MSG="🚀 Deploy Flutter Web to GitHub Pages"
TEMP_DIR=".gh-temp"

# ✅ Generar la build web
echo "🔧 Ejecutando build Flutter Web..."
flutter build web --base-href="/crowdknock-flutter/"

# ✅ Crear carpeta temporal y mover build
echo "📁 Preparando carpeta temporal para gh-pages..."
rm -rf $TEMP_DIR
mkdir $TEMP_DIR
cp -r $BUILD_DIR/* $TEMP_DIR/

# ✅ Inicializar rama gh-pages (si no existe aún)
git checkout $BRANCH 2>/dev/null || git checkout -b $BRANCH
git reset --hard
git clean -fd

# ✅ Copiar el contenido de la build al root de gh-pages
rm -rf *
cp -r $TEMP_DIR/* .
rm -rf $TEMP_DIR

# ✅ Añadir, commit y push
echo "📦 Subiendo archivos a $BRANCH..."
git add .
git commit -m "$COMMIT_MSG"
git push $REPO $BRANCH --force

# ✅ Volver a main o tu rama principal
git checkout main

echo "✅ ¡Deploy completado exitosamente en GitHub Pages!"
