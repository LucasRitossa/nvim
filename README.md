# Neovim with LSP and tree-sitter

An opinionated and simple neovim configuration with native LSP and treesitter
support. 

# Installation

1. clone this repo into nvim config location:

   ```bash 
   mkdir -p ~/.config/nvim
   git clone https://github.com/nikvdp/nvim-lsp-config/ ~/.config/nvim
   ```
2. install vim-plug:

   ```bash 
   sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
          https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
   ```

   Linux or Windows pelase follow the instructions provided at the [nerd fonts repository](https://github.com/ryanoasis/nerd-fonts).

3. Install plugins: 

   ```shell
   nvim '+PlugInstall | qa'
   ```

4. Start neovim: `nvim`
5. Install LSPs for the languages you care about via eg `:LspInstall python`.
   You can use tab completion after typing `:LspInstall ` to see which language
   servers are available

6. Add/customize your keybindings to `~/.config/nvim/init.vim`.
