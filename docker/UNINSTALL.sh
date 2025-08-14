#!/bin/sh

echo "
   _____ _           _                         _           
  / ____| |         | |                       (_)          
 | |    | |_   _ ___| |_ ___ _ __ ________   ___ _ __ ___  
 | |    | | | | / __| __/ _ \ '__|______\ \ / / | '_ \` _ \ 
 | |____| | |_| \__ \ ||  __/ |          \ V /| | | | | | |
  \_____|_|\__,_|___/\__\___|_|           \_/ |_|_| |_| |_|
                                               uninstall.sh
"

# Stop and remove the Cluster Tools Docker container
make -C ~/.local/share/cluster_tools fclean > /dev/null 2>&1
echo "Cluster Tools Docker container is stopped and removed."

# Remove alias
sed -i "/alias vim='cluster-vim'/d" ~/.zshrc > /dev/null 2>&1
echo "Alias for cluster-vim is removed from ~/.zshrc"

# Remove cluster_tools
rm -rf ~/.local/share/cluster_tools > /dev/null 2>&1
echo "Cluster-tools directory is removed from ~/.local/share/cluster_tools"

# Remove symlinks
rm ~/.local/bin/cluster-shell > /dev/null 2>&1
echo "Cluster-shell command is unlinked from ~/.local/bin/cluster-shell"
rm ~/.local/bin/cluster-vim > /dev/null 2>&1
echo "Cluster-vim command is unlinked from ~/.local/bin/cluster-vim"

echo ""
echo "Cluster Tools has been successfully uninstalled."
echo "You must restart your terminal to apply the changes."
echo "You can always reinstall it by running INSTALL.sh."