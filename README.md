# BSPWM_zen

## Install the CachyOS

Choose No Desktop

## Apply basic config

1. clone this repo
2. run the install-scrip

## Setting up the firewall

1. Open tui-interface for ufw and start the firewall
2. Apply rules

```
sudo ufw default deny
```

```
sudo ufw allow from 192.168.0.0/24
```

3. Apply rules for ports if needed

## Configuring VPN

Follow the specific guidelines

## Enable autologin

1. Create the directory `getty@tty1.service.d` `under /etc/systemd/system`

```
cd /etc/systemd/system/
```

```
sudo mkdir getty@tty1.service.d
```
2. Open `autologin.conf` and change USERNAME to your username 
3. Move `autologin.conf` to `getty@tty1.service.d`

```
sudo cp autologin.conf /etc/systemd/system/getty@tty1.service.d
```

4. open `config.fish` under `/$HOME/.config/fish/` and paste the following:

```
function fish_greeting
    # smth smth
end

# Start X at login
if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx -- -keeptty &>/dev/null
    end
end
```
This will start X at login and disable fish-greeting when opening the terminal

## Configuring slock

1. Clone slock and cd into it

```
git clone https://git.suckless.org/slock
```

```
cd slock
```

2. Download image-patch and apply it

```
wget https://tools.suckless.org/slock/patches/background-image/slock-background-image-20220318-1c5a538.diff
```

```
git apply slock-background-image-20220318-1c5a538.diff
```

3. Open `config.h`, change user from nobody to your username and set image with path
4. Install

```
make
```

```
sudo make install
```

## Configuring "zen-mode" Firefox

1. Install Firefox
  
2. Patch it with [Textfox](https://github.com/adriankarlen/textfox)
3. Move the .css-file in textfox-folder to the chrome-folder
4. Set a coloscheme such as [Minimalist Everforest](https://addons.mozilla.org/sv-SE/firefox/addon/minimalist-everforest/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search)
  
5. Go to `about:config` and set the following to `true`: `full-screen-api.ignore-widgets`
  
6. Install [Auto Fullscreen](https://addons.mozilla.org/sv-SE/firefox/addon/autofullscreen/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search)

## Setting up Spotify

1. Install spotify-launcher
  

```
sudo pacman -S spotify-launcher
```

2. Install spicetify-cli (AUR)
  

```
paru -S spicetify-cli
```

3. Start Spotify, log in and let it run for at least 60 sec
  
4. Install Marketplace
  

```
curl -fsSL https://raw.githubusercontent.com/spicetify/marketplace/main/resources/install.sh | sh
```

5. Download themes
  

```
git clone --depth=1 https://github.com/spicetify/spicetify-themes.git
```

6. Move text to config-dir
  

```
cd spicetify-themes 
```

```
cp -r text ~/.config/spicetify/Themes
```

7. Download and replace user.css with your own from the repo
  
8. Set theme and color
  

```
spicetify config current_theme text
```

```
spicetify config color_scheme RosePineDawn
```

9. Apply
  

```
spicetify apply
```
  
10. Install spotify-control


```
paru -S spotify-control
```


Setting up

Text

