#!/bin/bash

failed_rm() {
	rm -rf ~/songbird_vim_patcher > /dev/null 2>&1
	rm -rf ~/.local/share/cluster_tools > /dev/null 2>&1
	rm -rf ~/.local/bin/cluster-shell > /dev/null 2>&1
	rm -rf ~/.local/bin/cluster-vim > /dev/null 2>&1
	sed -i '/alias vim=cluster-vim/d' ~/.zshrc > /dev/null 2>&1
	echo ""
	echo "Failed to install Cluster Tools. Cleaned up the temporary files."
	exit 1
}

echo "
   _____ _           _                         _           
  / ____| |         | |                       (_)          
 | |    | |_   _ ___| |_ ___ _ __ ________   ___ _ __ ___  
 | |    | | | | / __| __/ _ \ '__|______\ \ / / | '_ \` _ \ 
 | |____| | |_| \__ \ ||  __/ |          \ V /| | | | | | |
  \_____|_|\__,_|___/\__\___|_|           \_/ |_|_| |_| |_|
                                                 install.sh
"

rm -rf songbird_vim_patcher > /dev/null 2>&1
if ! git clone https://github.com/ausungju/songbird_vim_patcher.git songbird_vim_patcher; then
	exit 1
fi
echo ""

mv songbird_vim_patcher/docker songbird_vim_patcher/cluster_tools
if ! mv songbird_vim_patcher/cluster_tools ~/.local/share/; then
	failed_rm
fi
echo "Cluster-tools directory is created at ~/.local/share/cluster_tools"
echo ""

if ! link ~/.local/share/cluster_tools/cluster-shell.sh ~/.local/bin/cluster-shell; then
	failed_rm
fi
echo "Cluster-shell command is linked to ~/.local/bin/cluster-shell"
echo ""

if ! link ~/.local/share/cluster_tools/cluster-vim.sh ~/.local/bin/cluster-vim; then
    failed_rm
fi
echo "Cluster-vim command is linked to ~/.local/bin/cluster-vim"
echo ""

echo -e "alias vim='cluster-vim'\n" >> ~/.zshrc
echo "Alias for cluster-vim is set. You can use 'vim' to start cluster-vim."


echo "Building and starting the Cluster Tools Docker container..."
if ! make > /dev/null 2> error.log; then
	echo "Failed to build the Docker container. Please check error.log for details."
	failed_rm
fi
echo ""

echo ""
echo "Cluster Tools is up and running!"
echo ""

