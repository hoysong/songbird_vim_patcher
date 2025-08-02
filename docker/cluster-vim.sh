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

prefix="/root/.host_root"
new_args=()
for arg in "$@"; do
	if [[ "$arg" == /* ]]; then
		new_args+=("$prefix$arg")
	elif [[ "$arg" == ~* ]]; then
		new_args+=("$prefix$HOME/${arg}")
	else
		new_args+=("$prefix/$PWD/$arg")
	fi
done

docker exec -it -w "${prefix}/${PWD#/}" cluster-tools zsh -c "\\. \${HOME}/.nvm/nvm.sh && vim ${new_args[*]}"