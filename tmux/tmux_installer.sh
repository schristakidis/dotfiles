cd /tmp
apt-get install libevent-dev ncurses-dev
wget https://github.com/tmux/tmux/releases/download/2.2/tmux-2.2.tar.gz
tar -zxf tmux-2.2.tar.gz
cd tmux-2.2
./configure && make
cp tmux /usr/local/bin/tmux
