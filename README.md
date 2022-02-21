#Neovim Lua
This config aims to use lua plugins instead of vimscript

##Install:

1. clone this repo into nvim config location:

```
mkdir -p ~/.config/nvim
git clone https://github.com/nikvdp/nvim-lsp-config/ ~/.config/nvim
```

2. Install vim-plug:

```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

3. Install a nerdfont and configure your terminal to use it (otherwise icons will not display correctly)
