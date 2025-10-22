#!/usr/bin/sh

touch /tmp/randwall.txt

cat << EOF > /tmp/randwall.txt
$(find ~/Bilder/wallpapers/ -type f | shuf -n 9)
EOF

hsetroot -cover $(sed '1q;d' /tmp/randwall.txt)


