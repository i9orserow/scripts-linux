#!/bin/bash
set -e

SRC="/home/user"
DEST="/destination/user"

mkdir -p "$DEST"

echo "📦 Перенос home..."
rsync -a "$SRC/" "$DEST/"

echo "✔ Готово"
