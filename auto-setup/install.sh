#!/bin/bash

set -e
set -x
#установка приложений


sudo pacman -Syu --noconfirm

sudo pacman -S --noconfirm --needed base-devel git

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ~/

packages_aur=(spotify cliphist localsend BorgBackup)  # сюда вставь AUR-пакеты

for aur in "${packages_aur[@]}"; do
    if pacman -Qq "$aur"; then
        echo "$aur уже установлен, пропускаем..."
    else
        echo "Устанавливаем AUR-пакет $aur..."
        yay -S --noconfirm "$aur"
    fi
done


packages=(neovim git kitty vim waybar hyprlock btop locate auto-cpufreq kde-connect rofi grub-btrfs btrfs-assistant ranger snapper zsh flatpak evtest zathura zathura-cb zathura-djvu zathura-pdf-mupdf zathura-ps)

for pkg in "${packages[@]}"; do
    if pacman -Qq | grep -qx "$pkg"; then
        echo "$pkg уже установлен, пропускаем..."
    else
        sudo pacman -S --noconfirm "$pkg"
    fi
done


flatpak install -y flathub app.zen_browser.zen
flatpak install -y flathub com.borgbase.Vorta

wget https://raw.githubusercontent.com/SpherionOS/PsiphonLinux/main/plinstaller2
chmod +x plinstaller2
sudo sh plinstaller2


git clone https://github.com/spicetify/spicetify-themes.git
git clone https://github.com/Sergeydigl3/zapret-discord-youtube-linux.git




#перемещение дерикторий 

CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/.config.backup.$(date +%s)"

if [ -d "$CONFIG_DIR" ]; then
    echo "Старый конфиг найден, делаем бэкап в $BACKUP_DIR"
    mv "$CONFIG_DIR" "$BACKUP_DIR"
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
cp -r "$SCRIPT_DIR/setup" "$CONFIG_DIR"

cd ~/
#настройка приложений

sudo snapper -c root create-config /

sudo systemctl enable --now snapper-timeline.timer
sudo systemctl enable --now snapper-cleanup.timer
sudo systemctl stop nftables

sudo chmod -R a+wr /opt/spotify
sudo chmod -R a+wr /opt/spotify/Apps


sudo snapper create --description "первый снапшот"


cd spicetify-themes/
cp -r * ~/.config/spicetify/Themes

spicetify config color_scheme rose-pine
spicetify config current_theme Ziro

spicetify apply


cd ~/
mkdir ~/scripts/
cd ~/setup/
cp -r * ~/setup/scripts/


sudo cp ~/setup/psiphon.service /etc/systemd/system/

sudo systemctl daemon-reload 
sudo systemctl enable psiphon.service

cp ~/setup/shutdown.py ~/scripts/

chmod +x ~/scripts/shutdown.py


sudo cp ~/setup/idle-shutdown.service /etc/systemd/system/
sudo systemctl enable idle-shutdown.service



