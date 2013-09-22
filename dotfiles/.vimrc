" Disable Vi compatibility
set nocompatible

" Pathogen load

call pathogen#infect()
call pathogen#helptags()

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
    filetype on
    filetype indent on
    filetype plugin on
    " Languages with specific tabs/space requirements
    autocmd FileType make setlocal ts=4 sts=4 sw=4 noexpandtab
    " Source the vimrc file after saving it
    " TODO; mess up the coloscheme
    " autocmd bufwritepost .vimrc source $MYVIMRC
endif


if has("syntax")
    syntax enable " Enable syntax highlighting
    set t_Co=256 " Set 256 color terminal support
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
set showmatch "show matching ( { [ if on a ) } ]
set matchtime=2 " usless: quickly move to open brace when typing the closing one
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
set textwidth=90 " lines longer than X columns will be broken, type gq$ to apply
set formatoptions-=t " don't automatically wrap text when typing
"set formatoptions+=t " automatically wrap text when typing
"set nowrap " don't automatically wrap on load
set colorcolumn=90 " add a colored column on column number X"
" TODO: not working
"set list "show non-visible characters (space,tab,eol)
set nofoldenable "disable folding
colorscheme dask " Set colorscheme

" ############## Trailing whitespaces ###################

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

if has("autocmd")
    " Automatically strip trailing whitespace on file save
    autocmd FileType c,cpp,java,php,ruby,python autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
    autocmd BufWritePre *.css,*.html,*.js,*.json,*.md,*.php,*.py,*.rb,*.scss,*.sh,*.txt :call <SID>StripTrailingWhitespaces()
endif

" ############ keymapping  #############
" Change mapleader
let mapleader = ","
" Strip trailing whitespace (,$)
noremap <leader>$ :call <SID>StripTrailingWhitespaces()<CR>
"tab goto next buffer
nmap <tab> :bnext <CR>
" ff fix Flake8 rules
map ff :PyFlakeAuto <CR>
" C-n toggle nerdtree on / off
map <C-n> :NERDTreeToggle<CR>
" ,td open the todo list in a new windows
map <leader>td <Plug>TaskList
" ,v opens .vimrc
nmap <leader>v :e $MYVIMRC<CR>


"TODO: Move a line of text or a bloc using control + arrows


" window mmouvement made simple
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

noremap <leader>n :nohl<CR>
vnoremap <leader>n :nohl<CR>
inoremap <leader>n :nohl<CR>

" Load local machine settings if they exist
if filereadable(glob("$HOME/.vimrc.local"))
    source $HOME/.vimrc.local
endif

"#######################################
"############# Plugins #################
"#######################################

"############# minibufexpl #################
let g:miniBufExplMaxSize = 1 "max minbuf window size equal X lines
"Replace bd with :MBEbd to fix the miniBufExpl vs bd mess
map :bd :MBEbd
let g:miniBufExplModSelTarget = 1 "don't open buffer in readonly buffer (like nerdtree's
"############# Nerdtree #################
autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeIgnore = ['\.pyc$'] "ignore pyc files
let NERDTreeShowHidden=1 "show dotfiles

" ############# vim markdown ################
let g:vim_markdown_folding_disabled=1
"TODO: line wwrap automatticaly create new bullets while in a list

" ############# jedi vim  ################
"automatically init jedi vim"
let g:jedi#auto_initialization = 1

let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>d"
"show PyDoc
let g:jedi#documentation_command = "K"
"automatically popup on dot
let g:jedi#popup_on_dot = 1
let g:jedi#use_tabs_not_buffers = 0
""There's some support for refactoring:
let g:jedi#rename_command = "<leader>r"
"list all names that are related (have the same origin):
""And you can list all names that are related (have the same origin):
let g:jedi#usages_command = "<leader>l"
let g:jedi#completions_command = "<C-Space>"
"By default you get a window that displays the function definition you're currently in. If you don't want that:
"let g:jedi#show_function_definition = 0




" ############# PyFlake  ################
""Auto-check file for errors on write:
let g:PyFlakeOnWrite = 1
""List of checkers used
let g:PyFlakeCheckers = 'pep8,mccabe,pyflakes'
""Default maximum complexity for mccabe:
let g:PyFlakeDefaultComplexity=10
""List of disabled pep8 warnings and errors:
let g:PyFlakeDisabledMessages = 'E225'
""Default height of quickfix window:
let g:PyFlakeCWindow = 15
""Whether to place signs or not:
let g:PyFlakeSigns = 1
""Maximum line length for PyFlakeAuto command
let g:PyFlakeMaxLineLength = 100
""Visual-mode key command for PyFlakeAuto
let g:PyFlakeRangeCommand = 'Q'

" ################# supertab ################
"  tab scroll from top to bottom completion list
let g:SuperTabDefaultCompletionType = "<c-n>"

""" flask8 tuning"
"""remap
""autocmd FileType python map <buffer> <F3> :call Flake8()<CR>
""let g:flake8_builtins="_,apply"
""let g:flake8_ignore="E201,E225"
""let g:flake8_max_line_length=100
""autocmd BufWritePost *.py call Flake8()
""let g:flake8_max_complexity=10
" Add the virtualenv's site-packages to vim path

py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
	project_base_dir =os.environ['VIRTUAL_ENV']
	sys.path.insert(0, project_base_dir)
	activate_this= os.path.join(project_base_dir, 'bin/activate_this.py')
	execfile(activate_this, dict(__file__=activate_this))
EOF
