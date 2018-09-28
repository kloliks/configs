" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50  " keep 50 lines of command line history
set ruler       " show the cursor position all the time
set showcmd     " display incomplete commands
set incsearch   " do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

"

set exrc

let $PAGER=''

"set smarttab
"set noexpandtab
"set copyindent
"set preserveindent
"set softtabstop=0
set expandtab
set shiftwidth=2
set tabstop=2

set foldmethod=syntax
"set foldmethod=indent

set incsearch
set nowrapscan

set noerrorbells
set novisualbell
set t_vb=

set hidden

"set smartindent

set fo+=cr

set nobackup
set noswapfile

set laststatus=2
"set rulerformat=%40(%f\ %m\ %r%)%=%l,%c\ %P

set sessionoptions=blank,buffers,curdir,folds,globals,help,localoptions,options,resize,tabpages,winsize,winpos

set wildmode=longest,list,full


" <F7> - toggle relative number
map <F7> :set invrelativenumber<CR>
imap <F7> <ESC>:set invrelativenumber<CR>a

" <F8> - toggle number
map <F8> :set invnu<CR>
imap <F8> <ESC>:set invnu<CR>a

" <F9> - make
map <F9> :w<CR>
vmap <F9> <ESC>:w<CR>
imap <F9> <ESC>:w<CR>a

" <F10> start perl "current file"
map <F10> :!perl "%"<CR>
vmap <F10> <ESC>:!perl "%"<CR>
imap <F10> <ESC>:!perl "%"<CR>

map <F11> :make! start<CR>
map <F12> :!./test.a<CR>

"imap [ []
"imap {<CR> {<CR>};<ESC>O

"imap "" "" <LEFT><LEFT>
"imap '' '' <LEFT><LEFT>

"function InsertTabWrapper()
"    let col = col('.') - 1
"    if !col || getline('.')[col - 1] !~ '\k'
"        return "\<tab>"
"    else
"        return "\<c-p>"
"    endif
"endfunction
"inoremap <tab> <c-r>=InsertTabWrapper()<cr>

set complete=""
set complete+=.
set complete+=k
set complete+=b
set complete+=t

set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0

inoremap <C-B> <C-X><C-O>
" set completeopt-=menu
" set completeopt-=menuone
set completeopt-=preview
set completeopt+=longest
set mps-=[:]

set fileencodings=utf-8,cp1251,koi8-r,cp866

"set list # view all symbols as 'tab'


nmap h <C-W><C-h>
nmap j <C-W><C-j>
nmap k <C-W><C-k>
nmap l <C-W><C-l>


nmap c :.s/^/# /g<CR>:noh<CR>
nmap v :.s/^# //g<CR>:noh<CR>

vmap c :s/^/# /g<CR>:noh<CR>
vmap v :s/^# //g<CR>:noh<CR>


"remove spaces on open
"autocmd BufRead * silent! %s/\s\+$//

autocmd FileType perl compiler perl
autocmd FileType perl imap {<CR> {<CR>}<ESC>O
"autocmd FileType perl set foldmethod=indent


"autocmd FileType python setlocal noexpandtab
autocmd FileType python setlocal tabstop=4
autocmd FileType python setlocal shiftwidth=4
autocmd FileType python setlocal softtabstop=0
" autocmd FileType python setlocal list
" autocmd FileType python setlocal listchars=tab:→·
autocmd FileType python setlocal foldmethod=indent

autocmd FileType xml set foldmethod=indent

autocmd FileType vim nmap c :.s/^/" /g<CR>:noh<CR>
autocmd FileType vim nmap v :.s/^" //g<CR>:noh<CR>

autocmd FileType vim vmap c :.s/^/" /g<CR>:noh<CR>
autocmd FileType vim vmap v :.s/^" //g<CR>:noh<CR>


autocmd FileType c,cpp setlocal noexpandtab
autocmd FileType c,cpp setlocal list
autocmd FileType c,cpp setlocal listchars=tab:→·
autocmd FileType c,cpp setlocal foldmethod=syntax
autocmd FileType c,cpp setlocal cindent
autocmd FileType c,cpp setlocal cinoptions=(0,u0,U0

autocmd FileType c,cpp nmap c :.s;^;//;g<CR>:noh<CR>
autocmd FileType c,cpp nmap v :.s;^//;;g<CR>:noh<CR>

autocmd FileType c,cpp vmap c :s;^;//;g<CR>:noh<CR>
autocmd FileType c,cpp vmap v :s;^//;;g<CR>:noh<CR>

autocmd FileType c,cpp imap {<CR> {<CR>}<ESC>O

autocmd FileType c,cpp ab #i #include
autocmd FileType c,cpp ab #d #define

autocmd FileType c,cpp ab or \|\|
autocmd FileType c,cpp ab and &&
autocmd FileType c,cpp ab not !

autocmd FileType c,cpp map <F9> :w\|make! -j5<cr>
autocmd FileType c,cpp vmap <F9> <ESC>:w\|make! -j5<cr>
autocmd FileType c,cpp imap <F9> <ESC>:w\|make! -j5<cr>



" Go
autocmd FileType go nmap c :s;^;//;g<CR>:noh<CR>
autocmd FileType go nmap v :s;^\s*//;;g<CR>:noh<CR>
autocmd FileType go vmap c :s;^;//;g<CR>:noh<CR>
autocmd FileType go vmap v :s;^\s*//;;g<CR>:noh<CR>

autocmd FileType go map <F9> :w\|GoRun "%"<CR>
autocmd FileType go vmap <F9> <ESC>:w\|GoRun "%"<CR>
autocmd FileType go imap <F9> <ESC>:w\|GoRun "%"<CR>

autocmd FileType go map  <F10> :w\|GoBuild "%"<CR>
autocmd FileType go vmap <F10> <ESC>:w\|GoBuild "%"<CR>
autocmd FileType go imap <F10> <ESC>:w\|GoBuild "%"<CR>

autocmd FileType go imap <C-@> <C-x><C-o>
autocmd FileType go nmap <Leader>i <Plug>(go-info)
autocmd FileType go nmap <Leader>dt <Plug>(go-def-tab)
autocmd FileType go nmap <Leader>s <Plug>(go-implements)

" Java
autocmd FileType java map <F12> :make! start<CR>

"autocmd FileType html setlocal expandtab

"autocmd BufNewFile,BufRead *.pl compiler perl
"autocmd BufNewFile,BufRead *.pl set shiftwidth=4
"autocmd BufNewFile,BufRead *.pl set softtabstop=4
"autocmd BufNewFile,BufRead *.pl set tabstop=4
"
"autocmd BufNewFile,BufRead *.bla source bla.vim
"autocmd BufNewFile,BufRead *.ta source ta.vim

" tander-dependent
" set path+=~/w_projects/libcorp/include
" au BufNewFile,BufRead ~/.salepoint/*.log setf tanderlog
" au BufNewFile,BufRead /var/log/salepoint/*.log setf tanderlog
" au BufNewFile,BufRead ~/tmp/logs/*.log setf tanderlog

"vmap <tab> >gv
"vmap <s-tab> <gv
"set tags+=./tags
"map <S-y> :!ctags -R --sort=1 --c++-kinds=+p --fields=+iaS --extra=+q . <cr><cr>

" function! DelTagOfFile(file)
" 	let fullpath = a:file
" 	let cwd = getcwd()
" 	let tagfilename = cwd . "/tags"
" 	let f = substitute(fullpath, cwd . "/", "", "")
" 	let f = escape(f, './')
" 	let cmd = 'sed -i "/' . f . '/d" "' . tagfilename . '"'
" 	let resp = system(cmd)
" endfunction

" function! UpdateTags()
" 	let f = expand("%:p")
" 	let cwd = getcwd()
" 	let tagfilename = cwd . "/tags"
" 	let cmd = 'ctags -a -f ' . tagfilename .
" 		\ ' --c++-kinds=+p --fields=+iaS --extra=+q ' . '"' . f . '"'
" 	call DelTagOfFile(f)
" 	let resp = system(cmd)
" endfunction

"omni completeons cpp
"autocmd BufWritePost *.cpp,*.h,*.c,*.cc call UpdateTags()
" set completeopt=menuone,menu,longest
"au FileType cpp set tags+=~/.vim/tags/cpp


" let g:Favcolorschemes = ["darkblue", "morning", "shine", "evening"]
" function SetTimeOfDayColors()
"   let g:CurrentHour = (strftime("%H") + 0) / 6
"
"   if g:colors_name !~ g:Favcolorschemes[ g:CurrentHour ]
"     execute "colorscheme " . g:Favcolorschemes[ g:CurrentHour ]
"     redraw
"   endif
" endfunction

" set statusline +=\ %{SetTimeOfDayColors()}
" call SetTimeOfDayColors()


" execute pathogen#infect()

" command PluginUpdate
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'fatih/vim-go'
Plugin 'majutsushi/tagbar'
Plugin 'altercation/vim-colors-solarized'
Plugin 'dpc/vim-smarttabs'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'davidhalter/jedi-vim'
" Plugin 'vim-scripts/L9'
" Plugin 'vim-scripts/FuzzyFinder'
" Plugin 'SkidanovAlex/CtrlK'

call vundle#end()
filetype plugin indent on

if &t_Co >= 256
"   colo desert256
  set background=light
  let g:solarized_termcolors=256
  let g:solarized_visibility="low"
"   let g:solarized_termtrans =1
  colo solarized

else
  colo blue

endif


" vim-cpp-enhanced-highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_concepts_highlight = 1


" fatih/vim-go
let g:go_fmt_autosave = 1


" let g:jedi#completions_enabled = 0

let g:clang_complete_auto=0


let g:ctrlk_clang_library_path="/usr/lib64"
nmap <F3> :call GetCtrlKState()<CR>
nmap <C-k> :call CtrlKNavigateSymbols()<CR>
nmap <F2> :call CtrlKGoToDefinition()<CR>
nmap <F5> :call CtrlKGetReferences()<CR>
