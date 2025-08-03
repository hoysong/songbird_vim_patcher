#!/bin/bash

# if ! docker container ls | grep -q cluster-tools; then
# 	echo "Cluster-tools is not running. Starting it now..."

# 	if ! make -C ~/.local/share/cluster_tools; then
# 		echo "Failed to start Cluster-tools."
# 		echo "Please run 'https://github.com/ausungju/songbird_vim_patcher/docker/INSTALL.sh' to install Cluster Tools."
# 		exit 1
# 	fi
# 	echo "done."
# fi

prefix="/root/home"
new_args=()


for arg in "$@"; do
	realpath=$(realpath "$arg")
	if [[ "$realpath" == $HOME/* ]]; then
		new_args+=("$prefix${realpath#$HOME}")
	else
		echo "Argument '$arg' is not in the home directory."
		exit 1
	fi
done

docker exec -it -w "${prefix}${PWD#$HOME}" cluster-tools zsh -c "\\. \${HOME}/.nvm/nvm.sh && vim ${new_args[*]} "