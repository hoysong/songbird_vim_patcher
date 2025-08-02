FROM debian:bookworm-slim

RUN apt-get update && \
	apt-get install -y \
		dumb-init build-essential \
		git curl zsh vim clangd

ENV LC_ALL=C.UTF-8

SHELL ["/bin/zsh", "-c"]
RUN echo -e 'alias c=clear\n' >> /root/.zshrc

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
RUN echo 'export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"' >> /root/.zshrc && echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm' >> /root/.zshrc
RUN . /root/.nvm/nvm.sh && nvm install 16
ENV NVM_DIR /root/.nvm
RUN ${NVM_DIR}/nvm.sh


RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

RUN git clone https://github.com/ausungju/songbird_vim_patcher.git ~/songbird_vim_patcher && cd ~/songbird_vim_patcher && git pull
RUN	cp ~/songbird_vim_patcher/vim_set/for_docker/main_vimrc ~/.vimrc
RUN	vim -u ~/songbird_vim_patcher/vim_set/for_docker/install_vimrc -E -s +PlugInstall +qall

RUN mkdir -p /root/home

RUN cd && rm -rf ~/songbird_vim_patcher


ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
CMD ["zsh"]	
