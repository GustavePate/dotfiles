" Pathogen load
filetype off

call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on
syntax on


let mapleader = ","
nmap <tab> :bnext <CR>
map ff :PyFlakeAuto <CR>
map <C-n> :NERDTreeToggle<CR>
map <leader>td <Plug>TaskList

autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeIgnore = ['\.pyc$'] "ignore pyc files
let NERDTreeShowHidden=1

let g:vim_markdown_folding_disabled=1

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
""vim-ensible centralize multi-session undo files
set undodir^=~/.vim/undo

set wildmenu
set wildignore=*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,*~,*.pyc,.svn
set matchtime=2         "" show matching bracket for 0.2 seconds
set number
set t_Co=256
""set nocompatible
set encoding=utf8
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile
set hidden
set ignorecase
set showcmd
set mouse=a
""pep8 recommandations
set textwidth=95 " lines longer than 79 columns will be broken 
set shiftwidth=4 " operation >> indents 4 columns; << unindents 4 columns 
set tabstop=4 " an hard TAB displays as 4 columns 
set expandtab " insert spaces when hitting TABs 
set softtabstop=4 " insert/delete 4 spaces when hitting a TAB/BACKSPACE 
set shiftround " round indent to multiple of 'shiftwidth' 
set autoindent " align the new line indent with the previous line"
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



colorscheme dask
set colorcolumn=80
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
