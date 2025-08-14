FROM debian:bookworm-slim

RUN apt-get update && \
	apt-get install -y \
		dumb-init build-essential \
		git curl zsh vim clangd

SHELL ["/bin/zsh", "-c"]
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended && \
	sed -i 's#^PROMPT=.*#PROMPT="(cluster_shell) %(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%} ) %{$fg[cyan]%}%c%{$reset_color%}"#' /root/.oh-my-zsh/themes/robbyrussell.zsh-theme && \
	echo -e 'alias c=clear\n' >> /root/.zshrc

ENV LC_ALL=C.UTF-8
ENV NVM_DIR /root/.nvm

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash && \
	echo 'export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"' >> /root/.zshrc && \
	echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm' >> /root/.zshrc && \
	. /root/.nvm/nvm.sh && \
	nvm install 16 && \
	${NVM_DIR}/nvm.sh


RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
	git clone https://github.com/hoysong/songbird_vim_patcher.git ~/songbird_vim_patcher && \
	cd ~/songbird_vim_patcher && \
	git pull && \
	cp ~/songbird_vim_patcher/vim_set/for_docker/main_vimrc ~/.vimrc && \
	vim -u ~/songbird_vim_patcher/vim_set/for_docker/install_vimrc -E -s +PlugInstall +qall && \
	rm -rf ~/songbird_vim_patcher

RUN mkdir -p /root/.root
RUN mkdir -p /root/.home
RUN mkdir -p /root/.goinfre

RUN cd && rm -rf ~/songbird_vim_patcher


ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
CMD ["zsh"]	
