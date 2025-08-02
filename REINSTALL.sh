#!/bin/bash

echo "
   _____ _           _                         _           
  / ____| |         | |                       (_)          
 | |    | |_   _ ___| |_ ___ _ __ ________   ___ _ __ ___  
 | |    | | | | / __| __/ _ \ '__|______\ \ / / | '_ \` _ \ 
 | |____| | |_| \__ \ ||  __/ |          \ V /| | | | | | |
  \_____|_|\__,_|___/\__\___|_|           \_/ |_|_| |_| |_|
                                               reinstall.sh
"

curl -fsSL https://raw.githubusercontent.com/ausungju/songbird_vim_patcher/main/docker/UNINSTALL.sh | bash

if curl -fsSL https://raw.githubusercontent.com/ausungju/songbird_vim_patcher/main/docker/INSTALL.sh | bash; then
	echo "Reinstallation successful!"
else
	echo "Reinstallation failed."
	echo "Please report this issue to the developer."
fi
