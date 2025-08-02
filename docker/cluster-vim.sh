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


prefix="/root/home/$(pwd | sed 's/\/home\/seongkim\///')/"
new_args=()

for arg in "$@"; do
  new_args+=("${prefix}${arg}")
done

docker exec -it -w /root cluster-tools zsh -c "\\. \${HOME}/.nvm/nvm.sh && cd ${prefix} && vim ${new_args[*]}"