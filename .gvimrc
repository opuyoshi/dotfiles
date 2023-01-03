colorscheme slate
"colorscheme molokai

syntax on           " シンタックスカラーリングを設定する
set mouse-=a        "マウスを無効化
set number          " 行番号を表示する
set title           " 編集中のファイル名を表示する
set showcmd         " 入力中のコマンドを表示する
set ruler           " 座標を表示する
set showmatch       " 閉じ括弧の入力時に対応する括弧を表示する
set matchtime=3     " showmatchの表示時間
set laststatus=2    " ステータスラインを常に表示する
set guioptions-=T   " ツールバーを非表示
set guioptions-=r   " 右スクロールバーを非表示

" font settings
if has('unix')
  set guifont=Cica\ 12
endif
if has('win32') || has('win64')
    set guifont=Cica:h12
endif

set ambiwidth=double
set langmenu=ja_jp.utf-8  " UTF-8設定
set columns=105
set lines=56
