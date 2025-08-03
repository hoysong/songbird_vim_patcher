#!/bin/bash

if ! docker container ls | grep -q cluster-tools; then
	echo "Cluster-tools is not running. Starting it now..."
	if ! make -C ~/.local/share/cluster_tools; then
		echo "Failed to start Cluster-tools."
		echo "Please run 'https://github.com/ausungju/songbird_vim_patcher/docker/INSTALL.sh' to install Cluster Tools."
		exit 1
	fi
	echo "done."
fi

if [[ $PWD != $HOME/* ]]; then
	echo "Current directory '$PWD' is not in the home directory."
	exit 1
fi

SHELL_PATH="/root/home${PWD#$HOME}"

docker exec -it -w $SHELL_PATH cluster-tools /bin/zsh