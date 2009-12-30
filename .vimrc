if $SHELL =~ '/fish$'
  set shell=zsh
endif

set nocompatible

set enc=utf-8
set fenc=utf-8
set fencs=utf-8,iso-2022-jp,euc-jp,cp932
set ambiwidth=double

set ignorecase
set smartcase
set wrapscan
set incsearch
set hlsearch

set tabstop=2
set shiftwidth=2
set expandtab

set nonumber
set noruler
set nolist
set showmatch
set wrap
set title
set showcmd
set showtabline=1
set cmdheight=2
set laststatus=2
" status line {{{
set showcmd
set cmdheight=2
set laststatus=2
set wildmenu
"set autochdir

" set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}
set statusline=
set statusline+=[*%n]\  " バッファ番号
set statusline+=%f\     " ファイル名
set statusline+=%{'['.(&fenc!=''?&fenc:'?').'-'.&ff.']'} " 文字コード
"set statusline+=%{'['.GetShortEncodingJP().'-'.&ff.']'} " 文字コード
set statusline+=%y      " ファイルタイプ
set statusline+=%r      " 読み取り専用フラグ
set statusline+=%h      " ヘルプバッファ
set statusline+=%w      " プレビューウィンドウ
set statusline+=%m      " バッファ状態[+]とか
set statusline+=%=      " 区切り
" set statusline+=\ %{strftime('%c')}  " 時間
set statusline+=%4l/%4L%4p%%   " どこにいるか
set statusline+=\ %3c    " 列
set statusline+=\ %4B    " 文字コード
set statusline+=%<       " 折り返しの指定
" }}}
" }}}

set backspace=2
set scrolloff=5
set formatoptions+=mM
let format_join_spaces = 4
let format_allow_over_tw = 1
set nobackup
set history=1000
set mouse=a
set guicursor=a:blinkon0

"set iminsert=0
"set imsearch=0
set imdisable
set iminsert=1
set imsearch=1

filetype plugin indent on

syntax on

hi Search term=reverse ctermbg=DarkBlue ctermfg=NONE

set autoindent
set cindent

"---------------------------------------------------------------
" Key Map
"
imap < <><LEFT>
imap ( ()<LEFT>
imap [ []<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>

" emacs keybind
imap <C-a> <ESC>I
imap <C-e> <ESC>A
nmap <C-a> I
nmap <C-e> A
imap <C-d> <DEL>
imap <C-h> <BS>
imap <C-f> <RIGHT>
imap <C-b> <LEFT>
"imap <C-n> <DOWN>
"imap <C-p> <UP>
imap <C-k> <ESC><RIGHT>DA
nnoremap <SPACE> i<SPACE><ESC><RIGHT>
nmap { A<SPACE>{}<LEFT><CR><ESC>O

" Leader
let mapleader = ","

noremap <Leader>ww :w<CR>

"---------------------------------------------------------------
" PHP
"
autocmd FileType php set tabstop=2
autocmd FileType php set shiftwidth=2

autocmd FileType php inoremap << <?php<Space><Space>?><LEFT><LEFT><LEFT>
autocmd FileType php inoremap <<< <?php<Space>echo<Space><Space>?><LEFT><LEFT><LEFT>
autocmd! BufRead,BufNewFile *.inc set filetype=php
autocmd! BufRead,BufNewFile *.phtml set filetype=php

" Drupal
augroup drupalmodule
  autocmd BufRead,BufNewFile *.module set filetype=php
  autocmd BufRead,BufNewFile *.install set filetype=php
  autocmd BufRead,BufNewFile *.engine set filetype=php
augroup END

"---------------------------------------------------------------
" Ruby
"
autocmd FileType ruby set tabstop=2
autocmd FileType ruby set shiftwidth=2
autocmd FileType ruby imap class<Space> class<Space><CR>end<UP><ESC>AClassName<ESC>bgh<RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT>
autocmd FileType ruby imap def<Space> def<Space><CR>end<UP><ESC>Amethod_name<ESC>bgh<RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT>
autocmd FileType ruby imap do<Space> do<Space><CR>end<UP><ESC>A
autocmd FileType ruby imap #{ #{}<LEFT>
autocmd FileType eruby inoremap << <%<Space><Space>%><LEFT><LEFT><LEFT>
autocmd FileType eruby inoremap <<< <%=<Space><Space>%><LEFT><LEFT><LEFT>

autocmd FileType ruby nmap <leader>x :!ruby %<CR>
autocmd FileType ruby nmap <leader>c :!ruby -c %<CR>

autocmd BufRead,BufNewFile *.rash set filetype=ruby
autocmd BufRead,BufNewFile .autotest set filetype=ruby

function! RspecExec ()
  let cmd=':!spec -fs -l '.line('.').' "%" '
  execute cmd
endfunction
autocm FileType ruby nmap <leader>r :call RspecExec()<CR>

"---------------------------------------------------------------
" Perl
"
autocmd FileType perl nmap <leader>x :!perl %<CR>
autocmd FileType perl nmap <leader>c :!perl -c %<CR>

"---------------------------------------------------------------
" plugins
"
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

map <F6> :source ~/.vimrc<CR>
map <F4> :bd<CR>

"---------------------------------------------------------------
" Grep.vim
"
let Grep_Skip_Dirs = '.svn .git'
let Grep_Skip_Files = '*.swp tags'
let Grep_Find_Use_Xargs = 0
let Grep_Shell_Quote_Char = '"' 

nmap <leader>gr :Rgrep<CR>


"---------------------------------------------------------------
" SrcExpl
"
let g:SrcExpl_RefreshTime   = 1
let g:SrcExpl_WinHeight     = 9
let g:SrcExpl_UpdateTags    = 1
let g:SrcExpl_RefreshMapKey = "<Space>"
let g:SrcExpl_GoBackMapKey  = "<C-b>"
nmap <leader>s :SrcExplToggle<CR>

"---------------------------------------------------------------
" VTreeExplorer
"
let g:treeExplVertical=1
nmap <F7> :bd TreeExplorer<CR>
nmap <F8> :VST<CR>

"---------------------------------------------------------------
" rails.vim
"
let g:rails_some_option=1

"---------------------------------------------------------------
" surround.vim
"
imap <C-t> <C-g>s

" Ruby
autocmd FileType ruby let g:surround_{char2nr('q')} = "%q{\r}"
autocmd FileType ruby let g:surround_{char2nr('Q')} = "%Q{\r}"
autocmd FileType ruby let g:surround_{char2nr('r')} = "%r{\r}"
autocmd FileType ruby let g:surround_{char2nr('%')} = "%(\r)"
autocmd FileType ruby let g:surround_{char2nr('w')} = "%w(\r)"
autocmd FileType ruby let g:surround_{char2nr('W')} = "%W(\r)"
autocmd FileType ruby let g:surround_{char2nr('#')} = "#{\r}"
autocmd FileType ruby let g:surround_{char2nr('e')} = "begin \r end"
autocmd FileType ruby let g:surround_{char2nr('i')} = "if \1if\1 \r end"
autocmd FileType ruby let g:surround_{char2nr('u')} = "unless \1unless\1 \r end"
autocmd FileType ruby let g:surround_{char2nr('C')} = "class \1class\1 \r end"
autocmd FileType ruby let g:surround_{char2nr('m')} = "module \1module\1 \r end"
autocmd FileType ruby let g:surround_{char2nr('d')} = "def \1def\1\2args\r..*\r(&)\2 \r end"
autocmd FileType ruby let g:surround_{char2nr('b')} = "\1method\1 { \2args\r..*\r|&|\2 \r }"
autocmd FileType ruby let g:surround_{char2nr('B')} = "\1method\1 do \2args\r..*\r|&| \2\r end"

" PHP
autocmd FileType php let g:surround_{char2nr('?')} = "<?php \r ?>"

" Javascript
autocmd FileType javascript let g:surround_{char2nr('f')} = "function() { \r }"
autocmd FileType javascript let g:surround_{char2nr('F')} = "function \1function\1(\2args\2) { \r }"

" HTML
autocmd FileType html,eruby,php let b:surround_{char2nr('1')}  = "<h1>\r</h1>"
autocmd FileType html,eruby,php let b:surround_{char2nr('2')}  = "<h2>\r</h2>"
autocmd FileType html,eruby,php let b:surround_{char2nr('3')}  = "<h3>\r</h3>"
autocmd FileType html,eruby,php let b:surround_{char2nr('4')}  = "<h4>\r</h4>"
autocmd FileType html,eruby,php let b:surround_{char2nr('5')}  = "<h5>\r</h5>"
autocmd FileType html,eruby,php let b:surround_{char2nr('6')}  = "<h6>\r</h6>"

autocmd FileType html,eruby,php let b:surround_{char2nr('p')} = "<p>\r</p>"
autocmd FileType html,eruby,php let b:surround_{char2nr('u')} = "<ul>\r</ul>"
autocmd FileType html,eruby,php let b:surround_{char2nr('o')} = "<ol>\r</ol>"
autocmd FileType html,eruby,php let b:surround_{char2nr('l')} = "<li>\r</li>"
autocmd FileType html,eruby,php let b:surround_{char2nr('a')} = "<a\1href\r..*\r href=\"&\"\1>\r</a>"
autocmd FileType html,eruby,php let b:surround_{char2nr('i')} = "<img\1src\r..*\r src=\"&\"\1\2alt\r..*\r alt=\"&\"\2>\r</img>"
autocmd FileType html,eruby,php let b:surround_{char2nr('d')} = "<div\1id\r..*\r id=\"&\"\1\2class\r..*\r class=\"&\"\2>\r</div>"
autocmd FileType html,eruby,php let b:surround_{char2nr('i')} = "id=\"\r\""
autocmd FileType html,eruby,php let b:surround_{char2nr('c')}= "class=\"\r\""
autocmd FileType html,eruby,php let b:surround_{char2nr('s')}= "style=\"\r\""

"---------------------------------------------------------------
" fuzzyfinder.vim
"

"let g:fuf_modesDisable = [ 'mrufile', 'mrucmd', ]
let g:fuf_modesDisable = []
let g:fuf_file_exclude = '\v\~$|\.(o|exe|bak|swp|gif|jpg|png)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])'
let g:fuf_mrufile_exclude = '\v\~$|\.bak$|\.swp|\.howm$|\.(gif|jpg|png)$'
let g:fuf_mrufile_maxItem = 10000
let g:fuf_enumeratingLimit = 20
let g:fuf_keyPreview = '<C-]>'
let g:fuf_previewHeight = 0

nmap <leader>fr :FufBookmark<CR>
nmap <leader>fb :FufBuffer<CR>
nmap <leader>fd :FufDir<CR>
nmap <leader>fdb :FufDirWithCurrentBufferDir<CR>
nmap <leader>fdf :FufDirWithFullCwd<BR>
nmap <leader>fi :FufEditInfo<CR>
nmap <leader>ff :FufFile<CR>
nmap <leader>fl :FufLine<CR>
nmap <leader>mf :FufMruFile<CR>
nmap <leader>mc :FufMruCmd<CR>

"---------------------------------------------------------------
" smartchr
"
inoremap <expr> = smartchr#one_of(' = ', ' => ', ' == ', ' \|\|= ', '=', '===', ' = ' )
inoremap <expr> + smartchr#one_of(' + ', ' += ', '+', ' + ')

"---------------------------------------------------------------
" neocomplcache
"
let g:NeoComplCache_EnableAtStartup = 1
let g:NeoComplCache_DisableAutoComplete = 0
let g:NeoComplCache_TemporaryDir = $HOME.'/.neocon'

" popup
let g:NeoComplCAche_MaxList = 100
let g:NeoComplCache_MaxKeywordWidth = 50
let g:NeoComplCache_MaxFilenameWidth = 50

" start length
let g:NeoComplCache_KeywordCompletionStartLength = 2
let g:NeoComplCache_ManualCompletionStartLength = 2
let g:NeoComplCache_MinKeywordLength = 4
let g:NeoComplCache_MinSyntaxLength = 4

" ignorecase
let g:NeoComplCache_IgnoreCase = 0
let g:NeoComplCache_SmartCase = 1

" sort order
let g:NeoComplCache_AlphabeticalOrder = 0
let g:NeoComplCache_PreviousKeywordCompletion = 1
let g:NeoComplCache_CalcRankRandomize = 1

" skip
"let g:NeoComplCache_EnableSkipCompletion = 1
"let g:NeoComplCache_SkipCompletionTime = '0.2'
"let g:NeoComplCache_SkipInputTime = '1.5'

" caching
let g:NeoComplCache_CacheLineCount = 70
let g:NeoComplCache_CachingRandomize = 1
let g:NeoComplCache_CachingLimitFileSize = 1000000
let g:NeoComplCache_CachingDisablePattern = '\.log$\|\.ya?ml'

" info
let g:NeoComplCache_EnableInfo = 1
let g:NeoComplCache_EnableDispalyParameter = 1

" completion
let g:NeoComplCache_EnableCamelCaseCompletion = 0
let g:NeoComplCache_EnableUnderbarCompletion = 1

" popup shortcut
let g:NeoComplCache_EnableWildCard = 1 " wild card '*'
let g:NeoComplCache_EnableQuickMatch = 1 " type '-' and select popup number

" Define dictionary.
"let g:NeoComplCache_DictionaryFileTypeLists = {
"  \ 'default' : '',
"  \ 'vimshell' : $HOME.'/.vimshell_hist',
"  \ 'scheme' : $HOME.'/.gosh_completions',
"  \ 'ruby' : $HOME.'/.vim/dict/ruby.dict'
"  \ }

" Define keyword.
if !exists('g:NeoComplCache_KeywordPatterns')
  let g:NeoComplCache_KeywordPatterns = {}
endif
let g:NeoComplCache_KeywordPatterns['default'] = '\h\w*'
 
" <TAB> completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" C-jでオムニ補完
inoremap <expr> <C-j> &filetype == 'vim' ? "\<C-x>\<C-v>\<C-p>" : "\<C-x>\<C-o>\<C-p>"
" C-hで補完を続行しない
inoremap <expr><C-h> pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"
" C-nでneocomplcache補完
inoremap <expr><C-n> pumvisible() ? "\<C-n>" : "\<C-x>\<C-u>\<C-p>"
" C-pでkeyword補完
inoremap <expr><C-p> pumvisible() ? "\<C-p>" : "\<C-p>\<C-n>"
" 途中でEnterしたとき、ポップアップを消して改行し、
" 改行を連続して入力してもインデント部を保持する
inoremap <expr><CR> pumvisible() ? "\<C-y>\<CR>X\<BS>" : "\<CR>X\<BS>"
