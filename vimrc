" I started my vimrc based on https://github.com/empty/vimrc.git
set nocompatible
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype on
filetype plugin on
filetype indent on



" Security
set modelines=0

" Tabs/spaces
set tabstop=4
set shiftwidth=4
set shiftround      " use multiple shiftwidth
set softtabstop=4
set expandtab
set smarttab      " insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop


" Basic options
set encoding=utf-8
set scrolloff=3
set autoindent
set copyindent    " copy the previous indentation on autoindenting
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set relativenumber
set laststatus=2
set undofile
set numberwidth=6
set undolevels=1000      " use many muchos levels of undo

"Informative status line
set statusline=%F%m%r%h%w%{fugitive#statusline()}\ [TYPE=%Y\ %{&ff}]\ [%l/%L\ (%p%%)]\ Col:%c

" Backups
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files
set backup                        " enable backups
set undodir=~/.vim/tmp/undo//

" Leader
let mapleader = ","

" Searching
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set incsearch " show search matches as you type
set showmatch
set hlsearch
set gdefault
map <leader><space> :noh<cr>
runtime macros/matchit.vim
nmap <tab> %
vmap <tab> %

" Soft/hard wrapping
set nowrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=79
set sidescroll=5

" Use the same symbols as TextMate for tabstops and EOLs
set list
set listchars=tab:▷⋅,trail:⋅,nbsp:⋅" mark trailing white space

" Color scheme (terminal)
syntax on
set background=dark
colorscheme delek

" NERD Tree
map <F2> :NERDTreeToggle<cr>
map <leader>nt :NERDTreeToggle<cr>
let NERDTreeIgnore=['.vim$', '\~$', '.*\.pyc$', 'pip-log\.txt$']
"let NERDTreeWinPos="right"
let NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.bak$', '\~$']
let NERDTreeQuitOnOpen = 1

" Use the damn hjkl keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

" And make them fucking work, too.
nnoremap j gj
nnoremap k gk

" Easy buffer navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" Quickly vertical split a window
nnoremap <leader>w <C-w>v<C-w>l

" Folding
set foldlevelstart=20
nnoremap <Space> za
vnoremap <Space> za
" au BufNewFile,BufRead *.html
map <leader>ft Vatzf
autocmd Syntax c,cpp,vim,xml,html,xhtml,py setlocal foldmethod=syntax
autocmd Syntax c,cpp,vim,xml,html,xhtml,py,perl normal zR


function! MyFoldText()
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 4
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction
set foldtext=MyFoldText()

" Fuck you, help key.
set fuoptions=maxvert,maxhorz
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" Various syntax stuff
au BufNewFile,BufRead *.less set filetype=less
au BufRead,BufNewFile *.scss set filetype=scss

au BufNewFile,BufRead *.m*down set filetype=markdown
au BufNewFile,BufRead *.m*down nnoremap <leader>1 yypVr=
au BufNewFile,BufRead *.m*down nnoremap <leader>2 yypVr-
au BufNewFile,BufRead *.m*down nnoremap <leader>3 I### <ESC>

" Sort CSS
map <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>

" Clean whitespace
map <leader>x :%s/\s\+$//<cr>:let @/=''<CR>

" Exuberant ctags!
let Tlist_Ctags_Cmd = "/usr/local/bin/ctags"
let Tlist_WinWidth = 50
" map <F4> :TlistToggle<cr>
" map <F5> :!/usr/local/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --exclude='@.ctagsignore' .<cr>

" Ack
map <leader>a :Ack

" Yankring
nnoremap <silent> <F3> :YRShow<cr>
nnoremap <silent> <leader>y :YRShow<cr>

" Formatting, TextMate-style
map <leader>q gqip

nmap <leader>m :make<cr>

" Google's JSLint
au BufNewFile,BufRead *.js set makeprg=gjslint\ %
au BufNewFile,BufRead *.js set errorformat=%-P-----\ FILE\ \ :\ \ %f\ -----,Line\ %l\\,\ E:%n:\ %m,%-Q,%-GFound\ %s,%-GSome\ %s,%-Gfixjsstyle%s,%-Gscript\ can\ %s,%-G

" TESTING GOAT APPROVES OF THESE LINES
au BufNewFile,BufRead test_*.py set makeprg=nosetests\ --machine-out\ --nocapture
au BufNewFile,BufRead test_*.py set shellpipe=2>&1\ >/dev/null\ \|\ tee
au BufNewFile,BufRead test_*.py set errorformat=%f:%l:\ %m
au BufNewFile,BufRead test_*.py nmap <silent> <Leader>n <Plug>MakeGreen
au BufNewFile,BufRead test_*.py nmap <Leader>N :make<cr>
nmap <silent> <leader>ff :QFix<cr>
nmap <leader>fn :cn<cr>
nmap <leader>fp :cp<cr>

command! -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
    unlet g:qfix_win
  else
    copen 10
    let g:qfix_win = bufnr("$")
  endif
endfunction


" TODO: Put this in filetype-specific files
au BufNewFile,BufRead *.less set foldmethod=marker
au BufNewFile,BufRead *.less set foldmarker={,}
au BufNewFile,BufRead *.less set nocursorline
au BufRead,BufNewFile /etc/nginx/conf/* set ft=nginx
au BufRead,BufNewFile /etc/nginx/sites-available/* set ft=nginx
au BufRead,BufNewFile /usr/local/etc/nginx/sites-available/* set ft=nginx

" Easier linewise reselection
map <leader>v V`]

" HTML tag closing
inoremap <C-_> <Space><BS><Esc>:call InsertCloseTag()<cr>a
inoremap <D-.> <Space><BS><Esc>:call InsertCloseTag()<cr>a

" Faster Esc
"inoremap <Esc> <nop>
inoremap jj <ESC>
inoremap jk <ESC>

" Scratch
nmap <leader><tab> :Sscratch<cr><C-W>x<C-j>:resize 15<cr>

" Diff
nmap <leader>d :!git diff %<cr>

" Rainbows!
nmap <leader>R :RainbowParenthesesToggle<CR>

" Edit .vimrc
nmap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
map <leader>sv :source $MYVIMRC<cr>

" Sudo to write
cmap w!! w !sudo tee % >/dev/null

" Easy filetype switching
nnoremap _dt :set ft=htmldjango<CR>

" VCS Stuff
let VCSCommandMapPrefix = "<leader>h"

" Disable useless HTML5 junk
let g:event_handler_attributes_complete = 0
let g:rdfa_attributes_complete = 0
let g:microdata_attributes_complete = 0
let g:atia_attributes_complete = 0

" Shouldn't need shift
" nnoremap ; :
" some claim reverse messes with plugins?
" nnoremap : ;

" Save when losing focus
" au FocusLost * :wa

" Stop it, hash key
" inoremap # X<BS>#

if has('gui_running')
    set guifont=Bitstream\ Vera\ Sans\ Mono:h14.00
    colorscheme ir_black
    syntax enable
    set number "add line numbers

    set go-=T
    set go-=l
    set go-=L
    set go-=r
    set go-=R

    if has("gui_macvim")
        macmenu &File.New\ Tab key=<nop>
    end

    let g:sparkupExecuteMapping = '<D-e>'

    highlight SpellBad term=underline gui=undercurl guisp=Orange
endif
":autocmd VimEnter * NERDTree

" ------------------------------------------------------------------------------------------------------------------
" ptone specific additions:"

nmap <RETURN> o<ESC>

" mimic cmd-keybinding for comments in TextMate
nmap <D-/> <Plug>NERDCommenterToggle
vmap <D-/> <Plug>NERDCommenterToggle
imap <D-/> #<SPACE>

" familiar select to start/end of line:
nmap <S-Right> v$
nmap <S-Left> v^
vmap <S-Right> $
vmap <S-Left> ^

" familiar open new line from textmate:
imap <D-Return> <ESC>o
nmap <D-Return> o<ESC>

" double click to select word
nmap <2-LeftMouse> vaw
imap <2-LeftMouse> <ESC>vaw
vmap <2-LeftMouse> aw

" is there ever a use for return over enter - trying to get return key to work with autocomplete selection -not working
map <Return> <Enter>

" set up smart wrapping
command! -nargs=* Wrap set wrap linebreak nolist
" set anon register to == system clipboard
" defaults to yanking to system clipboard
set clipboard=unnamed

" visually select last paste:
nnoremap gp `[v`]

" http://vim.wikia.com/wiki/Setting_file_attributes_without_reloading_a_buffer
function! SetExecutableBit()
  let fname = expand("%:p")
  checktime
  execute "au FileChangedShell " . fname . " :echo"
  silent !chmod a+x %
  checktime
  execute "au! FileChangedShell " . fname
endfunction
command! Xbit call SetExecutableBit()

" command that inserts path to file of currently selected file in finder
command! Fpath :r !getfinderpath.sh
imap fpath <ESC>:let @n = substitute(system("getfinderpath.sh"),"\n","","")<CR>"npi
"imap fpath <ESC>mn:r !getfinderpath.sh<CR>"nD`n"npi

" set Y to yank to end of line instead of duplicate yy
nmap Y y$

" add the space between comment char and code
let NERDSpaceDelims=1

" recursively search up for tags:
set tags=tags;/

" toggle taglist window
nmap <leader>tl :TlistToggle<CR>
" update tags
nmap <leader>tu :!/usr/local/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<cr>
" nmap <leader>tu :!/usr/local/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --exclude='@.ctagsignore' .<cr>

" select most recently pasted block
nnoremap gp `[v`]

" set snippets dir to not conflict with default shipped snippets placed
" by pathogen
" let snippets_dir="/Users/preston/.vim/mysnippets/"
" not really working
" call ReloadAllSnippets()

" FuzzyFinder plugin
map <leader>ft :FufTag<CR>
map <leader>fb :FufBuffer<CR>

" fix snipMate:
" was never able to get tab to work, so mapped <C-j> in plugin source
" the next two lines were then not needed
" source /Users/preston/UNIX/dotfiles/vim/bundle/snipmate/plugin/snipMate.vim
" source /Users/preston/UNIX/dotfiles/vim/bundle/snipmate/after/plugin/snipMate.vim
" this line is super handy,but seems to break the taglist plugin
" autocmd FileType python set ft=python.django " For SnipMate
autocmd FileType html set ft=htmldjango.html " For SnipMate
" inoremap <C-_> <Space><BS><Esc>:call InsertCloseTag()<cr>a
" pydict location:
let g:pydiction_location = '/Users/preston/UNIX/dotfiles/vim/util/complete-dict'

" ------------- Run Current Buffer in Python --------------------
fu! DoRunPyBuffer2()
pclose! " force preview window closed
setlocal ft=python

" copy the buffer into a new window, then run that buffer through python
sil %y a | below new | sil put a | sil %!python -
" indicate the output window as the current previewwindow
setlocal previewwindow ro nomodifiable nomodified

" back into the original window
winc p
endfu
" ----------------------------------------------------------- 
"
"
command! RunPyBuffer call DoRunPyBuffer2()
map <Leader>p :RunPyBuffer<CR>
" ----------------------------------------------------------- 


"  get more python highlighting
au FileType python syn keyword pythonDecorator True None False self

" should one want to change colorscheme for diffs (haven't found a great one)
" if &diff
    " colorscheme macvim
    " set background=light
" endif

" allow nesting of docstring style quotes
au FileType python let b:delimitMate_nesting_quotes = ['"']
" au FileType rst let b:delimitMate_nesting_quotes = ['`']

" map command-t not to delay conflict with <leader>tl for taglist toggle
nmap <Leader>tt :CommandT<CR>
nmap <D-t> :CommandT<CR>
set wildignore+=*.o,*.obj,.git,*.pyc

" pylint.vim
autocmd FileType python compiler pylint
let g:pylint_onwrite = 0

" mimic shift select from normal macos text editors
" nmap <S-W> vw
" nmap <S-B> vb

" activate virtualenv in vim python
if($VIRTUAL_ENV)
    :python activate_this = '$VIRTUAL_ENV/bin/activate_this.py'
    :python execfile(activate_this, dict(__file__=activate_this))
endif

"load any vim customizations for the virtualenv
if filereadable($VIRTUAL_ENV . '/.vimrc')
    source $VIRTUAL_ENV/.vimrc
end

" fugitive.vim
" ------------------------------
nmap <leader>gs :Gstatus<cr>
nmap <leader>gc :Gcommit<cr>
nmap <leader>ga :Gwrite<cr>
nmap <leader>gl :Glog<cr>
nmap <leader>gd :Gdiff<cr>
nmap <leader>gr :Gread<cr>

" now set it up to change the status line based on mode
if version >= 700
  au InsertEnter * hi StatusLine guibg=#B02832
  au InsertLeave * hi StatusLine guibg=#235E20
endif

" jump to end of line and keep editing - useful for
" escaping out of delimitmate quote brace etc 
inoremap <D-'> <esc><S-a>

" quick macro to help with rst headings:
" follow macro with typing of heading char
let @h = "yypVr"

" insert at next blank line:
" the ko instead of O preserves indent
nnoremap <leader>o }ko

" jump to next/prev line of same indent
" http://vim.wikia.com/wiki/Move_to_next/previous_line_with_same_indentation
nnoremap <D-k> k:call search('^'. matchstr(getline(line('.')+1), '\(\s*\)') .'\S', 'b')<CR>^
nnoremap <D-j> :call search('^'. matchstr(getline(line('.')), '\(\s*\)') .'\S')<CR>^

" switch process dir to parent of current file
" ,cd is now used by rooter.vim
" not sure what the :h part does
nmap <leader>cdc :lcd %:h<CR>

" make sure path exists for new file
:if !exists("pathmaker")
    let pathmaker = 1
    au BufNewFile * :silent !mkdir -p %:p:h
    " au BufFileNew * mkdir(%:p:h)
:endif


