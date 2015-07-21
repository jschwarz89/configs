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

echo "I assume you're running Fedora. If not, you'll need to install vim and"
echo "zsh on your own!"
dnf install -y vim vim-X11 zsh

echo
echo
echo "Installing configuration files..."
pushd `dirname $0` > /dev/null
CONFIGS_DIRNAME=`pwd -P`
popd > /dev/null

echo
echo
echo "Installing oh-my-zsh... Please exit the new shell that is created!!!"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
rm ~/.zshrc
ln -s $CONFIGS_DIRNAME/zshrc ~/.zshrc
ln -s $CONFIGS_DIRNAME/john.zsh-theme ~/.oh-my-zsh/themes/john.zsh-theme
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/zsh-syntax-highlighting/

echo
echo
echo "Installing vim's configuration..."
mkdir ~/.vundle  # ~/.vim/bundle should be pre-linked to ~/.vundle
ln -s $CONFIGS_DIRNAME/vimrc ~/.vimrc
ln -s $CONFIGS_DIRNAME/vim ~/.vim
git clone https://github.com/gmarik/Vundle.vim.git ~/.vundle/Vundle.vim
vim +PluginInstall +qall
