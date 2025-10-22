#!/bin/sh

#needs aurutils, pacman-contrib gum

run_mirror () {
sudo mirror
}

update_sys () {

if [ "$nopkmn" -lt 1 ]; then
    if [ "$noaur" -lt 1 ]; then
        #echo "The system is up to date" > ~/options.txt
        exit
    else
        #echo "Updates available (AUR: $noaur $anol)" > ~/options.txt
        urxvtc -g 100x40 -e sh -c "paru"
        exit
    fi
else
    if [ "$noaur" -lt 1 ]; then
        #echo "Updates available (pacman: $nopkmn $pnol)" > ~/options.txt
        urxvtc -g 100x40 -e sh -c "sudo pacman -Syu"
    else
        #echo "Updates available (pacman: $nopkmn $pnol, AUR: $noaur $anol)" > ~/options.txt
        case $(gum choose --limit 1 Pacman AUR Both Cancel) in
            "Pacman")
            urxvtc -g 100x40 -e sh -c "sudo pacman -Syu"
            exit;;
            "AUR")
            urxvtc -g 100x40 -e sh -c "paru"
            exit;;
            "Both")
            urxvtc -g 100x40 -e sh -c "paru"
            exit;;
            "Cancel")
            exit;;
        esac

    fi
fi

}

nopkmn=$(gum spin --spinner pulse --title "Checking for updates (pacman)" --show-output -- checkupdates | wc -l)
noaur=$(gum spin --spinner pulse --title "Checking for updates (AUR)" --show-output -- pacman -Qm | aur vercmp | wc -l)

#gum spin --spinner dot --title "Checking for updates" --show-output -- pacman -Qm | aur vercmp | wc -l > $noaur
#noaur=$(pacman -Qm | aur vercmp | wc -l)
#gum spin --spinner dot --title "Checking for updates" --show-output -- checkupdates | wc -l > $nopkmn
#nopkmn=$(checkupdates | wc -l)

if [ "$nopkmn" -gt 1 ]; then
    pnol="pkgs"
else
    pnol="pkg"
fi

if [ "$noaur" -gt 1 ]; then
    anol="pkgs"
else
    anol="pkg"
fi

if [ "$nopkmn" -lt 1 ]; then
    if [ "$noaur" -lt 1 ]; then
        echo "The system is up to date" > ~/options.txt
    else
        echo "Updates available (AUR: $noaur $anol)" > ~/options.txt
    fi
else
    if [ "$noaur" -lt 1 ]; then
        echo "Updates available (pacman: $nopkmn $pnol)" > ~/options.txt
    else
        echo "Updates available (pacman: $nopkmn $pnol, AUR: $noaur $anol)" > ~/options.txt
    fi
fi

echo "Manage snapshots" >> ~/options.txt
echo "CachyOS Hello" >> ~/options.txt
echo "Monitor system" >> ~/options.txt
echo "Cancel" >> ~/options.txt

case $(cat ~/options.txt | gum filter --header="System") in
    "The system is up to date"|"Updates available (AUR: $noaur $anol)"|"Updates available (pacman: $nopkmn $pnol)"|"Updates available (pacman: $nopkmn $pnol, AUR: $noaur $anol)")
    update_sys;;
    "Manage snapshots")
    urxvtc -e sh -c "sudo btrfs-assistant" 
    exit
    ;;
    "CachyOS Hello")
    cachyos-hello
    exit
    ;; 
    "Monitor system")
    urxvtc -g 120x35 -e sh -c "btop" 
    exit
    ;; 
    *)
    exit;;
esac
    



