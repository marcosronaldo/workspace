GIT_DIR=`pwd`

echo "Link .vimrc, .tmux.conf and .gitconfig from $GIT_DIR to ~/"
echo "Copy .bashrc from $GIT_DIR to ~/"

cp .bashrc ~
source ~/.bashrc

cd ~/
rm -rf .vimrc
rm -rf .tmux.conf
rm -rf .gitconfig

ln -s $GIT_DIR/.vimrc
ln -s $GIT_DIR/.tmux.conf
ln -s $GIT_DIR/.gitconfig

