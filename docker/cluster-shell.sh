#!/bin/bash

version=$(curl -s https://raw.githubusercontent.com/hoysong/songbird_vim_patcher/main/docker/version | grep '^version:' | awk '{print $2}')
local_version=$(cat ~/.local/share/cluster_tools/version | grep "version" | cut -d " " -f 2)
mode=$(cat ~/.local/share/cluster_tools/info | grep "mode" | cut -d " " -f 2)


# Check for updates
if [ "$version" != "$local_version" ]; then
	echo "New version available: $version"
	echo 'You can update by running "bash -c \"$(curl -fsSL https://raw.githubusercontent.com/hoysong/songbird_vim_patcher/main/docker/REINSTALL.sh)\" && source ~/.zshrc"'
fi

# check if cluster-tools is running
if ! docker container ls | grep -q cluster-tools; then
	echo "Cluster-tools is not running. Starting it now..."
	if [ ! -d "~/.local/share/cluster_tools" ]; then
		echo "Not installed Cluster-tools."
		echo 'Please run "bash -c \"$(curl -fsSL https://raw.githubusercontent.com/hoysong/songbird_vim_patcher/main/docker/INSTALL.sh)\" && source ~/.zshrc" to install Cluster Tools.'
		exit 1
	fi
	if ! make -C ~/.local/share/cluster_tools; then
		echo "Failed to start Cluster-tools."
		echo 'Please run "bash -c \"$(curl -fsSL https://raw.githubusercontent.com/hoysong/songbird_vim_patcher/main/docker/REINSTALL.sh)\" && source ~/.zshrc" to reinstall Cluster Tools.'
		exit 1
	fi
	echo "done."
fi

# check if terminator is used
if ! pstree -ps $$ | grep -q "terminator"; then
	echo "To maintain terminal transparency in cluster_vim, you must run the terminal with terminator."
fi

# get terminator transparency
TERMINATOR_TRANSP=""
if [ -d ~/.config/terminator ]; then
	if [ -e ~/.config/terminator/config ]; then
		TERMINATOR_TRANSP=$(cat ~/.config/terminator/config | grep "background_darkness" | awk '{print $3}')
	fi
fi

# set SHELL_PATH
if [ "$mode" == "42gs" ]; then
	if [[ $PWD == $HOME/goinfre* ]]; then
		SHELL_PATH="/root/.goinfre${PWD#/home/$USER/goinfre}"
	elif [[ $PWD == $HOME* ]]; then
		SHELL_PATH="/root/.home${PWD#$HOME}"
	else
		echo "Current directory ‘$PWD’ is not in your home directory or goinfre."
		exit 1
	fi
elif [ "$mode" == "root" ]; then
	SHELL_PATH="/root/.root${PWD}"
fi

# start cluster-shell
docker exec -it -w $SHELL_PATH -e TERMINATOR_TRANSP="$TERMINATOR_TRANSP" cluster-tools /bin/zsh
