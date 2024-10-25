USER_NAME=$(whoami)
APP_NAME=Obsidian.AppImage
YOUR_OBSIDIAN_REPO=git@github.com:hoysong/obsidian_vault.git

echo -e "\033[1;32m"[Download $APP_NAME...]"\033[0m"
dl_url=$( curl -s https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest  \
    | grep "browser_download_url.*AppImage" | tail -n 1 | cut -d '"' -f 4 )

if [[ -z "$dl_url" ]]; then
	echo "missing download link"
    echo "usage: install-obsidian.sh"
    exit 1
fi

curl --location --output $APP_NAME "$dl_url"

chmod 777 $APP_NAME

echo -e "\033[1;32m"[Make desktop entry...]"\033[0m"
DSKTP_FILE="[Desktop Entry]
Name=Obsidian
Exec=/home/$USER_NAME/obsidian/$APP_NAME %u
Terminal=false
Type=Application
Icon=/home/$USER_NAME/obsidian/obsidian.png
StartupWMClass=obsidian
X-AppImage-Version=1.4.14
Comment=Obsidian
Categories=Office;
MimeType=text/html;x-scheme-handler/obsidian;"

echo "$DSKTP_FILE" > ~/.local/share/applications/obsidian.desktop
echo "Desktop entry setup done!"

echo -e "\033[1;32m"[obsidian directory setup]"\033[0m"
echo "trying to delete ~/obsidian (if it exits)"
rm -rf ~/obsidian
echo "mkdir ~/obsidian"
mkdir ~/obsidian
mv $APP_NAME ~/obsidian
echo "app name fixed"
cp ./obsidian.png ~/obsidian
echo "clone icon png"
bash ./clone_repo.sh

echo -e "\033[1;32m"[All setup done!]"\033[0m"
echo "your obsidian directory is in ~/obsidian"
echo "locate your obsidian git repository in obsidian directory"
