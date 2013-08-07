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

syntax enable " Enable syntax highlighting

" ############# jedi vim  ################
"automatically init jedi vim"
let g:jedi#auto_initialization = 1 

let g:jedi#goto_command = "<leader>g"
let g:jedi#get_definition_command = "<leader>d"
"show PyDoc
let g:jedi#pydoc = "K"
"automatically popup on dot
let g:jedi#popup_on_dot = 1
let g:jedi#use_tabs_not_buffers = 0
""There's some support for refactoring:
let g:jedi#rename_command = "<leader>r"
"list all names that are related (have the same origin):
let g:jedi#related_names_command = "<leader>o"
""And you can list all names that are related (have the same origin):
let g:jedi#related_names_command = "<leader>l"
let g:jedi#autocompletion_command = "<C-Space>"
"By default you get a window that displays the function definition you're currently in. If you don't want that:
"let g:jedi#show_function_definition = 




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
