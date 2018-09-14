cd /tmp
apt-get install libevent-dev ncurses-dev
wget https://github.com/tmux/tmux/releases/download/2.6/tmux-2.6.tar.gz
tar -zxf tmux-2.6.tar.gz
cd tmux-2.6
./configure && make
cp tmux /usr/local/bin/tmux
