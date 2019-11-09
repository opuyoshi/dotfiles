# dotfiles
## About
ネットでググりながら作成したvimrcやlatexmkrcなどのドットファイルです．
ド素人が作成したので，何か気になるところがあればコメントしていただけると非常にありがたいです．
## Usage
```
cd ~
git clone https://github.com/opuyoshi/dotfiles.git
chmod +x dotfiles/setup.sh
mkdir -p ~/dotfiles/.vim/dein
cd ~/dotfiles/.vim/dein
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/dotfiles/.vim/dein
cd ~/dotfiles
./setup.sh
```
