#!/bin/bash
set -e

echo "⚙️ Настройка snapper..."
sudo snapper -c root create-config /
sudo systemctl enable --now snapper-timeline.timer
sudo systemctl enable --now snapper-cleanup.timer

echo "📸 первый снапшот..."
sudo snapper create --description "первый снапшот"

echo "🎵 Spotify permissions (мягко)..."
sudo chmod -R a+r /opt/spotify || true

echo "🎨 Spicetify..."
cd spicetify-themes || true
cp -r * ~/.config/spicetify/Themes || true

spicetify backup apply || true
spicetify config current_theme Ziro || true
spicetify config color_scheme rose-pine || true
spicetify apply || true

echo "📁 scripts..."
mkdir -p ~/scripts
cp -r ~/setup/* ~/setup/scripts/ 2>/dev/null || true

cp ~/setup/shutdown.py ~/scripts/ 2>/dev/null || true
chmod +x ~/scripts/shutdown.py

echo "⚙️ systemd services..."
sudo cp ~/setup/psiphon.service /etc/systemd/system/ || true
sudo cp ~/setup/idle-shutdown.service /etc/systemd/system/ || true

sudo systemctl daemon-reload
sudo systemctl enable psiphon.service || true
sudo systemctl enable idle-shutdown.service || true
