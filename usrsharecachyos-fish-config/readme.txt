#Put the following at the end of config.fish

# Start X at login
if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx -- -keeptty &>/dev/null
    end
end

#To not show fastfetch, go to file /$HOME/.config/fish/config.fish and comment out "function fish_greeting"
