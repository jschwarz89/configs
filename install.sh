#!/bin/bash

BACKUP_DIR=~/safekeepings.$$
echo "Backuping all the existing configuration files to some safe place:"
echo "-- $BACKUP_DIR"
mkdir $BACKUP_DIR
mv -v ~/.zshrc $BACKUP_DIR
mv -v ~/.oh-my-zsh $BACKUP_DIR
mv -v ~/.config/nvim $BACKUP_DIR

echo "I assume you're running Fedora. If not, you'll need to install neovim "
echo "and zsh on your own!"
sudo dnf -y install dnf-plugins-core
sudo dnf -y copr enable dperson/neovim
sudo dnf -y install neovim zsh python3-pip python3-devel clang clang-devel

echo
echo
echo "Installing configuration files..."
pushd `dirname $0` > /dev/null
CONFIGS_DIRNAME=`pwd -P`
popd > /dev/null

echo
echo
echo "Installing some common configuration files (bash, git...)"
ln -v -s $CONFIGS_DIRNAME/bashrc ~/.bashrc
ln -v -s $CONFIGS_DIRNAME/gitconfig ~/.gitconfig
ln -v -s $CONFIGS_DIRNAME/gitignore ~/.gitignore

echo
echo
echo "Installing oh-my-zsh... Please exit the new shell that is created!!!"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
rm ~/.zshrc
ln -v -s $CONFIGS_DIRNAME/zshrc ~/.zshrc
ln -v -s $CONFIGS_DIRNAME/john.zsh-theme ~/.oh-my-zsh/themes/john.zsh-theme
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/zsh-syntax-highlighting/

echo
echo
echo "Installing vim's configuration..."
ln -v -s $CONFIGS_DIRNAME/vim ~/.config/nvim
ln -v -s $CONFIGS_DIRNAME/vimrc ~/.config/nvim/init.vim

sudo pip install neovim
sudo pip3 install neovim

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > /tmp/installer.sh
bash /tmp/installer.sh ~/.config/nvim/bundle
echo "set runtimepath^=$HOME/.config/nvim/bundle/repos/github.com/Shougo/dein.vim" > ~/.config/nvim/paths.vim
echo "call dein#begin(expand('$HOME/.config/nvim/bundle'))" >> ~/.config/nvim/paths.vim
if [ `name` = "Darwin" ]; then
    echo "let g:python3_host_prog = '/usr/local/bin/python3'" >> ~/.config/nvim/paths.vim
    echo "let g:deoplete#sources#clang#libclang_path = '/usr/local/Cellar/llvm/3.6.2/lib/libclang.dylib'" >> ~/.config/nvim/paths.vim
    echo "let g:deoplete#sources#clang#clang_header = '/usr/local/Cellar/llvm/3.6.2/include/clang'" >> ~/.config/nvim/paths.vim
else
    echo "let g:python3_host_prog = '/usr/bin/python3'" >> ~/.config/nvim/paths.vim
    echo "let g:deoplete#sources#clang#libclang_path = '/usr/lib64/llvm/libclang.so'" >> ~/.config/nvim/paths.vim
    echo "let g:deoplete#sources#clang#clang_header = '/usr/lib/clang/3.5.0'" >> ~/.config/nvim/paths.vim
fi
nvim +qall
nvim +UpdateRemotePlugins +qall

mkdir ~/.config/nvim/tmp
mkdir ~/.config/nvim/tmp/undo
mkdir ~/.config/nvim/tmp/backup
mkdir ~/.config/nvim/tmp/swap
