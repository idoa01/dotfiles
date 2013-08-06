" use pathogen
runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()

" have syntax highlighting in terminals which can display colours:
if has('syntax') && (&t_Co > 2)
	syntax on
endif

" Add manual (Man) support:
runtime ftplugin/man.vim

set nocompatible              " We're running Vim, not Vi!
set background=dark           " Backgound is dark or light
set backspace=2               " Allow backspacing over identatiom, end-of-line, and start-of-line
set hidden                    " Enable working with hidden buffers
set vb                        " no beep
set ic                        " ingnore case in search
set scs                       " case sensitive when upper case search pattern
set scroll=0                  " set Pg Up/Dn to half screen size
set ru                        " cursor position
set cpt=.,w,b,u,t,i           " completion by all buffers, included files, etc
set bs=eol,start,indent       " allow backspacing over autoindent, line breaks, start of insert

"  Show matching parenthesis (Shlomi hates this, use '%' ffs)
"set showmatch

set laststatus=2              "  Always show status line

"   Folding options:
set foldmethod=indent         "  fold by indentation
set foldnestmax=1             "  1 level of folding is enough for me
set foldminlines=6            "  do not fold short functions
set foldlevel=1               "  Start unfolded (fold only if i say so)
"  I like to start unfolded 
"  to fold use 'zM'
"  to fold/unfold a single function use 'za'

"  Display the current mode and partially-typed commands in the status line:
set showmode
set showcmd
set nobackup                  " Don't keep a backup file

"  Remove control-ms - for those mails sent from DOS:
cmap ;rcm %s/<C-M>//g

set nowrap                    " don't make it look like there are line breaks where there aren't
filetype on                   " enable filetype detection
filetype indent on            " enables filetype specific indenting
filetype plugin on            " enables filetype specific plugins

" use indents of 4 spaces, and have them copied down lines:
set shiftwidth=4
set softtabstop=4
set shiftround
set expandtab
set autoindent

" define filetypes 
autocmd BufNewFile,BufRead *.ftl set filetype=html
autocmd BufNewFile,BufRead *.axlsx set filetype=ruby
" for C-like programming, have automatic indentation
autocmd FileType c,cpp,slang set cindent
" for Perl programming, have things in braces indenting themselves:
autocmd FileType perl set smartindent
" CloseTag plugin
autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1
autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako source ~/.vim/bundle/closetag/plugin/closetag.vim
" set FileType indentation
autocmd BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab
" autocomplete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=phpcomplete#CompleteTags

let g:SuperTabDefaultCompletionType = 'context'
set completeopt=menuone,longest,preview

" tagbar for javacript
let g:tagbar_type_javascript = {
    \ 'ctagsbin' : '/usr/local/bin/jsctags'
\ }

"set ai
"map <F3> :w<CR>
"map <kPlus> :set nu<CR>
"map <kMinus> :set nonu<CR>

"  shift+f1 = complete filenames
imap <S-F1> <c-x><c-f>
"  shift+f2 = complete whole line
imap <S-F2> <c-x><c-l>

"  Prev buffer
" map <F1> :bp<CR>
" imap <F1> <c-[>:bp<CR>
nmap ,, :bp<CR>
"  Next buffer
" map <F2> :bn<CR>
" imap <F1> <c-[>:bn<CR>
nmap .. :bn<CR>
"  Change split size
map <S-F1> <c-w>+
map <S-F2> <c-w>-
"  Split file explorer
map <F3> :Sex<CR>
imap <F3> <c-[>:Sex<CR>
"  hide/unhide split
map <F4> :hide<CR>
imap <F4> <c-[>:hide<CR>
map <S-F4> :sunhide<CR>
imap <S-F4> <c-[>:sunhide<CR>
"  Maximize buffer
map <F5> :only<CR>
imap <F5> <c-[>:only<CR>li
map <S-F5> :sunhide<CR>
imap <S-F5> <c-[>:sunhide<CR>li
"  Switch between splits
"  use <F6> to cycle through split windows (and <Shift>+<F6> to cycle
"  backwards,
map <F6> :wincmd w<CR>
imap <F6> <c-[>:wincmd w<CR>
map <S-F6> :wincmd W<CR>
imap <S-F6> <c-[>:wincmd W<CR>
"  my search dialog ..
map <F7> :%s///&c
imap <F7> <c-[>:%s///&c
"  Compile C file and open error window
set makeprg=gcc\ -c\ %
map <F9> :w<CR>:make<CR>:copen 3<CR>
"map <S-F9> :set makeprg=gcc\ -c\ %\ -o\ %<:make<CR>:copen 3<CR>

"select buffer (displays list of buffers, then you choose bufer number and pess enter)
map <F11> :buffers<CR>:b<Space>
imap <c-[><F11> :buffers<CR>:b<Space>
"unload buffer
map <F12> :bdelete<CR>
imap <F12> <c-[>:bdelete<CR>
map <S-F12> :bdelete!<CR>
imap <S-F12> <c-[>:bdelete<CR>

"Tab navigation
map ty :tabprevious<CR>
map tr :tabnext<CR>
nmap <C-t> :tabnew<CR>
nmap <C-w> :tabclose<CR>
"imap <C-S-tab> <ESC>:tabprevious<CR>i
"imap <C-tab> <ESC>:tabnext<CR>i
"imap <C-t> <ESC>:tabnew<CR>i

" gundo plugin
map <leader>g :GundoToggle<CR>

" PEP8 validation
let g:pep8_map='<leader>8'

"map g :1^V^M
"map q :q<CR>

" for vim as man pager:
let $PAGER=''

" Very cool tab completion
function! InsertTabWrapper(direction)
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    elseif "backward" == a:direction
        return "\<c-p>"
    else
        return "\<c-n>"
    endif
endfunction
 
"inoremap <tab> <c-r>=InsertTabWrapper ("forward")<cr>
"inoremap <s-tab> <c-r>=InsertTabWrapper ("backward")<cr>
"inoremap <tab> <c-x><c-f>

" toggle tab completion
function! TabCompletion()
    if mapcheck("\<tab>", "i") != ""
        :iunmap <tab>
"        :iunmap <s-tab>
"        :iunmap <c-tab>
        echo "tab completion off"
    else
        :imap <tab> <c-n>
"        :imap <s-tab> <c-p>
"        :imap <c-tab> <c-x><c-l>
        echo "tab completion on"
    endif
endfunction

"shift+f12 to toggle tab comletion
map <S-F11> :call TabCompletion()<cr>
 
" Unselect searched words
nmap <silent> <C-N> :silent noh<CR>


"shift-right in insert mode - to visual (as in windows - mark)
imap <S-Right> <Esc><Right>v
vmap <S-Right> <Right>
vmap <CR> <Esc>
nmap <S-Right> v<Right>

set  path=.,,~
set   shortmess=at

"Shift-RIGHT complete when inc search what's under the cursor
"Shift-Down complete whole word - under cursor
cnoremap <S-Down> <CR>yiw<BS>/<C-R>"
cnoremap <S-Right> <CR>y/<Up>/e+1<CR><BS>/<C-R>=escape(@",'.*\/?')<CR>

se wildignore=*.o,*.obj,*.bak,*.exe
" While typing a search pattern, show immediately where the so far typed pattern matches.
se incsearch 
" Use standard dictionary file
set dictionary=/usr/share/dict/words

"Insert from clipboard 
map <S-Insert> i<MiddleMouse><Esc>
map! <S-Insert> <MiddleMouse>

"I do not like replace mode
map <Insert> <Esc>i
map! <Insert> <Esc>i

map <C-e> :TagbarToggle<CR>

"LIKE NODEPADE
"map! <F5>     <Esc>:r! date<CR>i<xHome><BS><xEnd>

"-----------------------------
" Highlight all instances of word under cursor, when idle. 
" Useful when studying strange source code. 
" Turn on/off with z/ (or key of your choice) 
:map z/ :call Mosh_Auto_Highlight_Toggle()<CR> 

:function! Mosh_Auto_Highlight_Cword() 
     :exe "let @/='\\<".expand("<cword>")."\\>'" 
:endfunction 

function! Mosh_Auto_Highlight_Toggle() 
    :if exists("#CursorHold#*") 
    :  au! CursorHold * 
    :  let @/='' 
    :else 
    :  set hlsearch
    :  set updatetime=500 
    :  au! CursorHold * nested call Mosh_Auto_Highlight_Cword() 
    :endif 
endfunction 
"------------------------------

" prevent MBE from showing up when there are only two buffers open, so that
" GDiff will work correctly
let g:miniBufExplorerMoreThanOne=3

if has("statusline")
    set statusline=%<%f\ %h%m%r%=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%k\ %-14.(%l,%c%V%)\ %P
endif

function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()

function! DoTidy()
    "runs tidy on xml format
    silent %!tidy -i -xml -q
endfunction
command! Tidy call DoTidy()

" ex command for toggling hex mode - define mapping if desired
command -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction
