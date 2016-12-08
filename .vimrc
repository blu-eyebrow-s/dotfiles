" If you have vim >=8.0 or Neovim >= 0.1.5
"if (has("termguicolors"))
"  set termguicolors
"endif

"  " For Neovim 0.1.3 and 0.1.4
"let $NVIM_TUI_ENABLE_TRUE_COLOR=1

"Fix background color
set term=screen-256color
set title
set titleold=

"Backspace有効化
set guifont=Ricty\ Diminished\ Regular\ for\ Powerline:h14
set backspace=2
set enc=utf-8
"set fenc=utf-8
"vi互換をオフする
set nocompatible
syntax enable
set background=dark
let &t_Co=256
colorscheme tender
"マウス操作
set mouse=a
"画面表示
set laststatus=2

"Set ctags
set tags=./tags,tags

set tabstop=4
set softtabstop=4
set smarttab
set expandtab
set autoindent
set list
set listchars=tab:· ,trail:·
set number
"set relativenumber
set ruler
set iminsert=0
set title
set showmatch " 括弧の対応関係を一瞬表示する
source $VIMRUNTIME/macros/matchit.vim " Vimの「%」を拡張する

set whichwrap=b,s,[,],<,>
"システムレベルの貼り付けを使うとき便利なトーグル
"有効・無効をf５キーで変換できる
set pastetoggle=<f5>
"No beep sounds
set noerrorbells
set vb t_vb=
"コメント折りたたみ機能の設定
set foldmethod=marker
"vim Speed up
"let loaded_matchparen=1
"-----------------------------------------
"Search
"-----------------------------------------
"インクリメンタルサーチ
set incsearch
"大文字/小文字を区別しない
set ignorecase
"大文字を含む場合は区別する
set smartcase
"検索語のハイライト
set hlsearch
"クリップボードにコピペ
set clipboard=unnamed

"検索結果のハイライトをESC連打で消す
noremap <Esc><Esc> :nohlsearch<CR>

inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>

"-----------------------------------------
"ファイル処理関連
"-----------------------------------------
set autoread
set nobackup
set noswapfile

"-----------------------------------------
"カーソル移動関連
"-----------------------------------------
set scrolloff=8
"execute pathogen#infect()

"-----------------------------------------
" NeoBundle
"-----------------------------------------
set runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
  \ 'windows' : 'make -f make_mingw32.mak',
  \ 'cygwin' : 'make -f make_cygwin.mak',
  \ 'mac' : 'make -f make_mac.mak',
  \ 'unix' : 'make -f make_unix.mak',
  \    },
  \ }
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'taichouchou2/html5.vim'
NeoBundleLazy 'jelera/vim-javascript-syntax', {'autoload':{'filetypes':['javascript']}}
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'surround.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'chriskempson/vim-tomorrow-theme'
NeoBundle 'mxw/vim-jsx'
NeoBundle 'othree/html5.vim'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'jacoborus/tender'

call neobundle#end()

filetype plugin indent on
"-----------------------------------------
" End NeoBundle
"-----------------------------------------

"runtime macros/matchit.vim
"au BufRead,BufNewFile *.md set filetype=markdown
"let g:previm_open_cmd = 'open -a firefox'

"syntastic シンタックス
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_javascript_checkers = ['jshint']
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_enable_signs = 1
let g:syntastic_check_on_wq = 0

""""""""""""""""""""""""""""""""""
"             unite              "
""""""""""""""""""""""""""""""""""

let g:unite_update_time = 1000
"nnoremap <silent> <C-r>  :<C-u>Unite file_mru<CR>
nnoremap <silent> <C-n>  :<C-u>Unite buffer <CR>
nnoremap <silent> <Leader>d :<C-u>Unite file<CR>

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  " Overwrite settings.
  imap <buffer> jj <Plug>(unite_insert_leave)
  imap <buffer> <ESC> <ESC><ESC>
  nnoremap <buffer> t G
  startinsert
endfunction

" NeoComplete Settings
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
	\ 'default' : '',
	\ 'vimshell' : $HOME.'/.vimshell_hist',
	\ 'scheme' : $HOME.'/.gosh_completions'
		\ }

"Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
	let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
"Plugin key-mappings.
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

"SuperTab like snippets behavior.
"imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

"Recommended key-mappings.
"<CR>: close popup and save indent.
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
"<TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"<C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
"AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>"
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
	let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" NerdTree Setting
nnoremap <silent><C-e> :NERDTreeToggle<CR>

" othree/hmlt5.vim
let g:html5_event_handler_attributes_complete = 0
let g:html5_event_handler_attributes_complete = 0
let g:html5_microdata_attributes_complete = 0
let g:html5_aria_attributes_complete = 0

" HTML 3 tags
syn keyword htmlTagName contained article aside audio bb canvas command
syn keyword htmlTagName contained datalist details dialog embed figure
syn keyword htmlTagName contained header hgroup keygen mark meter nav output
syn keyword htmlTagName contained progress time ruby rt rp section time
syn keyword htmlTagName contained source figcaption
syn keyword htmlArg contained autofocus autocomplete placeholder min max
syn keyword htmlArg contained contenteditable contextmenu draggable hidden
syn keyword htmlArg contained itemprop list sandbox subject spellcheck
syn keyword htmlArg contained novalidate seamless pattern formtarget
syn keyword htmlArg contained formaction formenctype formmethod
syn keyword htmlArg contained sizes scoped async reversed sandbox srcdoc
syn keyword htmlArg contained hidden role
syn match   htmlArg "\<\(aria-[\-a-zA-Z0-9_]\+\)=" contained
syn match   htmlArg contained "\s*data-[-a-zA-Z0-9_]\+"

vnoremap <silent> <Enter> :EasyAlign<cr>

"</で閉じタグを自動補完
autocmd FileType html inoremap <silent> <buffer> </ </<C-x><C-o>
autocmd FileType php inoremap <silent> <buffer> </ </<C-x><C-o>

"nerdtree : ctrl + eで開く
"nnoremap <silent><C-e> :NERDTreeToggle<CR>
"newtab キーバインド
"nnoremap st :<C-u>tabnew<CR>
"vimfiler キーバインド: ctrl + eで開く
"nnoremap <silent><C-e> :VimFiler<CR>
"DB 設定
let g:sql_type_default='mysql'
let g:ref_phpmanual_path = $HOME . '/.vim/ref/php-chunked-xhtml'

"PHP開発環境設定
let php_sql_query = 1
let php_baselib = 1
let php_htmlInStrings = 1
let php_noShortTags = 1
let php_parent_error_close = 1

augroup fileTypeIndent
    autocmd!
    autocmd BufRead,BufNewFile *.php setlocal shiftwidth=4 softtabstop=4 tabstop=4 expandtab
    autocmd BufRead,BufNewFile *.html setlocal shiftwidth=4 softtabstop=4 tabstop=4 expandtab
    autocmd BufRead,BufNewFile *.js setlocal shiftwidth=4 softtabstop=4 tabstop=4 expandtab
    autocmd BufRead,BufNewFile *.css setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab
    autocmd BufRead,BufNewFile *.txt setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab
    autocmd BufRead,BufNewFile *.xml setlocal shiftwidth=4 softtabstop=4 tabstop=4 expandtab
    autocmd BufRead,BufNewFile *.scss setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab
    autocmd BufRead,BufNewFile *.sql setlocal shiftwidth=4 softtabstop=4 tabstop=4 expandtab
    autocmd BufRead,BufNewFile *.blade.php setlocal shiftwidth=4 softtabstop=4 tabstop=4 expandtab
augroup END

"Vimfiler configuration
autocmd FileType vimfiler nmap <buffer> <CR> <Plug>(vimfiler_expand_or_edit)

"Jsonの整形（ダブルクオーテーションの隠し）
let g:vim_json_syntax_conceal = 0

"----------------------------------------------------------
" Syntastic
"----------------------------------------------------------
" 構文エラー行に「>>」を表示
let g:syntastic_enable_signs = 1
" 他のVimプラグインと競合するのを防ぐ
let g:syntastic_always_populate_loc_list = 1
" 構文エラーリストを非表示
let g:syntastic_auto_loc_list = 0
" ファイルを開いた時に構文エラーチェックを実行する
let g:syntastic_check_on_open = 1
" 「:wq」で終了する時も構文エラーチェックする
let g:syntastic_check_on_wq = 1

" Javascript用. 構文エラーチェックにESLintを使用
let g:syntastic_javascript_checkers=['eslint']
" Javascript以外は構文エラーチェックをしない
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': ['javascript'],
                           \ 'passive_filetypes': [] }


"""""""""""""""""""""""""""""""""""""
"            Syntastic              "
"""""""""""""""""""""""""""""""""""""
" Execute Pathogen
" Syntasticのため、Pathogenをインストール
execute pathogen#infect()
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"""""""""""""""""""""""""""""""""""""
"              Airline              "
"""""""""""""""""""""""""""""""""""""
let g:airline_extensions = ['tabline', 'branch']
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_alt_sep = ''

let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#tabline#enabled = 1

let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''

let g:airline_theme='tender'
let g:airline_powerline_fonts = 1
let g:Powerline_symbols = 'fancy'

