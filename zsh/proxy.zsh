hostName=$(cat /etc/hostname)
if [[ $hostName == "work" ]]; then
    source $ZDOTDIR/auth.cfg
    http_proxy=$PROXY_SETTINGS
    https_proxy=$http_proxy
    no_proxy=$NO_PROXY
fi
