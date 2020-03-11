"?????????????????????????????????????????????????????????????????????????????
"  ColorScheme:  psclone.vim
"  Last Change:  2009-10-17  [16:59:40]
"      Version:  110
"      License:  Public Domain, Free / Frei / Gratis / Libre.
"       Author:  Jaime Wottrich,  <jaime.wottrich@gmail.com>
"         Help:  :h psclone.vim
"                :h mimicpak
"                :h mimicpak-options
"?????????????????????????????????????????????????????????????????????????????
" Setup {{{1
"~~~~~~~
set background=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "psclone"

" Function: s:GetValue(var, ...) {{{2
"    Looks up the value of a variable in this order (by default):
"    buffer, window, tabpage and global.
"    The one that exists first is returned, or 0 if none of them exists.
" Optional Args:
"    a:1  value to return if variable doesn't exist.
"    a:2  string with comma separated variable prefixes.  Examples:
"         "b:,t:,g:" - search for buffer, tabpage and global variables
"            "w:,t:" - search for window and tabpage variables
"               "g:" - search for global variables only
function s:GetValue(var, ...)
  let l:defvalue = 0 < a:0 ? a:1      : 0
  let l:prefixes = 1 < a:0 ? a:2 . "" : "b:,w:,t:,g:"
  let l:start = 0
  let l:i = stridx(l:prefixes, ",")
  while 1
    " track down the comma position, and handle special cases:
    "  - only one prefix without commas, and
    "  - after the last encountered comma.
    let l:end = l:i < 0 ? strlen(l:prefixes) : l:i
    let l:prefix = strpart(l:prefixes, l:start, l:end - l:start)
    if exists(prefix . a:var)
      return {prefix . a:var}
    endif
    " after last comma (or one prefix only without commas),
    " and variable not found
    if l:i < 0
      return l:defvalue
    endif
    " update needle and get next comma position
    let l:start = l:i + 1
    let l:i = stridx(l:prefixes, ",", l:start)
  endwhile
endfunction "}}}2

" get the values (if any) for the options
let s:mimic_font_style   = s:GetValue("mimic_font_style")
let s:mimic_colorize_gui = s:GetValue("mimic_colorize_gui")

" cleanup
delfunction s:GetValue


"Define colors
"
let colblack=0
let s:white=255
let s:col_grey_blue=67
let s:col_light_purple=146
let s:col_light_green=158
let s:col_light_pink=219
let s:col_grey=238
let s:col_light_grey=252

hi Normal	ctermfg=252   ctermbg=0

" Default Syntax Highlight {{{1
"~~~~~~~~~~~~~~~~~~~~~~~~~~
hi Comment	ctermfg=24    ctermbg=0   gui=NONE

hi link SpecialComment  Comment

hi Constant	ctermfg=74   ctermbg=0   gui=NONE
hi link String	Constant
hi link Character	Constant
hi Number	ctermfg=131   ctermbg=0   gui=NONE
hi link Boolean	Constant
hi link Float	Number

hi Identifier	ctermfg=38    ctermbg=0   cterm=NONE
hi Function           ctermfg=38    ctermbg=0   cterm=NONE

hi Statement	ctermfg=60   ctermbg=0   gui=NONE
" hi Conditional	ctermfg=60  ctermbg=0   gui=NONE
hi Conditional	ctermfg=31  ctermbg=0   gui=NONE
hi link Repeat	Conditional
hi link Label	Statement
hi link Operator	Conditional
hi link Keyword	Statement
hi link Exception	Conditional

hi Type	ctermfg=252   ctermbg=0   gui=NONE
hi StorageClass	ctermfg=31    ctermbg=0   gui=NONE
hi link Structure	Type
hi link Typedef	Type

hi PreProc	ctermfg=146   ctermbg=0   gui=NONE
hi Include	ctermfg=74   ctermbg=0   gui=NONE
hi Define	ctermfg=57   ctermbg=0   gui=NONE
hi link Macro	PreProc
hi link PreCondit	PreProc

hi Special	ctermfg=67   ctermbg=0   gui=NONE
hi link SpecialChar	Special
hi Delimiter	ctermfg=31     ctermbg=0      gui=NONE
hi link Tag	Special
hi link Debug	Special

" other texts
hi Question	guifg=bg	guibg=#cccc99	gui=NONE
hi WarningMsg	guifg=#f08080	guibg=bg	gui=NONE
hi ErrorMsg	guifg=#d0d080	guibg=#990000	gui=NONE
hi Title	ctermfg=31     ctermbg=0      gui=NONE
hi Directory	guifg=#80c0e0	guibg=bg	gui=NONE
hi MoreMsg	guifg=#66cc66	guibg=bg	gui=NONE
hi ModeMsg	guifg=fg	guibg=#003000	gui=NONE
hi SpecialKey	guifg=#00cc66	guibg=bg	gui=NONE

hi Todo	guifg=#66cc66	guibg=bg ctermfg=244   ctermbg=222   gui=NONE
hi Underlined	ctermfg=252   ctermbg=0   cterm=underline
hi Ignore	guifg=#535353	guibg=bg	gui=NONE
hi Error	ctermfg=255   ctermbg=88   gui=underline

"Adjustements

hi markdownUrl        ctermfg=33   ctermbg=0   cterm=underline
hi markdownBold       ctermfg=252   ctermbg=0   cterm=bold
hi markdownItalic     ctermfg=252   ctermbg=0   cterm=underline

hi NerdTreeDir        ctermfg=67    ctermbg=0      gui=None
hi NerdTreeExecFile   ctermfg=24    ctermbg=0      gui=None

" Default Highlight {{{1
hi Cursor	ctermfg=249    ctermbg=0
hi CursorIM	ctermfg=249    ctermbg=0
"TODO: change it
hi MatchParen	guifg=bg	guibg=#f0f080	gui=NONE

" search
hi Search	ctermfg=0   ctermbg=252
hi IncSearch	ctermfg=0  ctermbg=252     gui=bold

" visual mode
hi Visual	guifg=bg	guibg=#a0c0e0	gui=NONE
hi VisualNOS	guifg=bg	guibg=#e0c0a0	gui=NONE


" line numbers and folding
hi LineNr	ctermfg=240   ctermbg=233
hi CursorLineNr	ctermfg=252   ctermbg=233
hi NonText	guifg=#808080	guibg=bg	gui=NONE
hi Folded	guifg=fg	guibg=#003000	gui=NONE
hi FoldColumn	ctermfg=252   ctermbg=233   gui=NONE
hi SignColumn	ctermfg=252   ctermbg=233   gui=NONE

" windows, statusline
hi StatusLine	guifg=bg	ctermbg=252     cterm=NONE
hi StatusLineNC	guifg=bg	ctermbg=252     cterm=NONE
hi VertSplit	ctermfg=234	ctermbg=234     cterm=NONE
hi WildMenu	guifg=fg	guibg=#232323	gui=NONE

" colors for GUI
if 0 < s:mimic_colorize_gui

  " will be set for everyone but Windows.
  " Athena, Motif, Mac, Photon or GTK GUI.
  if has("gui_running") && !(has("gui_win32") || has("gui_win32s"))
    hi Menu	guifg=fg	guibg=#232323
    hi Scrollbar	guifg=bg	guibg=fg
    hi Tooltip	guifg=#801313	guibg=#c0c080
  endif
endif


set cursorline
""set cursorcolumn
hi CursorLine	  ctermbg=233	   cterm=NONE
hi CursorColumn	  cterm=NONE

" tab pages
hi TabLine	guifg=fg	guibg=#006000	gui=underline
hi TabLineFill	guifg=fg	guibg=#006000	gui=underline
hi TabLineSel	guifg=fg	guibg=bg	gui=NONE

" popup completion menu
" Normal item
hi Pmenu	ctermfg=0     ctermbg=75      gui=NONE
" Selected item
hi PmenuSel	guifg=bg	guibg=#a0c0d0	gui=underline
"Scrollbar
hi PmenuSbar	ctermfg=0     ctermbg=246      gui=NONE
"Thumb of scrollbar
hi PmenuThumb	ctermfg=0     ctermbg=240      gui=NONE

" spell checking
hi SpellBad	guisp=#ff9999		gui=undercurl
hi SpellCap	guisp=#9999ff		gui=undercurl
hi SpellLocal	guisp=#99ffff		gui=undercurl
hi SpellRare	guisp=#ff99ff		gui=undercurl


" diff
hi DiffAdd	guifg=#d0d0d0	guibg=#008000	gui=NONE
hi DiffChange	guifg=#d0d0d0	guibg=#000080	gui=NONE
hi DiffDelete	guifg=#6080f0	guibg=#232323	gui=NONE
hi DiffText	guifg=bg	guibg=#c0e080	gui=NONE


" Font Style {{{1
"~~~~~~~~~~~~
if 0 < s:mimic_font_style

  " Function:  s:MultiHi {{{2
  "   Sets highlight option(s) on all its arguments.
  " Parameters:
  "   option -- a string in the form of "key1=value1 key2=value2 ... keyN=valueN".
  "      ... -- the highlight group names.
  function s:MultiHi(option, ...)
    let l:i = 1
    while l:i <= a:0
      silent execute "highlight " . a:{l:i} . " " . a:option
      let l:i = l:i + 1
    endwhile
  endfunction "}}}2

  " set the bold only options, including the bold & italics groups.
  if 1 == s:mimic_font_style || 3 <= s:mimic_font_style
    call s:MultiHi("gui=bold", "WildMenu", "TabLineSel", "StatusLine", "MoreMsg", "ModeMsg", "Title", "Constant", "Statement", "PreProc", "Type", "Number", "Function", "Identifier", "Special", "Todo")
    call s:MultiHi("gui=bold,underline", "Error")
  endif

  " set the italic only options
  if 2 == s:mimic_font_style || 3 <= s:mimic_font_style
    call s:MultiHi("gui=italic", "StatusLineNC", "Folded", "Comment", "SpecialComment", "Question")
  endif

  " set the bold & italic options
  if 3 <= s:mimic_font_style
    call s:MultiHi("gui=bold,italic", "MoreMsg", "Title", "Identifier", "Function", "Todo")
  endif

  " cleanup
  delfunction s:MultiHi
endif

" Cleanup {{{1
"~~~~~~~~~
unlet s:mimic_font_style s:mimic_colorize_gui

" vim:noet:sw=22:ts=22:tw=0:nowrap:
" vim600:fdc=2:fdm=marker:
