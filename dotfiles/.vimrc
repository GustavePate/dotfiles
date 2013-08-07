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

