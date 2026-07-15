#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 remove -y firefox
dnf5 install -y niri
dnf5 install -y dms
dnf5 install -y brave-origin.x86_64
dnf5 install -y kde-connect
# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

mkdir -p /etc/xdg/autostart

cp /usr/share/applications/org.kde.xwaylandvideobridge.desktop /etc/xdg/autostart/ 2>/dev/null || true

if [ -f /etc/xdg/autostart/org.kde.xwaylandvideobridge.desktop ]; then
    echo "OnlyShowIn=KDE;" >> /etc/xdg/autostart/org.kde.xwaylandvideobridge.desktop
fi

systemctl enable podman.socket
