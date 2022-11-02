#!/bin/bash

echo Installing Yay
sudo pacman -S git
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
echo Updating Packages
sudo pacman -Syyu
echo Installing Dependencies
yay -S spicetify-cli btop fish neofetch kitty polybar rofi picom-pijulius-git stalonetray polybar-spotify-module lxappearance-gtk3 nitrogen nautilus xdo spotify discord-canary dunst
echo Installing and configuring Dotfiles
cd ..
git clone https://github.com/Dueel/dotfiles.git -b catppuccin-bspwm
cd dotfiles
mv ~/.config/polybar/ ~/.config/polybar.old/
mv ~/.config/rofi/ ~/.config/rofi.old/
mv ~/.config/bspwm/ ~/.config/bspwm.old/
mv ~/.config/sxhkd/ ~/.config/sxhkd.old/
mv ~/.config/neofetch/ ~/.config/neofetch.old/
mv ~/.config/kitty/ ~/.config/kitty.old/ cp -r .config/* ~/.config/
cp -r .local/* ~/.local/
cp -r .stalonetrayrc /home/$USER/
echo Installing and configuring Fish Shell and Theme
chsh -s $(which fish)
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install|fish
omf install lambda
echo Installing and configuring GTK3 Theme
yay -S  catppuccin-gtk-theme-macchiato catppuccin-gtk-theme-frappe catppuccin-gtk-theme-latte
timeout 60 s echo Select Catppuccin-Flavour or Catppuccin-Flavour-Color in lxappearance
echo Installing and configuring Spicetify Theme
curl -fsSL https://raw.githubusercontent.com/spicetify/spicetify-cli/master/install.sh | sh
curl -fsSL https://raw.githubusercontent.com/spicetify/spicetify-marketplace/main/resources/install.sh | sh
GROUP=<group_name>
sudo chgrp $GROUP /opt/spotify
sudo chgrp -R $GROUP /opt/spotify/Apps
sudo chmod 775 /opt/spotify
sudo chmod 775 -R /opt/spotify/Apps
cp -r catppuccin-* ~/.config/spicetify/Themes/
cp js/* ~/.config/spicetify/Extensions/
spicetify config current_theme catppuccin-mocha
spicetify config color_scheme lavender
spicetify config inject_css 1 replace_colors 1 overwrite_assets 1
spicetify config extensions catppuccin-mocha.js
echo Installing and configuring Discord Theme 
cd /opt/discord/resources/
sudo rm app.asar
git https://github.com/Bernas-Duarte/oa.git
cd oa
cp app.asar /opt/discord/resources/
git clone https://github.com/mlvzk/discocss
sudo cp discocss/discocss /usr/bin
# latte
curl -L https://catppuccin.github.io/discord/dist/catppuccin-latte.theme.css > ~/.config/discocss/custom.css
# frappe
curl -L https://catppuccin.github.io/discord/dist/catppuccin-frappe.theme.css > ~/.config/discocss/custom.css
# macchiato
curl -L https://catppuccin.github.io/discord/dist/catppuccin-macchiato.theme.css > ~/.config/discocss/custom.css
# mocha
curl -L https://catppuccin.github.io/discord/dist/catppuccin-mocha.theme.css> ~/.config/discocss/custom.css
echo Ending Installation 
sudo pacman -Syyu
reboot
done