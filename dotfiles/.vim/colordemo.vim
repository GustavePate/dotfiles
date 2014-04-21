
":so colordemo.vim to lauch


"let num = 8
"while num >= 0
"    exec 'hi col_'.num.' ctermfg='.num.' ctermbg=black'
"    exec 'syn match col_'.num.' "ctermfg='.num.':...." containedIn=ALL'
"    call append(0, 'ctermfg='.num.':....')
"    let num = num - 1
"endwhile


let allkindofblue=[36,37,38,43,44,45,49,50,51,159,152,153,147,146,145,115,116,117,109,110,111,73,74,81,87,66,67,68,69,60,61,62,63,23,24,25,75,39,30,31,32,33,26,27,21]
for num in allkindofblue
    exec 'hi col_'.num.' ctermfg='.num.' ctermbg=black'
    exec 'syn match col_'.num.' "ctermfg='.num.':xxxx" containedIn=ALL'
    call append(0, 'ctermfg='.num.':xxxx')
    let num = num - 1
endfor

let bestof=[24,67,131,38,60,31,30,146,74,57,117,111,74]
for num in bestof
    exec 'hi col_'.num.' ctermfg='.num.' ctermbg=black'
    exec 'syn match col_'.num.' "ctermfg='.num.':xxxx" containedIn=ALL'
    call append(0, 'ctermfg='.num.':xxxx')
    let num = num - 1
endfor

"function! Display(num)
"    exec 'hi col_'.a:num.' ctermfg='.a:num.' ctermbg=black'
"    exec 'syn match col_'.a:num.' "ctermfg='.a:num.':...." containedIn=ALL'
"    call append(0, 'ctermfg='.num.':....')
"    return num
"endfunction

"function! Display2(lust)
"    for num in a:lust
"        exec 'hi col_'.num.' ctermfg='.num.' ctermbg=black'
"        exec 'syn match col_'.num.' "ctermfg='.num.':...." containedIn=ALL'
"        call append(0, 'ctermfg='.num.':....')
"    endfor
"    return num
"endfunction

"let youpi=[233, 252, 225]

"call Display(8)
"call Display2(youpi)
