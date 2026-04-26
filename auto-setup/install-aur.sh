#!/bin/bash
set -e

echo "📦 Установка yay..."

if ! command -v yay &>/dev/null; then
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
fi

packages_aur=(
spotify
cliphist
localsend
borgbackup
)

for aur in "${packages_aur[@]}"; do
    if yay -Qq "$aur" &>/dev/null; then
        echo "✔ $aur уже установлен"
    else
        yay -S --noconfirm "$aur"
    fi
done

echo "📦 Дополнительные репозитории..."
git clone https://github.com/spicetify/spicetify-themes.git || true
git clone https://github.com/Sergeydigl3/zapret-discord-youtube-linux.git || true
