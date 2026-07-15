#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

### Install packages
dnf5 --disable-plugins install -y \
    niri \
    dms \
    brave-origin \
    kde-connect \
    xwayland

# -----------------------------------------------------------
# CORREZIONE XWAYLANDVIDEOBRIDGE (SOLO SU KDE)
# -----------------------------------------------------------
mkdir -p /etc/xdg/autostart

cp /usr/share/applications/org.kde.xwaylandvideobridge.desktop /etc/xdg/autostart/ 2>/dev/null || true

if [ -f /etc/xdg/autostart/org.kde.xwaylandvideobridge.desktop ]; then
    echo "OnlyShowIn=KDE;" >> /etc/xdg/autostart/org.kde.xwaylandvideobridge.desktop
fi

# Abilita il socket di Podman
systemctl enable podman.socket
