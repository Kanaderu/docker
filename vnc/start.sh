#!/bin/bash

# clean $HOME/.vnc if RESET_VNC=true
[[ -v RESET_VNC ]] && [[ $RESET_VNC == "true" ]] && rm -rf $HOME/.vnc/

# setup correct xstartup for xfce4 environment in vnc
if [[ ! -f $HOME/.vnc/xstartup ]]; then
    mkdir -p $HOME/.vnc
    cat > $HOME/.vnc/xstartup << EOL
#!/bin/bash
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS

[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r \$HOME/.Xresources ] && xrdb \$HOME/.Xresources
xsetroot -solid grey
#startxfce4 &
startlxqt
#x-window-manager &

EOL
    chmod +x $HOME/.vnc/xstartup
fi

# set vnc password
if [[ ! -v VNC_PASSWORD ]]; then
    echo "VNC_PASSWORD is not set!"
else
    mkdir -p $HOME/.vnc
    # newer vncpasswd
    echo "$VNC_PASSWORD" | vncpasswd -f > $HOME/.vnc/passwd
    ## older vncpasswd
    #printf "$VNC_PASSWORD\n$VNC_PASSWORD\n\n" | vncpasswd > /dev/null
    chmod 600 $HOME/.vnc/passwd
    echo "VNC password set by ENV variable VNC_PASSWORD"
fi

# newer vncserver
vncserver $DISPLAY -geometry $GEOMETRY -depth $DEPTH -alwaysshared

## older vncserver
#vncserver $DISPLAY -geometry $GEOMETRY -depth $DEPTH

# setup websocket of noVNC
VNC_WEBSOCKET_PORT=${VNC_WEBSOCKET_PORT:-6080}
websockify -D --web=/usr/share/novnc/ ${VNC_WEBSOCKET_PORT} localhost:5900 &

# allow anyone to access xhost (dangerous!)
xhost +

x-window-manager &

# persist session
sleep infinity
