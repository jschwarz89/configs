#!/bin/bash

BACKUP_DIR=~/safekeepings.$$
echo "Backuping all the existing configuration files to some safe place:"
echo "-- $BACKUP_DIR"
mkdir $BACKUP_DIR
mv -v ~/.zshrc $BACKUP_DIR
mv -v ~/.oh-my-zsh $BACKUP_DIR
mv -v ~/.vimrc $BACKUP_DIR
mv -v ~/.vim $BACKUP_DIR
mv -v ~/.vundle $BACKUP_DIR

echo "I assume you're running Fedora. If not, you'll need to install neovim "
echo "and zsh on your own!"
dnf install -y neovim zsh python3-pip

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
mkdir ~/.vundle
ln -v -s $CONFIGS_DIRNAME/vim ~/.vim
ln -v -s $CONFIGS_DIRNAME/vimrc ~/.vimrc
ln -v -s ~/.vundle $CONFIGS_DIRNAME/vim/bundle
ln -v -s $CONFIGS_DIRNAME/vim ~/.config/nvim
ln -v -s $CONFIGS_DIRNAME/vimrc ~/.config/nvim/init.vim
git clone https://github.com/gmarik/Vundle.vim.git ~/.vundle/Vundle.vim
sudo pip install neovim
sudo pip3 install neovim
vim +PluginInstall +UpdateRemotePlugins +qall
mkdir ~/.vim/tmp
mkdir ~/.vim/tmp/undo
mkdir ~/.vim/tmp/backup
mkdir ~/.vim/tmp/swap
