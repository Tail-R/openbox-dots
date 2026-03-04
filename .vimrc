"
" Settings
"
set notitle
set encoding=UTF-8

set nobackup
set noswapfile

set shell=bash

set mouse=a " Enable mouse

set number
set norelativenumber
set cursorline
set nocursorcolumn

set nowrap
set virtualedit=onemore
set nosmartindent
set smarttab " Delete multiple spaces as a single tab
set expandtab " Use space instead of tab
set tabstop=4
set shiftwidth=4

set wrapscan
set incsearch
set hlsearch
set smartcase
set ignorecase

set spell
set background=light

set wildmenu

syntax on
colorscheme light-theme

"
" Status Line
"
set laststatus=2 " Show always
set noshowmode

if (&t_Co ?? 0) >= 16 && ! has('gui_running')
    " Set user highlight group to User{N} [The N must be 1 ~ 9]
    " :h statusline to see more details
    
    hi HiLeft   ctermfg=0 ctermbg=15 cterm=bold
    hi HiCenter ctermfg=0 ctermbg=15 cterm=bold
    hi HiRight  ctermfg=0 ctermbg=15 cterm=bold

    " Set color scheme
    set statusline=%1*
    set statusline+=%#HiLeft#
    set statusline+=\ %{GetCurrentMode()}\ %m%r\ 
 
    " Left items
    
    " Jump to the right section
    set statusline+=%#HiCenter#
    set statusline+=%=
    
    " Right items
    set statusline+=\ %l:%c\ %LL\ 

    set statusline+=%#HiRight#
    set statusline+=\ %{GetCurrentFileName()}\ 
endif

"
" Tab Line
"
set showtabline=1
set tabline=%!MyTabLine()

"
" Remap
"
let mapleader = 'g' "  use space as leaderkey

" Move between tabs
nnoremap <Leader>t :tabnew<CR>
nnoremap <Leader>c :tabclose<CR>
nnoremap <Leader>n :tabnext<CR>
nnoremap <Leader>p :tabprev<CR>

" Move between windows
nnoremap <S-h> <C-w>h
nnoremap <S-j> <C-w>j
nnoremap <S-k> <C-w>k
nnoremap <S-l> <C-w>l

" Resize the current window
nnoremap <C-h> :vertical resize -2<CR>
nnoremap <C-j> :resize +2<CR>
nnoremap <C-k> :resize -2<CR>
nnoremap <C-l> :vertical resize +2<CR>

nnoremap <Leader>h ^<Left> " jump tp the start of line
nnoremap <Leader>l $ " jump to the end of line

" Disable highlighting until next search
nnoremap <C-n> :noh<CR>

" Echo the highlight group name
nnoremap <S-g> :echo synIDattr(synID(line("."), col("."), 1), "name")<CR>

" Auto completions
inoremap ( ()<Left>
inoremap { {}<Left>
inoremap [ []<Left>
" inoremap < <><Left>
inoremap " ""<Left>
inoremap /* /*  */<Left><Left><Left>
inoremap <!-- <!--  --><Left><Left><Left><Left>

nnoremap <C-c> :call CopyVisualSelection()<CR>
vnoremap <C-c> :call CopyVisualSelection()<CR>

"
" Functions
"
function! GetCurrentMode()
    let mode = mode()
     
    if mode ==# 'n'
        let current_mode = 'Normal'
    elseif mode ==# 'v'
        let current_mode = 'Visual'
    elseif mode ==# 'V'
        let current_mode = 'Visual Line'
    elseif mode ==# "\<C-v>"
        let current_mode = 'Visual Block'
    elseif mode ==# 'i'
        let current_mode = 'Insert'
    elseif mode ==# 'c'
        let current_mode = 'Command-Line'
    elseif mode ==# 't'
        let current_mode = 'Terminal'
    else
        let current_mode = mode
    endif

    return current_mode
endfunction

function! GetCurrentFileName()
    let fileName = expand('%:t')
    
    return fileName == '' ? '[No Name]' : fileName
endfunction

" Tab Appearance
function MyTabLine()
    let s = ''
    
    for i in range(tabpagenr('$'))
        let s..= i + 1 == tabpagenr() ? '%#TabLineSel#': '%#TabLine#'
        
        let s ..= '%' .. (i + 1) .. 'T'
        let s ..= ' %{GetTabLabel(' .. (i + 1) .. ')} '
    endfor
    
    let s ..= '%#TabLineFill#%T'
 
    return s
endfunction

function GetTabLabel(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    let bufname = bufname(buflist[winnr - 1])
    
    return bufname == '' ? 'No Name' : bufname
endfunction

" Copy selected area to the system clipboard via xclip
function CopyVisualSelection() abort
    let vblock = GetVisualSelection()
    call system('xclip -sel clip', vblock)
endfunction

function! GetVisualSelection()
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    
    if len(lines) == 0
        return ''
    endif
    
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    
    return join(lines, "\n")
endfunction

"
" Startup commands
"
augroup makefileTab
    autocmd!
    autocmd FileType make set noexpandtab
    autocmd FileType make set tabstop=4
    autocmd FileType make set shiftwidth=4
augroup END

augroup xmlTab
    autocmd!
    autocmd FileType xml set expandtab
    autocmd FileType xml set tabstop=2
    autocmd FileType xml set shiftwidth=2
augroup END

augroup autoShebang
    autocmd!
    autocmd BufNewFile *.sh call append(0, '#! /usr/bin/env bash')
    autocmd BufNewFile *.py call append(0, '#! /usr/bin/env python3')
    autocmd BufNewFile *.lua call append(0, '#! /usr/bin/env lua')
augroup END

" Return to the last edit position
autocmd bufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" XML tag auto completion
set omnifunc=xmlcomplete#CompleteTags
augroup MyXML
    autocmd!
    autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
augroup END

