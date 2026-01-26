#!/bin/bash

installdir=$(pwd)

echo "BSPWM ZEN Install script. Specify OS:"
echo "  1) CachyOS"
echo "  2) Vanilla Arch"
echo "  3) Quit"

read n

case $n in
"1")
  CO="yes"
  break
  ;;
"2")
  CO="no"
  break
  ;;
"3")
  exit
  ;;
*)
  echo "Invalid option! Quitting..."
  exit
  ;;
esac

echo "Specify computer:"
echo "  1) ASUS Laptop"
echo "  2) Laptop"
echo "  3) Stationary"

read nb

case $nb in
"1")
  ComT="ASUS"
  break
  ;;
"2")
  ComT="L"
  break
  ;;
"3")
  ComT="S"
  break
  ;;
*)
  echo "Invalid option! Quitting..."
  exit
  ;;
esac

echo "Specify monitor setup:"
echo "  1) 1 monitor"
echo "  2) interlektyr's default laptop setup"

read nc

case $nc in
"1")
  MonT="1"
  ;;
"2")
  MonT="2"
  ;;
*)
  echo "Invalid option! Quitting..."
  exit
  ;;
esac

# install dependencies
sudo pacman -Syu yazi ffmpeg 7zip jq poppler fd ripgrep fzf zoxide resvg imagemagick xorg-server xorg-xinit hunspell trash-cli kitty ouch thunar xarchiver thunar-archive-plugin w3m gum ranger ntfs-3g gvfs firefox dex xorg-xsetroot xsel wireless_tools git xdo bspwm sxhkd hsetroot xsettingsd picom dunst xed udisks2 udiskie pacman-contrib xorg-xrandr pamixer transmission-cli nvim neovide lsof

# install plugin for yazi
ya pkg add ndtoan96/ouch
ya pkg add stelcodes/bunny
ya pkg add uhs-robert/recycle-bin

# If not CachyOS
if [ "$CO" = "no" ]; then
  sudo pacman -S fish ufw fzf
  sudo pacman -S --needed base-devel
  git clone https://aur.archlinux.org/paru.git
  cd paru
  makepkg -si
  cd $installdir
fi

# If laptop (any)
if [ "$ComT" = "ASUS" ] || [ "$ComT" = "L" ]; then
  sudo pacman -S acpi
fi

# If ASUS laptop
if [ "$ComT" = "ASUS" ]; then
  paru -S asusctl
fi

# install from the aur
paru -S dawn-bin arch-update hunspell-sv launch-cmd dragon-drop onlyoffice-bin conky-lua-nv marktext-bin autojump moonbit tdrop-git rxvt-unicode-truecolor-wide-glyphs lemonbar-xft-git tomb tufw-bin bluetuith tremc mullvad-vpn-bin zen-browser-bin librewolf-bin aurutils

# check if /$HOME/.config/ exit, if it dosen't create it
confdir="~/.config/"

if [ ! -d "$confdir" ]; then
  mkdir "$confdir"
  echo "Creating .config"
fi

# check if /$HOME/.local/share exit, if it dosen't create it
confdirb="~/.local/share/"
confdirc="~/.local/"

if [ ! -d "$confdirc" ]; then
  mkdir "$confdirc"
  echo "Creating .local"
fi

if [ ! -d "$confdirb" ]; then
  mkdir "$confdirb"
  echo "Creating .local/share"
fi

# clone zen repo and cd into it
# git clone https://github.com/interlektyr/bspwm_zen.git
# cd bspwm_zen

# chmod it up, create directories and copy files
mkdir ~/.config/bspwm/

if [ "$MonT" = "1" ]; then
  cd one_monitor/
  chmod +x bspwmrc
  cp bspwmrc ~/.config/bspwm/
  cd ..
  cd config/bspwm/
  chmod +x external_rules.sh
  cp bspwm_logo.svg external_rules.sh bspwm_exceptions.txt bspwm_applist.txt ~/.config/bspwm/
  cd ..
else
  cd config/bspwm/
  chmod +x bspwmrc external_rules.sh
  cd ..
  cp -r bspwm ~/.config/
fi

if [ "$CO" = "yes" ]; then
  cp -r alacritty ~/.config/
fi

chmod +x ranger/scope.sh

cp -r dunst gtk-3.0 nvim sxhkd yazi kitty ~/.config/
cd ..

cd home/
cp .xinitrc .Xresources .xsettingsd.conf .xsettingsd_laptopscr.conf picom.conf ~/
cd ..

cd localshare/icons/
mkdir ~/.local/share/icons/
mkdir ~/.local/share/icons/default/
cp index.theme ~/.local/share/icons/default/
cd ..
cd ..

cd usrlocalbin/
chmod +x dawn_hunspell.sh fzf_appcommander.sh bar_bat.sh bar_batdeamon.sh bar_clock.sh bar_desk.sh bar_vol.sh bspwm_hiddenwinmenu.sh bspwm_network.sh bspwm_powergmenu.sh bspwm_randwall.sh bspwm_system.sh bspwm_workspaces.sh bspwm_eject.sh bspwm_navigator.sh bspwm_layouts.sh bspwm_pepper.sh
sudo cp dawn_hunspell.sh fzf_appcommander.sh bar_clock.sh bar_desk.sh bar_vol.sh bspwm_hiddenwinmenu.sh bspwm_network.sh bspwm_powergmenu.sh bspwm_randwall.sh bspwm_system.sh bspwm_workspaces.sh bspwm_eject.sh bspwm_navigator.sh bspwm_layouts.sh bspwm_pepper.sh /usr/local/bin/

if [ "$ComT" = "ASUS" ] || [ "$ComT" = "L" ]; then
  sudo cp bar_bat.sh bar_batdeamon.sh /usr/local/bin/
fi

cd ..

confdirc="/usr/share/fonts/TTF/"

if [ ! -d "$confdirc" ]; then
  cd usrsharefonts/
  sudo cp -r TTF /usr/share/fonts/
  cd ..
else
  cd usrsharefonts/TTF/
  sudo cp -r DepartureMonoNerdFontMono-Regular.otf DepartureMonoNerdFontPropo-Regular.otf DepartureMonoNerdFont-Regular.otf /usr/share/fonts/TTF/
  cd ..
  cd ..
fi

cd usrshareicons/
sudo cp -r Oxygen_White/ /usr/share/icons/
cd ..

echo "Copying wallpapers..."
cp -r Bilder ~/
cd

echo "Base configuration is done!"
