#!/bin/bash

CLEAN_UP=0
CHECK_CLUSTER_VIM_ALIAS=0
CHECK_HOME_LOCAL_BIN_EXPORT=0

failed_exit() {

	echo ""
	echo "Failed to install Cluster Tools. Cleaned up the temporary files."
	echo "check error.log for more details."
	exit 1
}

cleanup() {
	if [ $CLEAN_UP -eq 0 ]; then
		rm -rf songbird_vim_patcher
	fi
	if [ $CLEAN_UP -eq 1 ]; then
		rm -rf songbird_vim_patcher
		rm -rf ~/.local/share/cluster_tools
	fi
	if [ $CLEAN_UP -eq 2 ]; then
		rm -rf songbird_vim_patcher
		rm -rf ~/.local/share/cluster_tools
		rm -rf ~/.local/bin/cluster-shell
	fi
	if [ $CLEAN_UP -eq 3 ]; then
		rm -rf songbird_vim_patcher
		rm -rf ~/.local/share/cluster_tools
		rm -rf ~/.local/bin/cluster-shell
		rm -rf ~/.local/bin/cluster-vim
		make -C ~/.local/share/cluster_tools fclean > /dev/null 2>&1
	fi

	if [ $CHECK_CLUSTER_VIM_ALIAS -eq 1 ]; then
		sed -i "/alias vim='cluster-vim'/d" ~/.zshrc > /dev/null 2>&1
	fi
	
	if [ $CHECK_HOME_LOCAL_BIN_EXPORT -eq 1 ]; then
		sed -i '/export PATH="$HOME\/.local\/bin:$PATH"/d' ~/.zshrc > /dev/null 2>&1
	fi

	failed_exit
}

repo_clone()
{
	if [ -d "songbird_vim_patcher" ]; then
		echo "songbird_vim_patcher already exists."
		echo -n "Do you want to continue after removal? [y/N]: "
		read ANSWER
		if [ "$ANSWER" != "${ANSWER#[Yy]}" ]; then
			rm -rf songbird_vim_patcher
		else
			echo "Aborting installation."
			exit 1
		fi
	fi
	echo "hoysong/songbird_vim_patcher.git cloning..."
	if ! git clone https://github.com/hoysong/songbird_vim_patcher.git songbird_vim_patcher > /dev/null 2>&1; then
		echo "Failed to clone songbird_vim_patcher repository."
		echo "Aborting installation."
		exit 1
	fi
	echo ""
	return 0
}

move_dir()
{
	if [ -d "$HOME/.local/share/cluster_tools" ]; then
		echo "Cluster Tools directory already install."
		echo -n "Do you want to continue after removal? [y/N]: "
		read ANSWER
		if [ "$ANSWER" != "${ANSWER#[Yy]}" ]; then
			echo "Aborting installation."
			exit 1
		else
			rm -rf ~/.local/share/cluster_tools
		fi
	fi
	if ! mv songbird_vim_patcher/docker ~/.local/share/cluster_tools; then
		echo "Failed to move songbird_vim_patcher/docker to ~/.local/share/cluster_tools"
		cleanup
		failed_exit
	fi
	echo "Cluster-tools directory is created at ~/.local/share/cluster_tools"
	echo ""
	return 0
}

link_tools()
{
	if [ -e $2 ]; then
		rm -f $2
	fi
	if ! ln $1 $2; then
		echo "Failed to link $1 to $2"
		cleanup
		failed_exit
	fi
	echo "Cluster-vim command is linked to $2"
	echo ""
	return 0
}

trap cleanup INT

echo "
   _____ _           _                         _           
  / ____| |         | |                       (_)          
 | |    | |_   _ ___| |_ ___ _ __ ________   ___ _ __ ___  
 | |    | | | | / __| __/ _ \ '__|______\ \ / / | '_ \` _ \ 
 | |____| | |_| \__ \ ||  __/ |          \ V /| | | | | | |
  \_____|_|\__,_|___/\__\___|_|           \_/ |_|_| |_| |_|
                                                 install.sh
"

# Check if the script is run as root
echo -n "
Mode Selection Required:

  [1] 42GS Mode - 42Gyeongsan cluster mode with restricted privileges [default]
  [2] Root Mode - Administrator mode with full system access. Not recommended for use.

Please choose your preferred mode (1 or 2):"
read MODE_CHOICE

# Not recommended for use
repo_clone
move_dir
CLEAN_UP=1

# Link cluster-tools
link_tools ~/.local/share/cluster_tools/cluster-shell.sh ~/.local/bin/cluster-shell
CLEAN_UP=2
link_tools ~/.local/share/cluster_tools/cluster-vim.sh ~/.local/bin/cluster-vim
CLEAN_UP=3


# Registering aliases and setting environment variables
if ! grep -q "alias vim='cluster-vim'" ~/.zshrc; then
	CHECK_CLUSTER_VIM_ALIAS=1
	echo -e "alias vim='cluster-vim'\n" >> ~/.zshrc
	echo "Alias for cluster-vim is set. You can use 'vim' to start cluster-vim."
else
	echo "Alias for cluster-vim already exists."
fi


if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' ~/.zshrc || ! grep -q 'export PATH="$PATH:$HOME/.local/bin"' ~/.zshrc || ! grep 'export PATH="$PATH:'$HOME'/.local/bin"' ~/.zshrc  || ! grep -q 'export PATH="'$HOME'/.local/bin:$PATH"' ~/.zshrc; then
	CHECK_HOME_LOCAL_BIN_EXPORT=1
	echo 'export PATH="$PATH:$HOME/.local/bin"' >> ~/.zshrc
	echo "PATH is updated to include ~/.local/bin"
else
	echo "PATH already includes ~/.local/bin"
fi


SET
# Setting environment variables
if [ "$MODE_CHOICE" == "2" ]; then
	echo -e "HOST_HOME=$HOME" >> ~/.local/share/cluster_tools/.env
	echo -e "HOST_GOINFRE=/goinfre/$USER" >> ~/.local/share/cluster_tools/.env
	cp ~/.local/share/cluster_tools/mount_42gs ~/.local/share/cluster_tools/docker-compose.yml
else
	echo -e "HOST_ROOT=/" >> ~/.local/share/cluster_tools/.env
	cp ~/.local/share/cluster_tools/mount_root ~/.local/share/cluster_tools/docker-compose.yml
fi
echo "Make sure to update the .env file with your local paths."
echo "Make sure to update the docker-compose.yml file with your local paths."

# Run Docker container
echo "Building and starting the Cluster Tools Docker container..."
make -C ~/.local/share/cluster_tools fclean > /dev/null 2>&1
if ! make -C ~/.local/share/cluster_tools; then
	cleanup
	failed_exit
fi

# print success message
echo ""
echo "Cluster Tools is up and running!"
echo ""
echo ""
echo "You can also run 'source ~/.zshrc' to apply the changes immediately."
echo ""
echo "You can now use the 'cluster-shell' command to access the Cluster Tools shell."
echo "To use Vim with Cluster Tools, simply run 'vim' in your terminal."
echo ""
echo "If you need to reinstall Cluster Tools, run 'REINSTALL.sh'."
echo "If you want to uninstall Cluster Tools, run 'UNINSTALL.sh'."

rm -rf songbird_vim_patcher

echo -e "version: 0.4.0" >> ~/.local/share/cluster_tools/info
if [ "$MODE_CHOICE" == "2" ]; then
	echo -e "mode: root" >> ~/.local/share/cluster_tools/info
else
	echo -e "mode: 42gs" >> ~/.local/share/cluster_tools/info
fi