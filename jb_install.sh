#!/bin/bash

set -e  # หยุดการทำงานหากมีข้อผิดพลาด

echo "### Updating system ###"
sudo apt update && sudo apt upgrade -y

echo "### Installing i3-gaps ###"
sudo apt remove -y i3
sudo apt install -y meson dh-autoreconf libxcb-keysyms1-dev libpango1.0-dev \
  libxcb-util-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev \
  libstartup-notification0-dev libxcb-randr0-dev libev-dev \
  libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev \
  libxkbcommon-dev libxkbcommon-x11-dev autoconf libxcb-xrm-dev \
  libxcb-shape0-dev

cd ~
git clone https://github.com/Airblader/i3.git i3-gaps
cd i3-gaps
git checkout gaps
mkdir -p build && cd build
meson ..
ninja
sudo ninja install

echo "### Installing Neovim v0.10.4 ###"
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install -y neovim xclip

echo "### Installing Vim-Plug ###"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "### Installing Node.js ###"
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs

echo "### Installing Picom ###"
sudo add-apt-repository ppa:regolith-linux/picom -y
sudo apt update
sudo apt install -y picom

echo "### Installing Alacritty ###"
sudo add-apt-repository ppa:aslatter/ppa -y
sudo apt update
sudo apt install -y alacritty

echo "### Installing Polybar ###"
sudo apt install -y build-essential git cmake cmake-data pkg-config \
  python3-sphinx python3-packaging python3-markdown \
  libxcb-xfixes0-dev libxcb-shape0-dev libxcb-randr0-dev \
  libxcb-xinerama0-dev libxcb-util-dev libxcb1-dev libxcb-icccm4-dev \
  libxcb-ewmh-dev libxcb-composite0-dev libxcb-cursor-dev \
  libxrandr-dev libxcomposite-dev libxinerama-dev \
  libxft-dev libfreetype6-dev libfontconfig1-dev \
  libpng-dev libcurl4-openssl-dev libpulse-dev \
  libmpdclient-dev libasound2-dev libcairo2-dev \
  libiw-dev libnl-genl-3-dev libuv1-dev xcb-proto \
  python3-xcbgen libjsoncpp-dev

cd ~
git clone --recursive https://github.com/polybar/polybar.git
cd polybar
mkdir build && cd build
cmake ..
make -j$(nproc)
sudo make install

echo "### Installing Rofi ###"
sudo apt install -y rofi

echo "### Installing Blueman ###"
sudo apt install -y blueman

echo "### Installing ARM GNU Toolchain ###"
cd ~/Downloads
wget -O arm-gnu-toolchain.tar.xz https://developer.arm.com/-/media/Files/downloads/gnu/14.2.rel1/binrel/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz
tar -xf arm-gnu-toolchain.tar.xz
sudo mv arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi /opt/
echo 'export PATH=$PATH:/opt/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi/bin' >> ~/.bashrc
source ~/.bashrc


echo "### Setting up Touchpad Configuration ###"
sudo mkdir -p /etc/X11/xorg.conf.d
sudo tee /etc/X11/xorg.conf.d/40-touchpad.conf > /dev/null <<EOL
Section "InputClass"
    Identifier "Touchpad"
    MatchIsTouchpad "on"
    Driver "libinput"

    # เปิด Tap-to-click
    Option "Tapping" "on"

    # เปิด Natural Scrolling (เหมือน Windows)
    Option "NaturalScrolling" "on"

    # เปิด Two-finger Scrolling
    Option "ScrollMethod" "twofinger"

    # ปิด Acceleration (ทำให้การลากเมาส์นิ่งขึ้น)
    Option "AccelProfile" "flat"

    # เพิ่มความเร็วเมาส์ (ค่ามีช่วง -1.0 ถึง 1.0)
    Option "AccelSpeed" "0.8"
EndSection
EOL

echo "### Installation Completed! Please Restart Your System. ###"
