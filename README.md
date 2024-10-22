# 도움받은 레포지토리 및 자료
현재 vim 플러그인 자동설치만 있습니다.
+ [cocnvim](https://github.com/neoclide/coc.nvim)
+ [NERDtree](https://github.com/preservim/nerdtree)
+ [syntastic](https://github.com/vim-syntastic/syntastic)
+ [Vundle.vim](https://github.com/VundleVim/Vundle.vim)
+ [vim-plug](https://github.com/junegunn/vim-plug)
+ [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)
+ [installing Obsidian](https://gist.github.com/shaybensasson/3e8e49af92d7e5013fc77da22bd3ae4c#file-install-obsidian-sh)
+ [desktop entry path](https://askubuntu.com/questions/1351795/create-launcher-for-application-not-in-usr-share-applications-in-ubuntu-20-04)
+ [gruvbox](https://github.com/morhetz/gruvbox)
+ [dracula](https://github.com/dracula/vim)
+ [solarized](https://github.com/altercation/vim-colors-solarized)
+ 
# 레포지토리 정보
+ vim의 일부 유용한 플러그인들을 간단하게 패치할 수 있는 스크립트입니다.
+ NerdTree 플러그인: vim화면 좌측에 파일트리를 생성.
+ airline을 통해 편집중인 파일의 상태를 직관적으로 확인 가능.
+ cocnvim을 통해 vscode의 함수추천기능 사용.
+ include한 헤더로부터의 함수들도 추적합니다.
+ 간단한 문법검사.

1. patch.sh will 'rm ~/.vimrc'.
patch.sh는 'rm ~/.vimrc'를 할것입니다.

this means this script will delete your original vimrc(if it exits) to make new vimrc.
해당 스크립트가 새로운 vimrc를 만들기 위해 당신의 vimrc를 삭제한다는 것을 의미합니다.

if you don't want to overwrite your original vimrc, backup somewhere.
기존 vimrc를 덮어쓰는 것을 원치 않으신다면 어딘가에 백업하세요.

2. If you already satisfied with you're vim, you don't have to use this shell script.
당신이 이미 사용중인 vim에 만족한다면 이 쉘 스크립드를 사용할 필요가 없습니다.

# how to install
+ bash patch.sh 를 통해 스크립트를 실행합니다.
+ 새로운 터미널들이 열릴 것이지만 당황하지 마세요.
+ 스크립트의 안내메시지를 따라서 '설치가 완료되면' 종료하도록 합니다.

# 간단 사용법
0. colorscheme를 변경하고 싶다면 ~/.vimrc파일을 확인하세요.

2. NerdTree (기본 활성화 상태)
':NERDTree'를 입력하여 파일트리를 활성화합니다.
nerdtree의 커서에서 s를 누르면 창을 분할하여 파일을 열 수 있습니다.

3. 창 컨트롤
ctrl+w를 누른 이후...
+ w는 다음 창으로 이동합니다.
+ j, k, h, l 등을 통해서 vim에서 줄을 이동하듯 창을 이동할 수 있습니다.
+ k = 위
+ j = 아래
+ h = 왼쪽
+ l = 오른쪽
+ q를 누르면 분할된 창을 닫습니다.
+ H, J, K, L은 창을 이동시킬 수 있습니다.

3. airline
간단하게
	수정하지 않은 파일인지,
	수정한 파일인지,
	입력모드인지,
	visual모드인지,
	등등을 키워드와 색상을 통해 직관적으로 나타냅니다.

5. 문법검사 (비활성화)
+ cocnvim 플러그인을 통해 에러를 잡아낼 수 있기에 굳이 필요하지는 않습니다..
+ .c파일에서는 간단하게 잘 작동하는 것을 확인하였습니다.
+ airline 하단의 공간에 문법이 틀리면 알려줍니다.
+ cocnvim과 문법검사 기능이 겹쳐서 비활성화 상태입니다.

7. cocnvim(자동완성)
+ 문법검사를 진행합니다.
+ 자동추천을 통해 함수의 프로토타입을 띄워줍니다.
+ 자동추천 플로팅을 통해 리턴타입, 주석설명 알 수 있습니다.
+ *.h 파일에 프로토타입을 추가하고 프로토타입의 바로 위 라인에 주석을 통하여 함수의 설명을 띄울 수 있습니다..
+ 아래 예제와 같이 표기한다면 cocnvim의 플로팅을 통해 함수의 설명을 볼 수 있다는 의미입니다.
+ 예제: hello.h 파일에..
	//hello world!를 출력하는 함수입니다.
	print_hello();
위와 같이 한다면 print_hello입력 시 'hello world!를 출력하는 함수입니다.'를 볼 수 있습니다.
 

+ ctrl+n을 누르면 다음 추천 단어를 선택합니다.
+ ctrl+p를 누르면 이전 추천 단어를 선택합니다.
