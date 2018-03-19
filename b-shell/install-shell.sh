#!/bin/bash
# ====================================================
#   Copyright (C)2015 All rights reserved.
#
#   Author  : bbxytl
#   Email   : bbxytl@gmail.com
#   FileName: install.sh
#   LastModify : 2015-07-20 10:02
#   Describe:	配置 shell--Bash 环境
#
#   Log     :
#
# ====================================================


BASEDIR=$(dirname $0)
cd $BASEDIR
CURRENT_DIR=`pwd`

lnif(){
    if [ -e "$1" ];then
        ln -sf "$1" "$2"
    fi
}

today=`date +%Y%m%d`
bakdot="$HOME/mydotfiles/orgConfigBak"
if [ ! -e $bakdot ];then mkdir $bakdot; fi

echo " Step 1: backing up current config-----------Shell"
shellbak="$bakdot/ori-shell.$today"
if [ ! -e $shellbak ];then mkdir $shellbak; fi
for i in $HOME/.bashrc $HOME/.bash_profile $HOME/.dir_colors $HOME/.inputrc $HOME/.bash_alias.sh $HOME/.bash_env.sh $HOME/.pystartup.py; do [ -L $i ] && unlink $i ; done
for i in $HOME/.bashrc $HOME/.bash_profile $HOME/.dir_colors $HOME/.inputrc $HOME/.bash_alias.sh $HOME/.bash_env.sh $HOME/.pystartup.py; do [ -e $i ] && [ ! -L $i ] && mv $i $shellbak/; done

echo " Step 2: setting tu symlinks----------Shell"
B_DOT="$HOME/.b-dot"
lnif $CURRENT_DIR/bash/bashrc $HOME/.bashrc
lnif $CURRENT_DIR/bash/bash_profile $HOME/.bash_profile

lnif $CURRENT_DIR/bash/bash_env.sh $B_DOT/bash_env.sh
lnif $CURRENT_DIR/bash/bash_alias.sh $B_DOT/bash_alias.sh

lnif $CURRENT_DIR/bash/DIR_COLORS $HOME/.dir_colors
lnif $CURRENT_DIR/bash/pystartup.py $HOME/.pystartup.py

mkdir -p $HOME/.local/bin
for i in $HOME/.local/bin/clean-docker ; do [ -L $i ] && unlink $i ; done
lnif $CURRENT_DIR/bash/clean-docker.sh $HOME/.local/bin/clean-docker
export PATH=$PATH:$HOME/.local/bin

echo " Step 3: source files -----------Shell"
. $HOME/.bash_profile
. $HOME/.bashrc

