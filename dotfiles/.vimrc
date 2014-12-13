" Disable Vi compatibility
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'
"
" My bundles here:
"
" Synthax
Plugin 'scrooloose/syntastic'
Bundle 'vim-pandoc/vim-pandoc'
Bundle 'vim-pandoc/vim-pandoc-syntax'
Bundle 'uarun/vim-protobuf'
Plugin 'motus/pig.vim'

"Python
" Must have pip install --upgrade autopep8
Bundle 'tell-k/vim-autopep8'
Bundle 'andviro/flake8-vim'
Bundle 'hdima/python-syntax'

"SCM
Bundle 'tpope/vim-fugitive'

"GUI / workflow
Bundle 'scrooloose/nerdtree'
Bundle 'bling/vim-airline'
Bundle 'majutsushi/tagbar'
Bundle 'Valloric/YouCompleteMe'
Plugin 'kien/ctrlp.vim'
Plugin 'mbbill/undotree'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

"org
Bundle 'vim-scripts/TaskList.vim'

"quick editing
Plugin 'Raimondi/delimitMate'
Plugin 'tpope/vim-surround'
Bundle 'tomtom/tcomment_vim'

"formatting
Plugin 'godlygeek/tabular'
Bundle 'shinokada/listtrans.vim'
Bundle 'shinokada/dragvisuals.vim'

"goodies
Plugin 'junegunn/limelight.vim'
Plugin 'junegunn/goyo.vim'
Bundle 'nixon/vim-vmath'
Bundle 'mikewest/vimroom'

"theme
Bundle 'vim-scripts/ScrollColors'
Bundle 'guns/xterm-color-table.vim'

call vundle#end()

filetype indent on
filetype plugin on


"centralize multi-session undo files
set undodir=~/.vim/undo
set backupdir=~/.vim/backup
set directory=~/.vim/swap

" Turn backup on, could save your ass some day
set backup
set swapfile
set writebackup

"make backspace work properly
set backspace=indent,eol,start

"toggle paste / nopaste mode to not mess indent during paste of indented text
set pastetoggle=<F8>

" * (midelclick) system clipboard by default
set clipboard=unnamed
" + (ctrl+c) system clipboard by default
"set clipboard=unnamedplus

if has("autocmd")
    " Load files for specific filetypes
    filetype indent on
    filetype plugin on
    " Languages with specific tabs/space requirements
    autocmd FileType make setlocal ts=4 sts=4 sw=4 noexpandtab
endif


if has("syntax")
    set t_Co=256 " Set 256 color terminal support
    syntax enable " Enable syntax highlighting
    set background=dark " Set dark background
endif

if has("cmdline_info")
    " replaced by vim-airline
    "set ruler " Show the cursor line and column number
    set showcmd " Show partial commands in status line
    set showmode " Show whether in insert or replace mode
endif

if has('statusline')

    " obsoleted by vim-airline
    "
    "set laststatus=2 " Always show status line
    " Broken down into easily includeable segments
    "Filename
    "set statusline=%<%f\
    "set statusline+=%w%h%m%r " Options
    "set statusline+=\ [%{getcwd()}] " Current dir
    "set statusline+=%=%-14.(%l,%c%V%)\ %p%% " Right aligned file nav info
    "set statusline+=%{fugitive#statusline()c
endif



if has("wildmenu")
    set wildmenu " Show a list of possible completions
    set wildmode=longest,list " Tab autocomplete longest possible part of a string, then list
    if has ("wildignore")
        set wildignore+=*.a,*.pyc,*.o,*.orig
        set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png
        set wildignore+=.DS_Store,.git,.hg,.svn
        set wildignore+=*~,*.sw?,*.tmp
        set wildignore+=*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,*~,*.pyc,.svn
    endif
endif

if has("extra_search")
    set hlsearch " Highlight searches [use :noh to clear]
    set incsearch " Highlight dynamically as pattern is typed
    set ignorecase " Ignore case of searches...
    set smartcase " ...unless has mixed case
endif

set hidden " allow to have multiple buffer open on edited but not saved files
"set ttyfast " Optimize for fast terminal connections
set encoding=utf-8 " Use UTF-8
set fileencoding=utf-8 
set showmatch "show matching ( { [ if on a ) } ]
set matchtime=2 " usless: quickly move to open brace when typing the closing one
set relativenumber
set number " show line numbers
set mouse=a " use the mouse to copy but don't take the linenulbers
set scrolloff=4 " Start scrolling four lines before the horizontal window border
set shiftwidth=4 " operation >> indents 4 columns; << unindents 4 columns
set tabstop=4 " an hard TAB displays as 4 spaees
set expandtab " insert spaces when hitting TABs
set softtabstop=4 " insert/delete 4 spaces when hitting a TAB/BACKSPACE
set shiftround " round indent to multiple of 'shiftwidth'
set autoindent " align the new line indent with the previous line"
set cursorline " Highlight current line
set nostartofline " Don’t reset cursor to start of line when moving around.
set textwidth=110 " lines longer than X columns will be broken, type gq$ to apply
set formatoptions-=t " don't automatically wrap text when typing
set wrapmargin=0
set linebreak "when wrap don't break in the middle of a word
set shortmess+=I "no start message
set splitright "new vertical split on the left
"set formatoptions+=t " automatically wrap text when typing
"set nowrap " don't automatically wrap on load

"Complete work with C-P C-N
set complete+=kspell


" color the whole column
"set colorcolumn=110 " add a colored column on column number X"
"color just the nth charcter
highlight ColorColumn ctermbg=red
call matchadd('ColorColumn', '\%111v', 100)

" TODO: not working
"set list "show non-visible characters (space,tab,eol)
set nofoldenable "disable folding
colorscheme dask " Set colorscheme


" ############ keymapping  #############
" Change mapleader
let mapleader = ","

"" ### move ###

"tab goto next buffer
nmap <C-right> :bnext <CR>
nmap <C-left> :bprevious <CR>
nnoremap <leader>b :ls<cr>:b<space>

"J keeps cursor position
nnoremap J mzJ`z
" move down 1 row instead of 1 line (usefull when warpped lines)
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
nnoremap <up> gk
nnoremap <down> gj

" Move a line of text or a bloc using control + arrows
" Alt+j/k to move current line/selected lines up and down
nnoremap <C-down> :m+<CR>==
nnoremap <C-up> :m-2<CR>==
inoremap <C-down> <Esc>:m+<CR>==gi
inoremap <C-up> <Esc>:m-2<CR>==gi
"vnoremap <C-down> :m'>+<CR>gv=gv
"vnoremap <C-up> :m-2<CR>gv=gv

" window movement made simple
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

"Visual block by default
nnoremap v <C-V>
nnoremap <C-V> v
vnoremap v <C-V>
vnoremap <C-V> v

"" ### utilities ####

" ,c close all buffers
nmap <leader>c :bufdo bd<CR>
" Strip trailing whitespace (,$)
noremap <leader>$ :call <SID>StripTrailingWhitespaces()<CR>

" Save and execute sh
autocmd FileType sh map <buffer> <C-S-e> :w<CR>:!/bin/sh % <CR>
" ff fix Flake8 rules
autocmd FileType python nmap ff :PyFlakeAuto <CR>:PyFlake<CR>
":PyFlake<CR>
" ap fix pep8 rules
autocmd FileType python map <buffer> ap :call Autopep8()<CR>:PyFlake<CR>:redraw!<CR>
" disable syntax higlight after search
noremap <leader>n :nohl<CR>
vnoremap <leader>n :nohl<CR>
inoremap <leader>n :nohl<CR>

" search result in the middle of the screen
nnoremap n nzz
nnoremap } }zz
nnoremap N Nzz
nnoremap { {zz

" Return cursor to previous location on load
autocmd BufReadPost * normal `"

"show higlight properties of the under cursor element
map <F2> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>


"" ### spell ###
"z= sur un mot souligné affiche une liste de corrections possibles
"zg rajoute un mot dans le dictionnaire
"zug pour annuler l'ajout au dictionnaire
"]s pour aller au prochain mot mal orthographié
"[s pour le précédent

noremap <F6> :setlocal spell! spelllang=fr<CR>
noremap <F7> :setlocal spell! spelllang=en<CR>


"" ### system ###

" C-n toggle nerdtree on / off
map <C-n> :NERDTreeToggle<CR>
map <C-x> :NERDTreeToggle<CR>
" ,td open the todo list in a new windows
map <leader>td <Plug>TaskList
" ,v opens .vimrc
nmap <leader>v :e $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<cr>
" C-t open tagbar
nmap <C-t> :TagbarToggle<CR>


" Load local machine settings if they exist
if filereadable(glob("$HOME/.vimrc.local"))
    source $HOME/.vimrc.local
endif

" ############### File type properties ##################
" Turn on spell checking for Git commits

if has("autocmd")
    " Automatically strip trailing whitespace on file save
    autocmd FileType c,cpp,java,php,ruby,python autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
    autocmd BufWritePre *.css,*.html,*.js,*.json,*.md,*.php,*.py,*.rb,*.scss,*.sh,*.txt :call <SID>StripTrailingWhitespaces()
    autocmd BufRead *.md set textwidth=150
    autocmd BufRead *.md set colorcolumn=150
    autocmd FileType gitcommit setlocal spell
    autocmd BufRead,BufNewFile *.md setlocal spell spelllang=fr
    autocmd BufRead,BufNewFile *.rst setlocal spell spelllang=fr
endif

"Return cursor to previous location on load:
autocmd BufReadPost * normal `"

"Quick fix not in listed buffer
augroup QFix
    autocmd!
    autocmd FileType qf setlocal nobuflisted
augroup END


"#######################################
"############# Plugins #################
"#######################################

"############## undo tree ###########"
nnoremap <F5> :UndotreeToggle<cr>


"############## pandoc synthax ###########"

let g:pandoc#syntax#conceal#use = 0
let g:pandoc#syntax#conceal#blacklist = ["titleblock"]

"############# goyo / limelight ##########"
"
let g:limelight_conceal_ctermfg = 240
let g:limelight_default_coefficient = 0.4

function! s:goyo_enter()
    Limelight
endfunction

function! s:goyo_leave()
    Limelight!
    colorscheme dask " Set colorscheme
endfunction

autocmd! User GoyoEnter
autocmd! User GoyoLeave
autocmd  User GoyoEnter nested call <SID>goyo_enter()
autocmd  User GoyoLeave nested call <SID>goyo_leave()
nmap <C-R> :Goyo<CR>


"############# tabular ###################"

nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>
nmap <Leader>a\| :Tabularize /\|<CR>
vmap <Leader>a\| :Tabularize /\|<CR>




"############# ctrlP ######################
"Press <c-f> and <c-b> to cycle between modes.
"Use <c-j>, <c-k> or the arrow keys to navigate the result list.
let g:ctrlp_cmd = 'CtrlP .'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(pyc|so|jar)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
let g:ctrlp_show_hidden = 1 "show hidden files dir

"#############  dragvisual ################

"#############  listtrans.vim ################
" TODO does not work
nmap  <leader>l   :call ListTrans_toggle_format()<CR>
vmap  <leader>l   :call ListTrans_toggle_format('visual')<CR>

"############# Vimroom #################

let g:vimroom_width=120
nnoremap <silent> <Leader>mz <Plug>VimroomToggle


"############# YouCompleteMe #################
nmap <leader>d :YcmCompleter GoToDefinition<CR>
nmap <leader>g :YcmCompleter GoTo<CR>
let g:ycm_auto_trigger = 3
let g:ycm_enable_diagnostic_signs = 1
let g:ycm_enable_diagnostic_highlighting = 1
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '>>'
let g:ycm_filetype_whitelist = { '*': 1 }
let g:ycm_filetype_blacklist = {
      \ 'tagbar' : 1,
      \}
let g:ycm_collect_identifiers_from_comments_and_strings = 1

"############# UltiSnips#################
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<leader>s"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"
" " If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

"############# vim-autopep8 #################
"Do not fix these errors/warnings (default: E226,E24,W6)
let g:autopep8_ignore=""
"Fix only these errors/warnings (e.g. E4,W)
"let g:autopep8_select="E501,W293"
"Maximum number of additional pep8 passes (default: 100)
"let g:autopep8_pep8_passes=100

"Set maximum allowed line length (default: 79)
let g:autopep8_max_line_length=110

"Enable possibly unsafe changes (E711, E712) (default: non defined)
let g:autopep8_aggressive=1
"
"Disable show diff window
let g:autopep8_disable_show_diff=1



"Highlight builtin functions and objects
let python_highlight_builtins=1
"Highlight builtin objects only
let python_highlight_builtin_objs=0
"Highlight builtin functions only
let python_highlight_builtin_funcs=0
"Highlight standard exceptions
let python_highlight_exceptions=1
"Highlight % string formatting
let python_highlight_string_formatting=1
"Highlight syntax of str.format syntax
let python_highlight_string_format=1
"Highlight syntax of string.Template
let python_highlight_string_templates=1
"Highlight indentation errors
let python_highlight_indent_errors=1
"Highlight trailing spaces
let python_highlight_space_errors=1
"Highlight doc-tests
let python_highlight_doctests=1
"Highlight print statement as function for Python 2
let python_print_as_function=1
"Highlight shebang and coding headers as comments
let python_highlight_file_headers_as_comments=0


" ############# flake8-vim  ################
"Auto-check file for errors on write:
let g:PyFlakeOnWrite = 1
"List of checkers used:
let g:PyFlakeCheckers = 'pep8,mccabe,frosted'
"Default maximum complexity for mccabe:
let g:PyFlakeDefaultComplexity=15
"List of disabled pep8 warnings and errors:
let g:PyFlakeDisabledMessages = 'E501'
"Default aggressiveness for autopep8:
let g:PyFlakeAggressive = 1
"Default height of quickfix window:
let g:PyFlakeCWindow = 6
"Whether to place signs or not:
let g:PyFlakeSigns = 1
"Maximum line length for PyFlakeAuto command
let g:PyFlakeMaxLineLength = 110
"Visual-mode key command for PyFlakeAuto
let g:PyFlakeRangeCommand = 'Q'
"############# vim-airline #################

set laststatus=2 " Always show status line
set ttimeoutlen=50 "no pause when leaving insert mode
"let g:airline_theme = 'powerlineish'
" Mess up jedi-vim autocompletion
let g:airline#extensions#tabline#enabled = 1
"let g:airline_exclude_preview = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#buffer_min_count = 2
"############# Nerdtree #################
"autocmd vimenter * if !argc() | NERDTree | endif
"close vim if nerdtree is the last open buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeIgnore = ['\.pyc$'] "ignore pyc files
let NERDTreeShowHidden=1 "show dotfiles

"open nerdtree and put the cursor on the right window
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

"############# Markdown #################
let g:vim_markdown_folding_disabled=1
"TODO: line wwrap automatticaly create new bullets while in a list


" ############# vmath.vim################
"after ++ 
"The sum        is in the "s buffer (e.g. "sp).
"The average    is available in "a
"the minimum value in "n, 
"the maximum value in "x,
"and the min-to-max range as a single string is available in "r
vmap <expr> ++ VMATH_YankAndAnalyse()
nmap ++ vip++


" ############# dragvisual  ################
"runtime plugin/dragvisuals.vim
vmap <expr> <C-LEFT> DVB_Drag('left')
vmap <expr> <C-RIGHT> DVB_Drag('right')
vmap <expr> <C-DOWN> DVB_Drag('down')
vmap <expr> <C-UP> DVB_Drag('up')
" My favourite feature is the “duplicator” option:
vmap <expr> D DVB_Duplicate()

" ############# vim tcomment ################
" Normal
" gc3<down>: toggle comment 4 lines under
" gcc toggle comment one line
" gC3<up> comment 4 upper line
" visual:
" gc Toggle Comment
" gC comment selected Text


" ################# supertab ################
"  tab scroll from top to bottom completion list
let g:SuperTabDefaultCompletionType = "<c-n>"


" ################# bd don't close the window but just the buffer  ################
" ################# smother intergation wityh nerd tree            ################

function! s:DiffWithSaved()
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()


"Delete buffer while keeping window layout (don't close buffer's windows).
" Version 2008-11-18 from http://vim.wikia.com/wiki/VimTip165
if v:version < 700 || exists('loaded_bclose') || &cp
    finish
endif
let loaded_bclose = 1
if !exists('bclose_multiple')
    let bclose_multiple = 1
endif

" Display an error message.
function! s:Warn(msg)
    echohl ErrorMsg
    echomsg a:msg
    echohl NONE
endfunction


" Command ':Bclose' executes ':bd' to delete buffer in current window.
" The window will show the alternate buffer (Ctrl-^) if it exists,
" or the previous buffer (:bp), or a blank buffer if no previous.
" Command ':Bclose!' is the same, but executes ':bd!' (discard changes).
" An optional argument can specify which buffer to close (name or number).
function! s:Bclose(bang, buffer)
    if empty(a:buffer)
        let btarget = bufnr('%')
    elseif a:buffer =~ '^\d\+$'
        let btarget = bufnr(str2nr(a:buffer))
    else
        let btarget = bufnr(a:buffer)
    endif
    if btarget < 0
        call s:Warn('No matching buffer for '.a:buffer)
        return
    endif
    if empty(a:bang) && getbufvar(btarget, '&modified')
        call s:Warn('No write since last change for buffer '.btarget.' (use :Bclose!)')
        return
    endif
    " Numbers of windows that view target buffer which we will delete.
    let wnums = filter(range(1, winnr('$')), 'winbufnr(v:val) == btarget')
    if !g:bclose_multiple && len(wnums) > 1
        call s:Warn('Buffer is in multiple windows (use ":let bclose_multiple=1")')
        return
    endif
    let wcurrent = winnr()
    for w in wnums
            execute w.'wincmd w'
        let prevbuf = bufnr('#')
        if prevbuf > 0 && buflisted(prevbuf) && prevbuf != w
            buffer #
        else
            bprevious
        endif
        if btarget == bufnr('%')
            " Numbers of listed buffers which are not the target to be deleted.
            let blisted = filter(range(1, bufnr('$')), 'buflisted(v:val) && v:val != btarget')
            " Listed, not target, and not displayed.
            let bhidden = filter(copy(blisted), 'bufwinnr(v:val) < 0')
            " Take the first buffer, if any (could be more intelligent).
            let bjump = (bhidden + blisted + [-1])[0]
            if bjump > 0
                execute 'buffer '.bjump
            else
                execute 'enew'.a:bang
            endif
        endif
    endfor
    execute 'bdelete'.a:bang.' '.btarget
    execute wcurrent.'wincmd w'
endfunction

command! -bang -complete=buffer -nargs=? Bclose call <SID>Bclose('<bang>', '<args>')
nnoremap <silent> <Leader>bd :Bclose<CR>
nnoremap <silent> <Leader>bD :Bclose!<CR>
map :bd :Bclose

" ############## Delete Trailing whitespaces on save ###################

match Todo /\s\+$/ "highlight trailingwhitespaces

function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    "Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

"easier to find search result
nnoremap <silent> n n:call HLNext(0.4)<cr>
nnoremap <silent> N N:call HLNext(0.4)<cr>

"" blink line of the search result
function! HLNext_blink (blinktime)
    set invcursorline
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    set invcursorline
    redraw
endfunction

"=====[ Blink a red ring around the match ]=============
function! HLNext_red_square (blinktime)
    highlight RedOnRed ctermfg=red ctermbg=red
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    echo matchlen
    let ring_pat = (lnum > 1 ? '\%'.(lnum-1).'l\%>'
                \ . max([col-4,1]) .'v\%<'.(col+matchlen+3).'v.\|' : '')
                \ . '\%'.lnum.'l\%>'.max([col-4,1]) .'v\%<'.col.'v.'
                \ . '\|'
                \ . '\%'.lnum.'l\%>'.max([col+matchlen-1,1])
                \ . 'v\%<'.(col+matchlen+3).'v.'
                \ . '\|'
                \ . '\%'.(lnum+1).'l\%>'.max([col-4,1])
                \ . 'v\%<'.(col+matchlen+3).'v.'
    let ring = matchadd('RedOnRed', ring_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    call matchdelete(ring)
    redraw
endfunction

"=====[ Briefly hide everything except the match ]=============
function! HLNext_hide (blinktime)
    highlight BlackOnBlack ctermfg=black ctermbg=black
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let hide_pat = '\%<'.lnum.'l.'
                \ . '\|'
                \ . '\%'.lnum.'l\%<'.col.'v.'
                \ . '\|'
                \ . '\%'.lnum.'l\%>'.(col+matchlen-1).'v.'
                \ . '\|'
                \ . '\%>'.lnum.'l.'
    let ring = matchadd('BlackOnBlack', hide_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    call matchdelete(ring)
    redraw
endfunction

"=====[ Highlight the match in Color ]=============
function! HLNext (blinktime)
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#'.@/
    let ring = matchadd('MatchParen', target_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    call matchdelete(ring)
    redraw
endfunction


" Show syntax highlighting groups for word under cursor
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
nmap <C-S-P> :call <SID>SynStack()<CR>


""" OLD GARBAGE

""" flask8 tuning"
"""remap
""autocmd FileType python map <buffer> <F3> :call Flake8()<CR>
""let g:flake8_builtins="_,apply"
""let g:flake8_ignore="E201,E225"
""let g:flake8_max_line_length=100
""autocmd BufWritePost *.py call Flake8()
""let g:flake8_max_complexity=10
" Add the virtualenv's site-packages to vim path
"
" py << EOF
" import os.path
" import sys
" import vim
" if 'VIRTUAL_ENV' in os.environ:
" 	project_base_dir =os.environ['VIRTUAL_ENV']
" 	sys.path.insert(0, project_base_dir)
" 	activate_this= os.path.join(project_base_dir, 'bin/activate_this.py')
" 	execfile(activate_this, dict(__file__=activate_this))
" EOF
