augroup vimrc
    autocmd!
augroup END

"プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/dotfiles/.vim/dein')
"dein.vim
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

"dein.vimがなければgithubからダウンロード
if &runtimepath !~# '/dein.vim'
	if !isdirectory(s:dein_repo_dir)
		execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
	endif
	execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

"start settings
if dein#load_state(s:dein_dir)
	call dein#begin(s:dein_dir)

	"TOML file
	let g:rc_dir = expand('~/dotfiles/.config/nvim')
	let s:toml = g:rc_dir . '/dein.toml'
	let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

	"TOMLを読み込み，キャッシュしておく
	call dein#load_toml(s:toml, {'lazy':0})
	call dein#load_toml(s:lazy_toml, {'lazy':1})

	"end settings
	call dein#end()
	call dein#save_state()
endif

if dein#check_install()
	call dein#install()
endif

filetype plugin indent on
syntax enable
autocmd BufRead,BufNewFile *.{text,txt,md} set filetype=markdown
autocmd! BufRead *.tex :call jobstart('latexmk -pvc')

"Ctrl+eでNERDTreeを開く
nnoremap <silent><C-e> :NERDTreeToggle<CR>

"window settings
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
"タブ移動
nnoremap sn gt
nnoremap sp gT
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>

"インサートモードのESCをjjにキーバインド
inoremap <silent>jj <ESC>

"文字コード
set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8 "保存時の文字コード
set fileencodings=ucs-boms,utf-8,euc-jp,cp932 "読み込み時の文字コードの自動判別，左側が優先される
set fileformats=unix,dos,mac "改行コードの自動判別，左側が優先される
set ambiwidth=double "文字が崩れる問題を解決

"タブ・インデント
set tabstop=4 "画面上でタブ文字が占める幅
set softtabstop=4 "連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set smartindent "改行前に前の行の構文をチェックし次の行のインデントを増減する
set expandtab    "タブ入力を複数の空白入力に置き換える
set shiftwidth=4 "smartindentで増減する幅

"文字列検索
set ignorecase "検索パターンに大文字小文字を区別しない
set smartcase "検索パターンを￥に大文字を含んでいたら大文字小文字を区別する
"ESCキー2度押しでハイライトの切り替え
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

"カーソル
set number "行番号を表示
set cursorline "カーソルラインをハイライト

"カッコ・タグジャッジ
set showmatch "括弧の対応関係を一瞬表示する
inoremap { {}<Left>
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap ( ()<ESC>i
inoremap (<Enter> ()<Left><CR><ESC><S-o>
inoremap " ""<ESC>i
inoremap ' ''<ESC>i
inoremap [ []<ESC>i

"コマンド補完
set wildmenu "コマンドモードの補完

"highlight settings
highlight SpellBad ctermfg=8
highlight DiffChange ctermfg=8

let g:python3_host_prog = $PYENV_ROOT . '/shims/python3'
