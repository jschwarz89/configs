#!/bin/bash

BACKUP_DIR=~/safekeepings.$$
echo "Backuping all the existing configuration files to some safe place:"
echo "-- $BACKUP_DIR"
mkdir $BACKUP_DIR
mv -v ~/.zshrc $BACKUP_DIR
mv -v ~/.oh-my-zsh $BACKUP_DIR
mv -v ~/.vimrc $BACKUP_DIR
mv -v ~/.vim $BACKUP_DIR

echo "I assume you're running Fedora. If not, you'll need to install neovim "
echo "and zsh on your own!"
sudo dnf -y install dnf-plugins-core
sudo dnf -y copr enable dperson/neovim
sudo dnf -y install neovim zsh python3-pip python3-devel

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

curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > /tmp/neobundle.sh
bash /tmp/neobundle.sh
echo "set runtimepath^=$HOME/.vim/bundle/neobundle.vim/" > ~/.config/nvim/paths.vim
echo "call neobundle#begin(expand('$HOME/.vim/bundle'))" >> ~/.config/nvim/paths.vim

nvim +PluginInstall +UpdateRemotePlugins +qall

mkdir ~/.vim/tmp
mkdir ~/.vim/tmp/undo
mkdir ~/.vim/tmp/backup
mkdir ~/.vim/tmp/swap
