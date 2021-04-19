FROM archlinux:base-devel

ENV DISPLAY :0
ENV USER bootjp
ENV HOME /home/${USER}
ENV SHELL /bin/bash
ENV TERM xterm-256color


# glibc bug fix
RUN patched_glibc=glibc-linux4-2.33-4-x86_64.pkg.tar.zst \
    && curl -LO "https://raw.githubusercontent.com/sickcodes/Docker-OSX/master/${patched_glibc}" \
    && bsdtar -C / -xvf "${patched_glibc}" || echo "Everything is fine."

RUN pacman -Syu --noconfirm python3 python-pip nodejs npm xsel git neovim openssh && \
    python3 -m pip install pynvim neovim && \
    npm install -g neovim && \
    useradd -m ${USER} && \
    mkdir /home/${USER}/.local && \
    chown ${USER}:${USER} -R $HOME

USER ${USER}

ADD --chown=${USER}:${USER} https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh /tmp/dein.sh
COPY --chown=${USER}:${USER} ./dotfiles/ $HOME/dotfiles/

RUN sh /tmp/dein.sh ~/.cache/dein && \
    ln -s $HOME/dotfiles/.bashrc ~/.bashrc && \
    ln -s $HOME/dotfiles/.bash_profile ~/.bash_profile && \
    ln -s $HOME/dotfiles/.config ~/.config && \
    ln -s $HOME/dotfiles/.gitconfig ~/.gitconfig && \
    ln -s $HOME/dotfiles/.gitignore_global ~/.gitignore_global

WORKDIR $HOME

CMD ["nvim"]
