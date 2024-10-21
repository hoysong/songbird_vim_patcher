clear
echo -e "\033[32m
   _____                   _     _         _ 
  /  ___|   song_bird     | |   (_)       | |
  \ \`--.  ___  _ __   __ _| |__  _ _ __ __| |
   \`--. \/ _ \| '_ \ / _\` | '_ \| | '__/ _\` |
  /\__/ / (_) | | | | (_| | |_) | | | | (_| |
  \____/ \___/|_| |_|\__, |_.__/|_|_|  \__,_|
                      __/ |   vim_setup.sh               
                     |___/                   
\033[0m"
echo -e "\033[32m vundlevim=============\033[0m"
echo "install vundlevim"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
echo "done!"
echo ""

echo -e "\033[32m vim plug==============\033[0m"
echo "install vim-plug..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "done!"
echo ""

echo -e "\033[32m vimrc_setup=================\033[0m"
echo "delete origin vimrc"
rm ~/.vimrc
echo "copy new vimrc"
cp .patchvimrc ~/
mv ~/.patchvimrc .vimrc
echo "done!"
echo ""

echo -e "\033[32m nodejs_setup==========\033[0m"
echo "curl nvm..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh ~/ | bash
echo "done!"
echo "Sourcing nvm..."
. ~/.nvm/nvm.sh
echo -n "nvm's version: "
nvm -v
echo "Install nodejs 16"
nvm install 16
echo "done!"
echo ""

rm -rf ~/.vimrc
cp .patchvimrc ~/.vimrc
source ~/.bashrc
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

vim +PluginInstall +qall
vim +PlugInstall +qall
rm -rf ~/.vimrc
cp ./full_vimrc/.vimrc ~/

sleep 1
gnome-terminal -- vim +"CocInstall coc-clangd"
sleep 8
gnome-terminal -- vim patch.c +"sleep 5" +"CocCommand clangd.install"
echo "don't panic. new terminal will be open."
echo "Wait until 'starting coc.vim service' in 'patch.c'vim terminal."
echo "when it appear, all setup is done."
echo "open new terminal and enjoy your new vim."
