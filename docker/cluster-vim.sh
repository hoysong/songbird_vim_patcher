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

new_args=()

if [[ $PWD == $HOME/goinfre* ]]; then
	SHELL_PATH="/root/goinfre${PWD#/home/$USER/goinfre}"
elif [[ $PWD == $HOME* ]]; then
	SHELL_PATH="/root/home${PWD#$HOME}"
else
	echo "Current directory '$PWD' is not in the home directory."
	exit 1
fi

for arg in "$@"; do
	realpath=$(realpath "$arg")
	echo $realpath
	if [[ "$realpath" == $HOME* ]]; then
		new_args+=("/root/home${realpath#$HOME}")
	elif [[ "$realpath" == /goinfre/$USER* ]]; then
		new_args+=("/root/goinfre${realpath#/goinfre/$USER}")
	else
		echo "Argument '$arg' is not in the home directory."
		exit 1
	fi
done
echo "${new_args[*]}"
docker exec -it -w "$SHELL_PATH" cluster-tools zsh -c "\\. \${HOME}/.nvm/nvm.sh && vim ${new_args[*]} "