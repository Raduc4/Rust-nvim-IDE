#!/bin/bash

pacman -Syu --noconfirm --noprogressbar
pacman -S --noconfirm --noprogressbar --needed fish git base-devel neovim

curl -s https://sh.rustup.rs > rust.sh
sh rust.sh -y && rm rust.sh
rustup default stable
rustup toolchain install nightly
rustup +nightly component add rust-src rust-analyzer-preview

ln -s /root/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rust-analyzer \
 /usr/local/bin/rust-analyzer

git clone --depth 1 https://github.com/wbthomason/packer.nvim \
  ~/.local/share/nvim/site/pack/packer/start/packer.nvim

nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

mv ./* /root/.config/nvim

usermod -s /usr/sbin/fish root
fish -c "fish_add_path -aU /root/.cargo/bin/"
fish -c "fish_config prompt choose terlar && echo y | fish_config prompt save"
sed -i '2i \ \ \ \ echo (pwd) > /root/.last_folder' /root/.config/fish/functions/fish_prompt.fish

