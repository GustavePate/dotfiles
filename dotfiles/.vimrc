" Disable Vi compatibility
set nocompatible

" Pathogen load

call pathogen#infect()
call pathogen#helptags()

"TODO: move this to /tmp

"centralize multi-session undo files
set undodir=~/.vim/undo
set backupdir=~/.vim/backups
set directory=~/.vim/swaps

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set noswapfile
set nowritebackup

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
    set ruler " Show the cursor line and column number
    set showcmd " Show partial commands in status line
    set showmode " Show whether in insert or replace mode
endif

if has('statusline')
    set laststatus=2 " Always show status line
    " Broken down into easily includeable segments
    "Filename
    set statusline=%<%f\
    set statusline+=%w%h%m%r " Options
    set statusline+=\ [%{getcwd()}] " Current dir
    set statusline+=%=%-14.(%l,%c%V%)\ %p%% " Right aligned file nav info
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
set ttyfast " Optimize for fast terminal connections
set encoding=utf-8 " Use UTF-8
"TODO: don't work ?
set matchtime=2 " show matching bracket for 0.2 seconds
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
"set nowrap " don't automatically wrap on load
"set fo-=t " don't automatically wrap text when typing
set colorcolumn=90 " add a colored column on column number X"
" TODO: not working
"set list "show non-visible characters (space,tab,eol)
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
    autocmd BufWritePre *.css,*.html,*.js,*.json,*.md,*.php,*.py,*.rb,*.scss,*.sh,*.txt :call StripTrailingWhitespaces()
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

"############# Nerdtree #################

autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeIgnore = ['\.pyc$'] "ignore pyc files
let NERDTreeShowHidden=1

" ############# vim markdown ################
let g:vim_markdown_folding_disabled=1

" ############# jedi vim  ################
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#goto_command = "<leader>g"
let g:jedi#get_definition_command = "<leader>d"
let g:jedi#pydoc = "K"
let g:jedi#rename_command = "<leader>r"
""There's some support for refactoring:

let g:jedi#rename_command = "<leader>r"
""And you can list all names that are related (have the same origin):

let g:jedi#related_names_command = "<leader>n"
""If you want to change the default autocompletion command:
""let g:jedi#autocompletion_command =
""By default you get a window that displays the function definition
""let g:jedi#show_function_definition =


"

""" flask8 tuning"
"""remap
""autocmd FileType python map <buffer> <F3> :call Flake8()<CR>
""let g:flake8_builtins="_,apply"
""let g:flake8_ignore="E201,E225"
""let g:flake8_max_line_length=100
""autocmd BufWritePost *.py call Flake8()
""let g:flake8_max_complexity=10

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


let g:pymode_updatetime = 1000

let g:pymode_lint_buffer = bufnr('%')
" Disable pylint checking every save
let g:pymode_lint_write = 1
" " Set key 'R' for run python code
let g:pymode_run_key = 'R'
" Load the whole plugin
let g:pymode = 1
" " Load show documentation plugin
let g:pymode_doc = 1
" " Key for show python documentation
let g:pymode_doc_key = 'K'
" " Load run code plugin
let g:pymode_run = 1
" " Key for run python code
let g:pymode_run_key = '<leader>r'
" Code checking
" Default values:
"
" " Load pylint code plugin
let g:pymode_lint = 1
"
" " Switch pylint, pyflakes, pep8, mccabe code-checkers
"  Can have multiply values pep8,pyflakes,mcccabe"
let g:pymode_lint_checker = "pyflakes,pep8,mccabe"
"
" " Skip errors and warnings
"  E.g. E501,W002, E2,W (Skip all Warnings and Errors startswith E2) and etc
let g:pymode_lint_ignore = "E501"
"
" " Select errors and warnings
" " E.g. E4,W
let g:pymode_lint_select = ""
"
" " Run linter on the fly
let g:pymode_lint_onfly = 0
"
" " Pylint configuration file
" " If file not found use 'pylintrc' from python-mode plugin directory
let g:pymode_lint_config = "$HOME/.pylintrc"
"
" " Check code every save
let g:pymode_lint_write = 1
"
" " Auto open cwindow if errors be finded
let g:pymode_lint_cwindow = 1
"
" " Show error message if cursor placed at the error line
let g:pymode_lint_message = 1
"
" " Auto jump on first error
let g:pymode_lint_jump = 0
"
" " Hold cursor in current window
" " when quickfix is open
let g:pymode_lint_hold = 0
"
" " Place error signs
let g:pymode_lint_signs = 1
"
" " Maximum allowed mccabe complexity
let g:pymode_lint_mccabe_complexity = 8
"
" " Minimal height of pylint error window
let g:pymode_lint_minheight = 3

" " Maximal height of pylint error window
let g:pymode_lint_maxheight = 6
" Note
"
" Pylint options (ex. disable messages) may be defined in $HOME/pylint.rc See pylint
" documentation: http://pylint-messages.wikidot.com/all-codes
"
" Rope refactoring library
" Default values:
"
" " Load rope plugin
let g:pymode_rope = 1
"

let g:pymode_rope_short_prefix = 1
" " Auto create and open ropeproject
let g:pymode_rope_auto_project = 1
"
" " Enable autoimport
let g:pymode_rope_enable_autoimport = 1
"
" " Auto generate global cache
let g:pymode_rope_autoimport_generate = 1
"
let g:pymode_rope_autoimport_underlineds = 0
"
let g:pymode_rope_codeassist_maxfixes = 10
"
let g:pymode_rope_sorted_completions = 1
"
let g:pymode_rope_extended_complete = 1
"
let g:pymode_rope_autoimport_modules = ["os","shutil","datetime"]
"
let g:pymode_rope_confirm_saving = 1
"
let g:pymode_rope_global_prefix = "<C-x>p"
"
let g:pymode_rope_local_prefix = "<C-c>r"
"
let g:pymode_rope_vim_completion = 1
"
let g:pymode_rope_guess_project = 1
"
let g:pymode_rope_goto_def_newwin = ""
"
let g:pymode_rope_always_show_complete_menu = 0
" Automatically folding of python code
" Default values:
"
" " Enable python folding
let g:pymode_folding = 1
" Vim python motions and operators
" Default values:
"
" " Enable python objects and motion
let g:pymode_motion = 1
" Virtualenv support
" Default values:
"
" " Auto fix vim python paths if virtualenv enabled
let g:pymode_virtualenv = 1
" Other stuff
" Default values:
"
" " Additional python paths
let g:pymode_paths = []
"
" " Load breakpoints plugin
let g:pymode_breakpoint = 1
"
" " Key for set/unset breakpoint
let g:pymode_breakpoint_key = '<leader>b'
"
" " Autoremove unused whitespaces
let g:pymode_utils_whitespaces = 1
"
" " Enable pymode indentation
let g:pymode_indent = 1
"
" " Set default pymode python options
let g:pymode_options = 1
" Syntax highlight
" Default values:
"
" " Enable pymode's custom syntax highlighting
let g:pymode_syntax = 1
"
" " Enable all python highlightings
let g:pymode_syntax_all = 1
"
" " Highlight print as function
let g:pymode_syntax_print_as_function = 0
"
" " Highlight indentation errors
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
"
" " Highlight trailing spaces
let g:pymode_syntax_space_errors = g:pymode_syntax_all
"
" " Highlight string formatting
let g:pymode_syntax_string_formatting = g:pymode_syntax_all
"
" " Highlight str.format syntax
let g:pymode_syntax_string_format = g:pymode_syntax_all
"
" " Highlight string.Template syntax
let g:pymode_syntax_string_templates = g:pymode_syntax_all
"
" " Highlight doc-tests
let g:pymode_syntax_doctests = g:pymode_syntax_all
"
" " Highlight builtin objects (__doc__, self, etc)
let g:pymode_syntax_builtin_objs = g:pymode_syntax_all
"
" " Highlight builtin functions
let g:pymode_syntax_builtin_funcs = g:pymode_syntax_all
"
" " Highlight exceptions
let g:pymode_syntax_highlight_exceptions = g:pymode_syntax_all
"
" " For fast machines
" let g:pymode_syntax_slow_sync = 0"



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
