# BSPWM_zen

## Setting up the firewall

1. Open tui-interface for ufw and start the firewall
2. Apply rules

# ufw default deny

```
sudo ufw default deny
```

```
ufw allow from 192.168.0.0/24
```

## Configuring "zen-mode" Firefox

1. Install Firefox
  
2. Patch it with [Textfox](https://github.com/adriankarlen/textfox)
  
3. Set a coloscheme such as [Minimalist Everforest](https://addons.mozilla.org/sv-SE/firefox/addon/minimalist-everforest/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search)
  
4. Go to `about:config` and set the following to `true`: `full-screen-api.ignore-widgets`
  
5. Install [Auto Fullscreen](https://addons.mozilla.org/sv-SE/firefox/addon/autofullscreen/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search)

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

