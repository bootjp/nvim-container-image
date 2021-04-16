FROM archlinux:base-devel

ENV DISPLAY :0
ENV USER bootjp
ENV HOME /home/${USER}
ENV SHELL /bin/bash
ENV TERM xterm-256color


RUN pacman -Syu --noconfirm python3 python-pip nodejs npm xsel git neovim && \
    python3 -m pip install pynvim neovim && \
    npm install -g neovim && \
    useradd -m ${USER} && \
    mkdir /home/bootjp/.local && \
    chown ${USER}:$USER -R $HOME
USER ${USER}

#ADD --chown=${USER}:${USER} https://github.com/neovim/neovim/releases/latest/download/nvim.appimage /usr/local/bin/nvim
ADD --chown=${USER}:${USER} https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh /tmp/dein.sh

RUN sh /tmp/dein.sh ~/.cache/dein 

COPY --chown=${USER}:${USER} ./dotfiles/.config/ $HOME/.config


