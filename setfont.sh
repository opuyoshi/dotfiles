curl -# -O -L https://github.com/miiton/Cica/releases/download/v5.0.1/Cica_v5.0.1_with_emoji.zip
unzip Cica_v5.0.1_with_emoji.zip
sudo mkdir -p /usr/local/share/fonts
sudo cp *.ttf /usr/local/share/fonts/
cd ~/dotfiles
rm *.ttf
rm LICENSE.txt
rm COPYRIGHT.txt
rm Cica_v5.0.1_with_emoji.zip
sudo fc-cache -vf
fc-list | grep Cica
