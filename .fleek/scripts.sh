#
# function install-astro {
#
#     echo cloning astronvim repo to ~/.config/nvim
#     git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
# }
# function install-starship-prompt {
#
#     if [ ! -f $HOME/.config/starship.toml ]
#     then
#     curl -fsSL https://devbox.getfleek.dev/config/starship/starship.toml > $HOME/.config/starship.toml
#     fi
# }
# function npm-global {
#
#     grep -qF '.npm-packages' ~/.npmrc || echo 'prefix=~/.npm-packages' >> ~/.npmrc
#     grep -qF '.npm-packages' ~/.zshrc || echo 'export PATH=$PATH:~/.npm-packages/bin' >> ~/.zshrc
#     grep -qF '.npm-packages' ~/.bashrc || echo 'export PATH=$PATH:~/.npm-packages/bin' >> ~/.bashrc
#     mkdir -p ~/.npm-packages
# }
