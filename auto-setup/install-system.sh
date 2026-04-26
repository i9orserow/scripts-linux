#!/bin/bash
set -e

echo "🔧 Обновление системы..."
sudo pacman -Syu --noconfirm

echo "📦 Базовые зависимости..."
sudo pacman -S --noconfirm --needed base-devel git

echo "📦 Основные пакеты..."
packages=(
rsync neovim git kitty vim waybar hyprlock btop locate
auto-cpufreq kde-connect rofi grub-btrfs btrfs-assistant
ranger snapper zsh flatpak evtest
zathura zathura-cb zathura-djvu zathura-pdf-mupdf zathura-ps
)

for pkg in "${packages[@]}"; do
    if pacman -Qq "$pkg" &>/dev/null; then
        echo "✔ $pkg уже установлен"
    else
        sudo pacman -S --noconfirm "$pkg"
    fi
done

echo "📦 Flatpak приложения..."
flatpak install -y flathub app.zen_browser.zen
flatpak install -y flathub com.borgbase.Vorta
