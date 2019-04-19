"##
"## ~/.vimrc -- vim(1) configuration
"## Copyright (c) 1995-2019 Dr. Ralf S. Engelschall <rse@engelschall.com>
"## Distributed under MIT <https://opensource.org/licenses/MIT> license.
"##

"   we require Vim and do not have to be Vi compatible
version 8.0
set nocompatible

"   ==== TERMINAL HANDLING ===================================================

"   avoid "Thanks for Flying Vim" titles in terminals
set notitle

"   ==== COMMAND-LINE & STATUS-LINE ==========================================

"   tell command-line more Bash-style editing
cnoremap <C-A> <Home>

"   display a status line plus a single-line command-line and always
"   tell me where I'm inside the file. Also enable TAB completion (wildmenu)
set laststatus=2
set cmdheight=1
set wildmenu
set ruler
set statusline=%<%f\ %h%m%r%=%{StatusLineCounts()}\ \ %-14.(%l,%c%V%)\ %P

"   determine the word and character count of the buffer or current selection
function! StatusLineCounts()
    "   fetch output of g<CTRL-g>
    let position = getpos(".")
    let s:old_status = v:statusmsg
    exe ":silent normal g\<c-g>"
    let stat = v:statusmsg
    let v:statusmsg = s:old_status
    call setpos('.', position)

    "  possible outputs (for regular and selected situations):
    "  Col X of X; Line X of X; Word X of X; Byte X of X
    "  Selected X of X Lines; X of X Words; X of X Bytes
    let s:word_count = 0
    let s:char_count = 0
    if stat =~# '^Col \d\+ of \d\+; Line \d\+ of \d\+; Word \d\+ of \d\+; Byte \d\+ of \d\+$'
        let s:word_count = str2nr(split(stat)[11])
        let s:char_count = str2nr(split(stat)[15])
    elseif stat =~# '^Selected \d\+ of \d\+ Lines; \d\+ of \d\+ Words; \d\+ of \d\+ Bytes$'
        let s:word_count = str2nr(split(stat)[5])
        let s:char_count = str2nr(split(stat)[9])
    end
    return (s:word_count . "w," . s:char_count . "c")
endfunction


"   show command and modes
set showcmd
set showmode

"   don't beep for every silly command and write shorter messages.
set noerrorbells
set terse

"   ==== SUB-WINDOW AND TAB HANDLING ========================================

"   Always expand windows to the maximum height, but expand only to the
"   minimum width of 100 characters per line. Also, create new windows
"   below current one.
set winheight=9999
set winwidth=100
set splitbelow

"   configure additional window key-handling
map <C-w>-  :new<CR>
map <C-w>\| :vnew<CR>
map <C-w>c  :new<CR>
map <C-w>x  :close<CR>

"   configure "tabs" coloring
highlight TabLine     term=reverse cterm=reverse ctermfg=none  ctermbg=none
highlight TabLineFill term=reverse cterm=reverse ctermfg=none  ctermbg=none
highlight TabLineSel  term=bold    cterm=bold    ctermfg=White ctermbg=Red

"   configure "tabs" key-handling
"   Notice 1: CTRL-E similar to CTRL-W for sub-windows
"   Notice 2: CTRL-E is directly beside CTRL-W on keyboard
"   Notice 2: CTRL-T is unconvenient for pressing with just the fingers on left hand
map <C-e>c       :tabnew<CR>
map <C-e>n       :tabnew<CR>
map <C-e>o       :tabonly<CR>
map <C-e>x       :tabclose<CR>
map <C-e><LEFT>  :tabprevious<CR>
map <C-e><RIGHT> :tabnext<CR>
map <S-TAB>      :tabnext<CR>

"   ==== SHELL SUPPORT ======================================================

"   always use my login shell (GNU Bash) for sub-shells
set shell=$SHELL

"   ==== FILE HANDLING =======================================================

"   read/write a .viminfo file, but don't store more than 50 lines of registers
set viminfo='20,\"50

"   no automatic writing of files,
"   i.e. I KNOW WHAT I DO! Well, at least most of the time ;-)
set noautowrite

"   create ".bak" files only while saving. If current dir is not
"   allowed to create the file, save it under the backup dir instead
set nobackup
set writebackup

"   write swap files "*.swp" to this dir if not allowed at the current one
set directory=$HOME/tmp,/tmp

"   ==== BUFFER EDITING ======================================================

"   check first 6 lines for Vi set commands (e.g. 'vi:set tabstop=4 shiftwidth=4').
set modeline
set modelines=6

"   always insert TABs as SPACEs (only exception are Makefile files)
"   but preserve already existing tabs in order to not destroy existing content
set expandtab
autocmd BufRead Makefile,Makefile.*,GNUMakefile set noexpandtab

"   by default do not enable line-folding
set nofoldenable

"   allow us to backspace back over lines in insert mode and also
"   to go back over the starting point.
set backspace=2

"   allow virtual editing (moving cursor where no content is) in Visual block mode
set virtualedit=block

"   do not wrap lines (neither implicitly on display nor explicitly
"   during editing), except for real text files. Also, shift a minimum
"   of 4 chars left/right if we go over the right/left border.
set textwidth=9999
autocmd BufRead *.txt set textwidth=78
set nowrap
set shiftwidth=4

"   always indent new lines the same as the last one.
"   also, use a C-programmer-style smart tab editing.
set autoindent
set smartindent
set tabstop=4

"   do incremental search with smart case sensitivity and highlighting behavior
set incsearch
set smartcase
set hlsearch

"	make "Y" analogous to "C" and "D" for better orthogonality
map Y y$

"   backward compatibility to some smarter Vim 4.x keystrokes
noremap Q gq
noremap gQ Q

"   CTLR-] is nearly impossible on german keyboards
map gt <C-]>
map gb <C-T>

"   Vim and other tools inside an xterm think Delete key is <backspace>
"   and Backspace key is <delete> but we cannot just swap them. In
"   Vim this swapping doesn't work and via xmodmap other X11 applications
"   would be affected, too. So we the following: We map Delete to CTRL-D
"   for the XTerms via xrdb and then remap the keys here in Vim.
imap  lxi

"   ==== SYNTAX HIGHLIGHTING ================================================

"   enable syntax highlighting
syntax on

"   reconfigure syntax highlighting to be very conservative in coloring
highlight Statement  ctermbg=None      ctermfg=DarkBlue  cterm=Bold
highlight Keyword    ctermbg=None      ctermfg=DarkBlue  cterm=Bold
highlight Type       ctermbg=None      ctermfg=DarkBlue  cterm=Bold
highlight Constant   ctermbg=None      ctermfg=DarkRed   cterm=None
highlight Identifier ctermbg=None      ctermfg=None      cterm=None
highlight Comment    ctermbg=None      ctermfg=DarkGrey  cterm=None
highlight PreProc    ctermbg=None      ctermfg=DarkRed   cterm=None
highlight Special    ctermbg=None      ctermfg=DarkRed   cterm=None
highlight Ignore     ctermbg=None      ctermfg=White     cterm=Bold
highlight Underlined ctermbg=None      ctermfg=None      cterm=Underline
highlight Error      ctermbg=DarkRed   ctermfg=White     cterm=Bold
highlight Todo       ctermbg=DarkRed   ctermfg=White     cterm=Bold
highlight Constant   ctermbg=None      ctermfg=DarkRed   cterm=None
highlight Title      ctermbg=None      ctermfg=DarkBlue  cterm=None
highlight MatchParen ctermbg=None      ctermfg=DarkRed   cterm=None
highlight Pmenu      ctermbg=White     ctermfg=None      cterm=None
highlight PmenuSel   ctermbg=Black     ctermfg=White     cterm=None
highlight PmenuSbar  ctermbg=Black     ctermfg=White     cterm=None
highlight DiffAdd    ctermbg=DarkBlue  ctermfg=White     cterm=None
highlight DiffDelete ctermbg=DarkRed   ctermfg=White     cterm=None
highlight DiffChange ctermbg=Yellow    ctermfg=Black     cterm=None
highlight DiffText   ctermbg=Yellow    ctermfg=DarkRed   cterm=Bold
highlight htmlItalic ctermbg=None      ctermfg=DarkRed   cterm=None
highlight htmlBold   ctermbg=None      ctermfg=DarkRed   cterm=Bold

"   ==== LOCAL CONFIGURATION ================================================

"   include optional local configuration
if filereadable(expand("~/.dotfiles/vimrc"))
    source ~/.dotfiles/vimrc
endif

