if has("systax")
    syntax on
endif
set autoindent
set cindent
set smartindent
set ts=4
set shiftwidth=4
set hlsearch
" set nu
set cursorline

set list lcs=tab:\ \ │
set relativenumber
" Enable copy to clipboard
set clipboard=unnamed

" === 터미널 관련 설정 (필요 여부에 따라 주석설정.) ===
"set termwinsize=10x210 " vim 안에서 ':term' 명령을 통해 생성된 터미널의 크기입니다. (수직)x(수평)
"autocmd VimEnter * below term  
"autocmd VimEnter * wincmd k " 생성된 터미널에 있는 커서를 편집중인 파일로 이동합니다.

set omnifunc=syntaxcomplete#Complete
filetype plugin indent on    " required
set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim " set the runtime path to include Vundle and initialize
call vundle#begin()
Plugin 'VundleVim/Vundle.vim' "let Vundle manage Vundle, required
" add airline design
Plugin 'vim-airline/vim-airline'
Plugin 'scrooloose/nerdtree' "FileTreePlugin. :NERDTreeToggle로 on off가능
Plugin 'scrooloose/syntastic' "코드 문법체크 플러그인

" 컬러스키마
Plugin 'morhetz/gruvbox'
Plugin 'dracula/vim', { 'name': 'dracula' }
Plugin 'lifepillar/vim-solarized8'
" Plugin 'nathanaelkane/vim-indent-guides' " 인던트 라인
call vundle#end()            " required
" vimplug_init
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" cocnvim의 vim 버전 차이로 인한 에러 출력을 없애줍니다.
let g:coc_disable_startup_warning = 1


"=================================================
"    below script is scheme true color setting.
"    quote or unquote below if you need to.
"=================================================
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)

if (empty($TMUX) && getenv('TERM_PROGRAM') != 'Apple_Terminal')
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

"=================================================
"        gruvbox setting
"        quote below if you don't need.
"=================================================
colorscheme gruvbox

set background=dark
let g:gruvbox_contrast_dark='soft'

"=================================================
"        dracula setting
"        quote below if you don't need.
"=================================================
"if v:version < 802
"    packadd! dracula
"endif
"syntax enable
"colorscheme dracula
"
"=================================================
"        solarized8 setting
"        quote below if you don't need.
"=================================================
"set background=dark
"autocmd vimenter * ++nested colorscheme solarized8

filetype plugin indent on    " required
autocmd VimEnter * NERDTree | set nu | wincmd p " nerdtree를 toggle on하고 커서를 우측(편집중인 파일)로 이동합니다.
autocmd VimEnter * highlight CocFloating ctermbg=0
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif
" .zshrc 파일의 마지막에 ls를 추가하면 목록이 출력됩니다.

