execute pathogen#infect()
set number
syntax on
filetype plugin indent on
set t_Co=256
"colorscheme brookstream 
""colorscheme peachpuff
""colorscheme zendnb
""colorscheme summerfruit256
colorscheme dask

"red: 990000
"blue: 22bb22"
"yellow ffa0a0
"red:87c6f0
"lightblue ffb539
"rose: 2b506e
"yellow 0086f7
"green:0086d2


set encoding=utf8
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4"



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
