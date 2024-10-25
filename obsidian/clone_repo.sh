echo -e "\033[1;32m"[obsidian repository setup]"\033[0m"
YOUR_OBSIDIAN_REPO=git@github.com:hoysong/obsidian_vault.git
echo "delete ~/obsidian/obsidian_vault"
rm -rf ~/obsidian/obsidian_vault
git -C ~/obsidian clone $YOUR_OBSIDIAN_REPO
