highlight clear
syntax reset

let g:colors_name='light-theme'

if (&t_Co ?? 0) >= 16 && ! has("gui_running")

"
" General
"
hi Normal ctermfg=0 ctermbg=none cterm=none
hi Visual ctermfg=0 ctermbg=none cterm=reverse
hi Cursor ctermfg=0 ctermbg=none cterm=reverse
hi CursorLine ctermfg=none ctermbg=none cterm=none
hi CursorColumn ctermfg=none ctermbg=none cterm=none
hi CursorLineNr ctermfg=0 ctermbg=none cterm=bold
hi LineNr ctermfg=15 ctermbg=none cterm=none
hi EndOfBuffer ctermfg=15 ctermbg=none cterm=none
hi VertSplit ctermfg=15 ctermbg=none cterm=none
hi WildMenu ctermfg=0 ctermbg=15 cterm=none
hi ErrorMsg ctermfg=1 ctermbg=none cterm=reverse

"
" Status line
"
hi StatusLine ctermfg=0 ctermbg=15 cterm=none
hi StatusLineNC ctermfg=0 ctermbg=15 cterm=none
hi StatusLineTerm ctermfg=0 ctermbg=15 cterm=none
hi StatusLineTermNC ctermfg=0 ctermbg=15 cterm=none

"
" Tab line
"
hi TabLineFill ctermfg=none ctermbg=none cterm=none
hi TabLine ctermfg=0 ctermbg=none cterm=none
hi TabLineSel ctermfg=0 ctermbg=15 cterm=none

"
" Search
"
" hi Search ctermfg=0 ctermbg=13 cterm=bold
" hi IncSearch ctermfg=0 ctermbg=11 cterm=bold
" hi MatchParen ctermfg=0 ctermbg=13 cterm=bold

hi Search ctermfg=3 ctermbg=none cterm=underline
hi IncSearch ctermfg=13 ctermbg=15 cterm=underline
hi MatchParen ctermfg=0  ctermbg=13 cterm=underline

"
" Spell
"
hi SpellBad ctermfg=1 ctermbg=none cterm=underline
hi SpellCap ctermfg=4 ctermbg=none cterm=underline
hi SpellLocal ctermfg=4 ctermbg=none cterm=underline
hi SpellRare ctermfg=4 ctermbg=none cterm=underline

"
" Coding
"

" Comment
hi Comment ctermfg=7 ctermbg=none cterm=italic

" Constant
hi Constant ctermfg=6 ctermbg=none cterm=none
hi String ctermfg=2 ctermbg=none cterm=none
hi Character ctermfg=3 ctermbg=none cterm=none
hi Number ctermfg=6 ctermbg=none cterm=none
hi Float ctermfg=6 ctermbg=none cterm=none
hi Boolean ctermfg=3 ctermbg=none cterm=none

" Variable names and function names
hi Identifier ctermfg=0 ctermbg=none cterm=none
hi Function ctermfg=4 ctermbg=none cterm=none

" Keywords that define logic
hi Type ctermfg=4 ctermbg=none cterm=none
hi Statement ctermfg=4 ctermbg=none cterm=none
hi PreProc ctermfg=5 ctermbg=none cterm=none

" Shell
hi shConditional ctermfg=1 ctermbg=none cterm=none
hi shRange ctermfg=0 ctermbg=none cterm=none
hi shDerefSimple ctermfg=0 ctermbg=none cterm=none

" Vim
hi vimGroup ctermfg=5 ctermbg=none cterm=none

finish

endif

