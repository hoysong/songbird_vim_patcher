#!/bin/bash


failed_exit() {

	echo ""
	echo "Failed to install Cluster Tools. Cleaned up the temporary files."
	echo "check error.log for more details."
	exit 1
}

CLEAN_UP=0

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

	failed_exit
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

if ! git clone https://github.com/ausungju/songbird_vim_patcher.git songbird_vim_patcher; then
	exit 1
fi
echo ""

mv songbird_vim_patcher/docker songbird_vim_patcher/cluster_tools
if ! mv songbird_vim_patcher/cluster_tools ~/.local/share/ 2> >(tee error.log >&2); then
	cleanup
	failed_exit
fi
CLEAN_UP=1
echo "Cluster-tools directory is created at ~/.local/share/cluster_tools"
echo ""

if ! link ~/.local/share/cluster_tools/cluster-shell.sh ~/.local/bin/cluster-shell 2>> >(tee error.log >&2); then
	cleanup
	failed_exit
fi
CLEAN_UP=2
echo "Cluster-shell command is linked to ~/.local/bin/cluster-shell"
echo ""

if ! link ~/.local/share/cluster_tools/cluster-vim.sh ~/.local/bin/cluster-vim 2> >(tee error.log >&2); then
    cleanup
	failed_exit
fi
CLEAN_UP=3
echo "Cluster-vim command is linked to ~/.local/bin/cluster-vim"
echo ""

echo -e "alias vim='cluster-vim'\n" >> ~/.zshrc
echo "Alias for cluster-vim is set. You can use 'vim' to start cluster-vim."
echo -e "export PATH=\"\$PATH:~/.local/bin\"\n" >> ~/.zshrc
echo "PATH is updated to include ~/.local/bin."


echo -e "HOST_HOME=$HOME" >> ~/.local/share/cluster_tools/.env


echo "Building and starting the Cluster Tools Docker container..."
make -C ~/.local/share/cluster_tools fclean > /dev/null 2>&1
if ! make -C ~/.local/share/cluster_tools; then
	cleanup
	failed_exit
fi
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
