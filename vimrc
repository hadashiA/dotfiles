" shellがfishだと挙動がおかしいのでzshに
if $SHELL =~ '/fish$'
  set shell=zsh
endif

" helpファイル更新
helptags $HOME/.vim/doc/

" これ必要?
hi Search term=reverse ctermbg=DarkBlue ctermfg=NONE

" Encodings: 文字コード設定 =========================================== "{{{
" from ずんWiki http://www.kawaz.jp/pukiwiki/?vim#content_1_7
if &encoding !=# 'utf-8'
  set encoding=japan
endif
 
"set fileencoding=japan
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがJISX0213に対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^euc-\%(jp\|jisx0213\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      let &encoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif

" Default fileformat.
set fileformat=unix
" Automatic recognition of a new line cord.
set fileformats=unix,dos,mac
" }}}

" Mouse: マウス設定 =================================================== "{{{
" どのモードでもマウスを使えるようにする
set mouse=a
" マウスの移動でフォーカスを自動的に切替えない (mousefocus:切替る)
"set nomousefocus
" 入力時にマウスポインタを隠す (nomousehide:隠さない)
set mousehide
" ビジュアル選択(D&D他)を自動的にクリップボードへ (:help guioptions_a)
"set guioptions+=a"}}}

" Options: オプション設定 ============================================= "{{{
syntax on
set nocompatible
set ambiwidth=double               " UTF-8で文字幅表示を２文字分使う
set completeopt=menuone,preview
set complete+=k                    " 辞書ファイルからの単語補間
set nrformats=""                   " 8進数はインクリメントしない
set expandtab                      " タブ関係の設定。http://peace-pipe.blogspot.com/2006/05/vimrc-vim.html
set tabstop=2                      
set shiftwidth=2                   
set smartindent                    " インデントはスマートインデント
set ignorecase                     " 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set smartcase                      " 検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan                       " 検索時に最後まで行ったら最初に戻る
set incsearch                      " 検索文字列入力時に順次対象文字列にヒットさせない
set hlsearch
set nolist                         " タブ文字、行末文字を非表示
set nonumber                       " 行番号を非表示
set noruler
set showcmd                        " 入力中のコマンドをステータスに表示する
set showmatch                      " 括弧入力時の対応する括弧を表示
set nobackup                       " バックアップファイルは作らない
set wildmenu                       " コマンドライン補完するときに強化されたものを使う
set wildmode=list:longest          " コマンドライン補間をシェルっぽく
"set hidden                         " バッファが編集中でもその他のファイルを開けるように
set autoread                       " 外部のエディタで編集中のファイルが変更されたら自動で読み直す
set wrap                           " 自動折り返し
set laststatus=2                   " 常にステータス行を表示 (詳細は:he laststatus)
set cmdheight=2                    " コマンドラインの高さ
set showtabline=1
set title                          " タイトルを表示
set lazyredraw                     " マクロなど実行中は描画を中断
set scrolloff=5                    " カーソルの上下n行を常に表示
set foldmethod=marker              " 折畳みを保存
"set cursorline                    " カーソル行を強調表示
"hi CursorLine gui=underline       " 下線
set viminfo='50,<1000,s100,\"50    " viminfoの上限数など
set backspace=indent,eol,start     " バックスペースを強化する設定
set textwidth=0                    " Don't wrap words by default
set history=100                    " コマンド履歴数
set guioptions-=T                  "ツールバーを表示しない
set imdisable                      " IMが使われなくなる。はず
set iminsert=1                     " IMがInsertモードで使われるかどうか。くわしくはhelp参照
set imsearch=1                     " 
"set iminsert=0
"set imsearch=0
set guicursor=a:blinkon0
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

if has('autochdir')
  set autochdir
endif

if has('migemo')
  set migemo
endif

filetype plugin indent on

set autoindent
set cindent
"}}}

" Statusline: ステータスライン設定 ============================================= "{{{
set statusline=
set statusline+=[*%n]                                     " バッファ番号
set statusline+=%m                                        " バッファ状態[+]とか
set statusline+=%r                                        " 読み取り専用フラグ
set statusline+=%h                                        " ヘルプバッファフラグ
set statusline+=%w                                        " プレビューウィンドウフラグ
set statusline+=%{'['.(&fenc!=''?&fenc:'?').'-'.&ff.']'}  " 文字コード
set statusline+=%y\                                       " ファイルタイプ
"set statusline+=%(%{GitBranch()}\ %)\                     " git current branch
set statusline+=%F\                                       " ファイル名
set statusline+=%=                                        " 区切り
" set statusline+=\ %{strftime('%c')}                     " 時間
set statusline+=%4l/%4L%4p%%                              " どこにいるか
set statusline+=\ %3c                                     " 列
set statusline+=\ %4B                                     " 文字コード
set statusline+=%<                                        " 折り返しの指定

set formatoptions+=mM
let format_join_spaces = 4
let format_allow_over_tw = 1
"}}}

" Mapping: マッピング設定 ============================================= "{{{

" Leader
let mapleader = ","
"let mapleader = "m"

imap < <><LEFT>
imap ( ()<LEFT>
imap [ []<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>

nnoremap Y y$

".vimrcの再読み込み
nnoremap ,vr :source $HOME/.vimrc<CR>:source $HOME/.gvimrc<CR>

" よくつかうディレクトリ。とりあえず
noremap <leader>enpra :e ~/dev/enpra<CR>
noremap <leader>fish :e ~/dev/fish<CR>
noremap <leader>ddu :e ~/dev/ddu<CR>
noremap <leader>hsk :e ~/dev/hadashikick<CR>

" Insertモード時、Emacs風キーバインド
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

" コマンドモードで、SPACEを入力
"nnoremap <SPACE> i<SPACE><ESC><RIGHT>

"クリップボードを使ったコピペ
vnoremap <M-c> "+y
inoremap <M-v> <MiddleMouse>
nnoremap <M-v> i<MiddleMouse><esc>

" 検索時に画面中央にくるようにする
" nzzを割り当てるとfold時の検索でnを押して次に進んだ場合に自動展開されない
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap * *zzzv
nnoremap # #zzzv
nnoremap g* g*zzzv
nnoremap g# g#zzzv

" 選択中の文字を検索する
"vnoremap <silent> n :call SelSearch()<CR>
vnoremap <silent> n :call SearchTheSelectedTextLiteraly()<CR>

" 選択中の文字をURLエスケープする（1:エンコード 2:デコード）
vnoremap <silent> <leader>ue :call UrlEscapeTheSelectedTextLiteraly(1)<CR>
vnoremap <silent> <leader>ud :call UrlEscapeTheSelectedTextLiteraly(2)<CR>

" 選択中のCSVカラム名の列をハイライト表示する
vnoremap <silent> ,hc :call CsvH()<CR>"

" select block
vmap end <ESC>0/end<CR>%V%0
vmap ef <ESC>$?\%(.*#.*def\)\@!def<CR>%V%0
vmap ss <ESC>$?\%(.*#.*class\)\@!class<CR>%V%0
vmap mod <ESC>$?\%(.*#.*module\)\@!module<CR>%V%0
"}}}

" Color: 色設定 ======================================================= "{{{
" 特定の文字を視覚化。この例では全角スペース
" TODO:listcharsの設定と調整する
"highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=white
"match ZenkakuSpace /　/
if !has('gui_running')
    set background=dark
    highlight Folded ctermfg=yellow ctermbg=black 
    highlight FoldColumn ctermfg=yellow ctermbg=black 
    highlight Pmenu ctermfg=white ctermbg=darkgray  guibg=#606060
    highlight PmenuSel ctermbg=darkred guibg=SlateBlue
    highlight PmenuSbar ctermbg=darkblue guibg=#404040
endif
"}}}

" Tags: tags設定 ====================================================== "{{{
if has("autochdir")
	set autochdir
	set tags=tags;
else
	"set tags=$HOME/.vim/tags,./tags,./../tags,./*/tags,./../../tags,./../../../tags,./../../../../tags,./../../../../../tags
	set tags+=./tags
endif
command! -nargs=? Ctags call <SID>Ctags(<q-args>)
"}}}

" Autocmd: autocmd設定 ================================================ {{{1
if has("autocmd")
    " PHP --------------------------------------------------------
    autocmd FileType php set tabstop=2
    autocmd FileType php set shiftwidth=2
    autocmd! BufRead,BufNewFile *.inc set filetype=php
    autocmd! BufRead,BufNewFile *.phtml set filetype=php
    augroup drupalmodule
      autocmd BufRead,BufNewFile *.module set filetype=php
      autocmd BufRead,BufNewFile *.install set filetype=php
      autocmd BufRead,BufNewFile *.engine set filetype=php
    augroup END
    
    " PHPの辞書補完とomni補完 -----------------------------------------------------------
    autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
    autocmd FileType php :setlocal dictionary+=~/.vim/dict/php5_functions.dict

    " Ruby
    autocmd FileType ruby set tabstop=2
    autocmd FileType ruby set shiftwidth=2
    autocmd FileType ruby,eruby setlocal omnifunc=rubycomplete#Complete
    autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
    autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
    autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
    autocmd FileType ruby imap #{ #{}<LEFT>
    autocmd FileType eruby inoremap << <%<Space><Space>%><LEFT><LEFT><LEFT>
    autocmd FileType eruby inoremap <<< <%=<Space><Space>%><LEFT><LEFT><LEFT>
    autocmd FileType ruby nmap <leader>x :!ruby %<CR>
    autocmd FileType ruby nmap <leader>c :!ruby -c %<CR>
    " rspecを実行
    autocmd FileType ruby command! RspecExec execute(':!spec -fs --drb -l '.line('.').' "%" ')

    autocmd BufRead,BufNewFile *.rash set filetype=ruby
    autocmd BufRead,BufNewFile .autotest set filetype=ruby

    autocmd FileType ruby nmap <leader>r :RspecExec<CR>

    " git.vim コミット後ログを表示する ----------------------------------------
    "autocmd BufWritePost COMMIT_EDITMSG exe ":bd" | exe ":Cd" | exe ":GitLog"

    " 前回終了したカーソル行に移動 --------------------------------------------
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
endif
"1}}}

" Function: ================================================== {{{1

" カーソル位置の文字のバイトコードを表示
function! GetB()
    let c = matchstr(getline('.'), '.', col('.') - 1)
    let c = iconv(c, &enc, &fenc)
    return String2Hex(c)
endfunction

function! Nr2Hex(nr)
    let n = a:nr
    let r = ""
    while n
        let r = '0123456789ABCDEF'[n % 16] . r
        let n = n / 16
    endwhile
    return r
endfunc

function! String2Hex(str)
    let out = ''
    let ix = 0
    while ix < strlen(a:str)
        let out = out . Nr2Hex(char2nr(a:str[ix]))
        let ix = ix + 1
    endwhile
    return out
endfunc

" csv の特定のカラムをハイライト (put in .vimrc)
" :Csv 5   # 5番めのカラムをハイライト
" @see http://www.vim.org/tips/tip.php?tip_id=667
function! CSVH(x)
    execute 'match Keyword /^\([^,]*,\)\{'.a:x.'}\zs[^,]*/'
    execute 'normal ^'.a:x.'f,'
endfunction
command! -nargs=1 Csv :call CSVH(<args>)

" html escape
function! HtmlEscape()
    silent s/&/\&amp;/eg
    silent s/</\&lt;/eg
    silent s/>/\&gt;/eg
endfunction

function! HtmlUnEscape()
    silent s/&lt;/</eg
    silent s/&gt;/>/eg
    silent s/&amp;/\&/eg
endfunction

function! SearchTheSelectedTextLiteraly()
  let reg_0 = [@0, getregtype('0')]
  let reg_u = [@", getregtype('"')]

  normal! gvy
  let @/ = @0
  call histadd('/', '\V' . escape(@0, '\'))
  normal! n

  call setreg('0', reg_0[0], reg_0[1])
  call setreg('"', reg_u[0], reg_u[1])
endfunction

function! UrlEscapeTheSelectedTextLiteraly(escape_flag)
    if !has('ruby')
        echoerr "実行にはRubyインターフェースが必要です"
        return
    end
    let reg_0 = [@0, getregtype('0')]
    let reg_u = [@", getregtype('"')]
    normal! gvy
    let @0 = UrlEscape(a:escape_flag)
    normal! gvp
    call setreg('0', reg_0[0], reg_0[1])
    call setreg('"', reg_u[0], reg_u[1])
endfunction

function! UrlEscape(escape_flag)
ruby << EOF
    require 'cgi'
    convert_text = ""
    escape_flag = {:escape => "1", :unescape => "2"}
    selected_text = VIM::evaluate('@0')
    escape_flag_param = VIM::evaluate('a:escape_flag')
    if escape_flag_param == escape_flag[:escape]
        convert_text = CGI.escape(selected_text)
    elsif escape_flag_param == escape_flag[:unescape]
        convert_text = CGI.unescape(selected_text)
    end
    VIM::command("return '#{convert_text}'")
EOF
endfunction

" .gitのあるディレクトリに移動する
function! CdDotGitDir()
    let l:current_path = getcwd()
    lcd %:p:h
    if finddir('.git','.;') !~ ".git$"
        echo 'Not found dotgit directory.'
        exec "lcd " . l:current_path
        return ''
    endif
    let l:dotgit_path = SearchDotGitPath('')
    exec "lcd " . l:dotgit_path
endfunction

function! SearchDotGitPath(search_path)
    if finddir('.git', a:search_path) =~ ".git$"
        return a:search_path
    else
        let l:search_path = a:search_path . '../'
        let l:search_result_path = SearchDotGitPath(l:search_path)
        return l:search_result_path
    endif
endfunction

" Snippet support functions
"ruby
function! Snippet_RubyClassNameFromFilename(...)
    let name = expand("%:t:r")
    if len(name) == 0
        if a:0 == 0
            let name = 'MyClass'
        else
            let name = a:1
        endif
    endif
    return Snippet_Camelcase(name)
endfunction
 
function! Snippet_MigrationNameFromFilename(...)
    let name = substitute(expand("%:t:r"), '^.\{-}_', '', '')
    if len(name) == 0
        if a:0 == 0
            let name = 'MyClass'
        else
            let name = a:1
        endif
    endif
    return Snippet_Camelcase(name)
endfunction

function! Snippet_RspecDescribeClassFromFilename(...)
  let name = substitute(expand("%:t:r"), '_spec', '', '')
  if len(name) == 0
      if a:0 == 0
          let name = 'Type'
      else
          let name = a:1
      endif
  endif
  return Snippet_Camelcase(name)
endfunction
 
"python
function! Snippet_PythonClassNameFromFilename(...)
    let name = expand("%:t:r")
    if len(name) == 0
        if a:0 == 0
            let name = 'MyClass'
        else
            let name = a:1
        endif
    endif
    return Snippet_Camelcase(name)
endfunction
 
"php
function! Snippet_PHPClassNameFromFilename(...)
    let name = expand("%:t:r:r")
    if len(name) == 0
        if a:0 == 0
            let name = 'MyClass'
        else
            let name = a:1
        endif
    endif
    return name
endfunction
 
"java
function! Snippet_JavaClassNameFromFilename(...)
    let name = expand("%:t:r")
    if len(name) == 0
        if a:0 == 0
            let name = 'MyClass'
        else
            let name = a:1
        endif
    endif
    return name
endfunction
 
function! Snippet_JavaInstanceVarType(name)
    let oldview = winsaveview()
    if searchdecl(a:name) == 0
        normal! B
        let old_reg = @"
        normal! yaW
        let type = @"
        let @" = old_reg
        call winrestview(oldview)
        let type = substitute(type, '\s\+$', '', '')
 
"searchdecl treats 'return foo;' as a declaration of foo
        if type != 'return'
            return type
        endif
    endif
    return "<+type+>"
endfunction
 
 
"global
function! s:Start_comment()
    return substitute(&commentstring, '^\([^ ]*\)\s*%s\(.*\)$', '\1', '')
endfunction
 
function! s:End_comment()
    return substitute(&commentstring, '^.*%s\(.*\)$', '\1', '')
endfunction
 
function! Snippet_Modeline()
    return s:Start_comment() . " vim: set ${1:settings}:" . s:end_comment()
endfunction
 
function! Snippet_Camelcase(s)
"upcase the first letter
    let toReturn = substitute(a:s, '^\(.\)', '\=toupper(submatch(1))', '')
"turn all '_x' into 'X'
    return substitute(toReturn, '_\(.\)', '\=toupper(submatch(1))', 'g')
endfunction
 
function! Snippet_Underscore(s)
"down the first letter
    let toReturn = substitute(a:s, '^\(.\)', '\=tolower(submatch(1))', '')
"turn all 'X' into '_x'
    return substitute(toReturn, '\([A-Z]\)', '\=tolower("_".submatch(1))', 'g')
endfunction
"}}}

" Command: コマンド設定  ============================================== {{{1
"1}}}

" Plugin: プラグイン設定 ============================================== {{{1

" Grep.vim ----------------------------------------------------- {{{2
let Grep_Skip_Dirs = '.svn .git'
let Grep_Skip_Files = '*.swp tags'
let Grep_Find_Use_Xargs = 0
let Grep_Shell_Quote_Char = '"' 

" git.vim ----------------------------------------------------- {{{2
autocmd FileType git* set noautochdir

" SrcExpl ----------------------------------------------------- {{{2
let g:SrcExpl_RefreshTime   = 1
let g:SrcExpl_WinHeight     = 9
let g:SrcExpl_UpdateTags    = 1
let g:SrcExpl_RefreshMapKey = "<Space>"
let g:SrcExpl_GoBackMapKey  = "<C-b>"
nmap <leader>s :SrcExplToggle<CR>

" VTreeExplorer ----------------------------------------------------- {{{2
let g:treeExplVertical=1
nmap <F7> :bd TreeExplorer<CR>
nmap <F8> :VST<CR>

" rails.vim ----------------------------------------------------- {{{2
let g:rails_some_option=1

" Align.vim ----------------------------------------------------- {{{2
let g:Align_xstrlen = 3
" remap
vmap = :Align =<CR>
vmap @ :Align =><CR>
vmap , :Align ,<CR>

" surround.vim ----------------------------------------------------- {{{2
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
autocmd FileType html,eruby,php let b:surround_{char2nr('c')} = "class=\"\r\""
autocmd FileType html,eruby,php let b:surround_{char2nr('s')} = "style=\"\r\""
"2}}}
" fuf.vim ----------------------------------------------------------- {{{2
"let g:fuf_modesDisable = [ 'mrufile', 'mrucmd', ]
let g:fuf_modesDisable = [ 'mrucmd', ]
let g:fuf_file_exclude = '\v\~$|\.(o|exe|bak|swp|gif|jpg|png)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])'
let g:fuf_mrufile_exclude  = '\v\~$|\.bak$|\.swp|\.howm$|\.(gif|jpg|png)$'
let g:fuf_mrufile_maxItem  = 1000
let g:fuf_enumeratingLimit = 20
let g:fuf_keyPreview = '>'
let g:fuf_previewHeight = 25

nmap <Space> :FufBuffer<CR>
nmap m :FufMruFile<CR>
nmap s :FufFile<CR>
nmap <leader>l :FufLine<CR>
nmap <leader>r :FufBookmark<CR>
nmap <leader>d :FufDir<CR>
nmap <leader>bd :FufDirWithCurrentBufferDir<CR>
nmap <leader>dc :FufDirWithFullCwd<BR>
nmap <leader>i :FufEditInfo<CR>
"nmap <leader>c :FufMruCmd<CR>

if has('migemo')
    let g:fuf_useMigemo = 1
endif
let g:fuf_file_exclude = '\v\~$|\.git\\|\.git\/|\.svn|\.o$|\.class$|\.exe$|\.bak$|\.back$|\.swo$|\.swp$|((^|[/\\])\.[/\\]$)'

" smartchr ----------------------------------------------------------- {{{2
inoremap <expr> = smartchr#one_of(' = ', ' => ', ' == ', ' \|\|= ', '=', '===', ' = ' )
inoremap <expr> + smartchr#one_of(' + ', ' += ', '+', ' + ')

" neocomplcache ----------------------------------------------------------- {{{2
let g:NeoComplCache_EnableAtStartup = 1
let g:NeoComplCache_DisableAutoComplete = 0
let g:NeoComplCache_TemporaryDir = $HOME.'/.neocon'

" popup
let g:NeoComplCAche_MaxList = 100
let g:NeoComplCache_MaxKeywordWidth = 50
let g:NeoComplCache_MaxFilenameWidth = 50

" start length
let g:NeoComplCache_KeywordCompletionStartLength = 1
if !exists('g:NeoComplCache_PluginCompletionLength')
endif
let g:NeoComplCache_PluginCompletionLength = {
    \'snippets_complete' : 1, 
    \'buffer_complete' : 2, 
    \'syntax_complete' : 2, 
    \'tags_complete' : 3, 
\}

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

let g:NeoComplCache_SnippetsDir = $HOME . '/.vim/snippets'
imap <silent> <C-l> <Plug>(neocomplcache_snippets_expand)
smap <silent> <C-l> <Plug>(neocomplcache_snippets_expand)
