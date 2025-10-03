#! /bin/bash

if [ "$SHELL" = '/usr/bin/zsh' ] || [ "$SHELL" = '/bin/zsh' ]; then
  read -r -p 'Install dzsh (y/N)?' ans
  if [ "$ans" = 'y' ] || [ "$ans" = 'Y' ]; then
    bash -c "$(wget https://raw.githubusercontent.com/MrRedacted/dzsh/master/install.sh -O -)"
    echo -e '\nBe sure to source .zshrc to activate dzsh!'
  fi
  echo
fi

if [ "$SHELL" = '/usr/bin/bash' ] || [ "$SHELL" = '/bin/bash' ]; then
  read -r -p 'Install dbash (y/N)?' ans
  if [ "$ans" = 'y' ] || [ "$ans" = 'Y' ]; then
    bash -c "$(wget https://raw.githubusercontent.com/MrRedacted/dbash/master/install.sh -O -)"
    echo -e '\nBe sure to source .bashrc to activate dbash!'
  fi
  echo
fi

if which tmux &>/dev/null; then
  read -r -p 'Install neomux (y/N)?' ans
  if [ "$ans" = 'y' ] || [ "$ans" = 'Y' ]; then
    wget -O ~/.tmux.conf https://raw.githubusercontent.com/MrRedacted/NeoMux/master/catpmux_macchiato.conf
  fi
  echo
fi

read -r -p 'Install mise-en-place (y/N)?' ans
if [ "$ans" = 'y' ] || [ "$ans" = 'Y' ]; then
  curl https://mise.run | sh
  echo -e '\nIf you want autocompletion for mise, visit https://mise.jdx.dev/installing-mise.html#autocompletion\n'

  read -r -p 'Insert mise activation into shell config (y/N)?' ans
  if [ "$ans" = 'y' ] || [ "$ans" = 'Y' ]; then
    case $SHELL in
    '/usr/bin/zsh' | '/bin/zsh')
      echo -e '\neval "$(~/.local/bin/mise activate zsh)"' >>~/.zshrc
      ;;
    '/usr/bin/bash' | '/bin/bash')
      echo -e '\neval "$(~/.local/bin/mise activate bash)"' >>~/.bashrc
      ;;
    *)
      echo "$SHELL is not currently supported for automatic activation, please manually activate mise"
      ;;
    esac
  fi
  echo
fi

if which mise &>/dev/null; then
  echo 'Dev tools can be installed using mise (bun, go, neovim, node, python, usage, zig)'
  read -r -p 'Install dev tools (y/N)?' ans
  if [ "$ans" = 'y' ] || [ "$ans" = 'Y' ]; then
    mise use -g bun go neovim node python usage zig
  fi
  echo
fi

if which nvim &>/dev/null && which git &>/dev/null; then
  read -r -p 'Install dmacs (y/N)?' ans
  if [ "$ans" = 'y' ] || [ "$ans" = 'Y' ]; then
    echo -e '\nBefore install, be sure to back up your existing neovim config'
    echo 'A Nerd Font and ripgrep are also required to run dmacs'
    read -r -p 'Continue with installation (y/N)?' ans
    if [ "$ans" = 'y' ] || [ "$ans" = 'Y' ]; then
      git clone https://github.com/MrRedacted/dmacs.git ~/.config/nvim
      echo
      echo 'Post-installation steps for dmacs:'
      echo '- Run nvim to allow Lazy.nvim to bootstrap itself'
      echo '- Once bootstrapping has finished, press q to exit Lazy'
      echo '- Press <space>mi to install pre-configured Mason package list'
      echo '- Once the Mason installs have finished, press q to exit Mason, then exit Neovim'
      echo '- Run ~/.config/nvim/setup.sh'
    fi
  fi
fi
