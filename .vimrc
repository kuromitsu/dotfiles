
""""""""""""""""""""""""
"キーマッピング
""""""""""""""""""""""""
"誤動作防止
nnoremap s <Nop>

"分割したウィンドウを移動
"画面を水平分割
nnoremap ss :split
"画面を垂直分割
nnoremap sv :vsplit
"下に移動
nnoremap sj <C-w>j
"上に移動
nnoremap sk <C-w>k
"右に移動
nnoremap sl <C-w>l
"左に移動
nnoremap sh <C-w>h
"次に移動
nnoremap sw <C-w>w

"分割したウィンドウそのものを移動する
"下に移動
nnoremap sJ <C-w>J
"上に移動
nnoremap sK <C-w>K
"右に移動
nnoremap sL <C-w>L
"左に移動
nnoremap sH <C-w>H
"回転
nnoremap sr <C-w>r

"ウィンドウの大きさ変更
"カレントウィンドウをそろえる
nnoremap s= <C-w>=
nnoremap sO <C-w>=
"縦横最大化
nnoremap so <C-w>_<C-w>l

"タブ操作
"新規タブ
nnoremap st :tabnew
"次のタブに切り替え
nnoremap sn gt
"前のタブに切り替え
nnoremap sp gT



""""""""""""""""""""""""
"各種オプションの設定
""""""""""""""""""""""""
"シンタックス有効
syntax on
"行番号表示
set number
"タブ幅設定
set tabstop=4
"vimが挿入するインデントの幅
set shiftwidth=4
"行頭の余白内でTabを打ち込むと'shiftwidth'の幅だけインデントする
set smarttab


set noignorecase
"スワップファイルを作らない
set noswapfile
"カーソルが何行目の何列目に置かれているか表示する
set ruler
"コマンドラインに使われる画面上の行数
set cmdheight=2
"ステータスラインを末尾2行目に常に表示
set laststatus=2
"ステータスライン
set statusline=%=\ [%{(&fenc!=''?&fenc:&enc)}/%{&ff}]\[%Y]\%04l,%04v][%p%%]
"ステータス行にgitbranchを表示する
"set statusline+=%{fugitve#statusline()}
"ウィンドウのタイトルバーにファイルのパス情報などを表示する
set title
"コマンドラインモードで<TAB>キーによるファイル名補完を有効にする
set wildmenu
"入力中のコマンドを表示する
set showcmd
"バックアップディレクトリの指定
set backupdir=$HOME/.vimbackup
"バッファで開いているファイルのディレクトリでエクスプローラを開始する
set browsedir=buffer
"小文字のみで検索したときに大文字、小文字を無視する
set smartcase
"検索結果をハイライト表示する
set hlsearch
"タブ入力を複数の空白入力に置き換える
"set expandtab
"不可視文字の表示
set list
"タブと行の続きを可視化する
"set listchars=tab:>\ ,extend:<
"対応する括弧やブレースを表示する
set showmatch
"改行時に前の行のインデントを継続する
set autoindent
"改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set smartindent


" helptags ~/.vim/doc

"""""""""""""""""""""""""""""""""""""""""""""""""
" スクリプト個別設定
"""""""""""""""""""""""""""""""""""""""""""""""""
"buffertabs.vim
"バッファタブにパスを省略してファイル名のみ表示する
let g:buftabs_only_basename=1
"バッファタブをステータスライン内に表示する
let g:buftabs_in_statusline=1


"------------------------------------------------
" charcode encoding
"------------------------------------------------
set encoding=utf-8
" set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set fileformats=unix,dos,mac

" souce code tag system GLOBAL settings
nmap <C-q> <C-w><C-w><C-w>q
nmap <C-g> :Gtags -g
nmap <C-l> :Gtags -f %<CR>
nmap <C-j> :GtagsCursor<CR>
nmap <C-n> :cn<CR>
nmap <C-p> :cp<CR>

" buffertabs settings
"バッファタブをステータスライン内に表示する
let g:buftabs_in_statusline=1
"現在のバッファをハイライト
let g:buftabs_active_highlight_group="Visual"
" set fold
" set foldmethod=syntax

" markdown preview
au BufRead,BufNewFile *.md set filetype=markdown
let g:previm_open_cmd = 'open -a safari'


" EOF
