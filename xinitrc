hostName=$(cat /etc/hostname)

if [[ $hostName == "main" ]]; then
    xrandr --output DP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1 --mode 1920x1080 --pos 1920x0 --rotate normal --output DVI-D-1 --mode 1920x1080 --pos 3840x0 --rotate normal
    ln -sf ~/.config/awesome/setup/screens3.lua ~/.config/awesome/setup/screens.lua
    awesome

elif [[ $hostName == "work" ]]; then
    xrandr --output DVI-0 --off --output HDMI-0 --mode 1920x1080 --pos 1920x0 --rotate normal --output DisplayPort-0 --mode 1920x1080 --pos 0x0 --rotate normal
    ln -sf ~/.config/awesome/setup/screens2.lua ~/.config/awesome/setup/screens.lua
    awesome

elif [[ $hostName == "aux" ]]; then
    ln -sf ~/.config/awesome/setup/screens1.lua ~/.config/awesome/setup/screens.lua
    awesome
fi
