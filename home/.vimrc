" reset to vim-defaults
if &compatible          " only if not set before:
  set nocompatible      " use vim-defaults instead of vi-defaults (easier, more user friendly)
endif


" display settings
set background=dark     " enable for dark terminals
set nowrap              " don't wrap lines
set scrolloff=2         " 2 lines above/below cursor when scrolling
set number              " show line numbers
set showmatch           " show matching bracket (briefly jump)
set showmode            " show mode in status bar (insert/replace/...)
set showcmd             " show typed command in status bar
set ruler               " show cursor position in status bar
set title               " show file in titlebar
set wildmenu            " completion with menu
"set wildmode=longest,list " bash-like tab completion
"set laststatus=2          " use 2 lines for the status bar


" editor settings
set esckeys             " map missed escape sequences (enables keypad keys)
set ignorecase          " first enable ignore case for searching
set smartcase           " then enable smart case (case-sensetive if you use uppercase characters)
set smartindent         " smart auto indenting
set smarttab            " smart tab handling for indenting
set magic               " change the way backslashes are used in search patterns
set bs=indent,eol,start " Allow backspacing over everything in insert mode

set tabstop=4           " number of spaces a tab counts for
set shiftwidth=4        " spaces for autoindents
"set expandtab           " turn a tabs into spaces


set fileformat=unix     " file mode is unix
set fileformats=unix    " only detect unix file format, displays that ^M with dos files

set viminfo='20,\"500   " read/write a .viminfo file -- 20 jump links, regs up to 500 lines
set history=50          " keep 50 lines of command history

"set swapsync=sync       " the swap is synced with sync, not fsync
"set updatecount=20      " Number of characters typed before doing an update
"set updatetime=500      " Number of milliseconds before doing an update

"set confirm             " get a dialog when :q, :w, or :wq fails


" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.class


" Disable the annoying Ex mode, use Q for formatting
map Q gq


" paste mode toggle
map <F10> :set paste<CR>
map <F11> :set nopaste<CR>
imap <F10> <C-O>:set paste<CR>
imap <F11> <nop>
set pastetoggle=<F11>


" " if you paste and the indentation gets fscked just press C-A:
" inoremap <silent> <C-a> <ESC>u:set paste<CR>.:set nopaste<CR>gi

" " Map F2 to comment the selected lines in visual mode (// style comments)
" vmap <F2> :s/^/\/\/\ /g <CR> :noh <CR>

" " Map F3 to uncomment the selected lines in visual mode
" vmap <F3> :s/^\/\/\ //g <CR> :noh <CR>

" " Map F4 to open a taglist window -- requires the taglist plugin
" nnoremap <silent> <F4> :Tlist<CR>

" " Map F5 to insert an header at the top of the file. 
" map <F5> :0r !~/.templates/header.sh <CR>


" console menu
source $VIMRUNTIME/menu.vim
set cpo-=<
set wcm=<C-Z>
map <F4> :emenu <C-Z>


" XXX forcing terminal colors
set t_Co=256


" color settings (if terminal/gui supports it)
if &t_Co > 2 || has("gui_running")
  syntax on          " enable colors
  colorscheme ir_black
  set hlsearch       " highlight search
  set incsearch      " search incremently
endif


" vimspell plugin settings
"let loaded_vimspell = 0 
let spell_insert_mode = 0
let spell_language_list = "english"
let spell_auto_type = "tex,mail,text,html,sgml,otl,cvs,none"
map <F7> :SpellCheck <CR>


filetype plugin on
" filetype indent on

" Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'


" file type specific settings
if has("autocmd")

  " For debugging
  "set verbose=9

  let zsh_is_sh=1

  " change to directory of current file automatically
  autocmd BufEnter * lcd %:p:h

  autocmd FileType c,cc,cpp,slang set cindent

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vdboor
    au BufReadPre,BufNewFile
    \ *.xsl,*.xml,*.css,*.html,*.js,*.php,*.sql,*.sh,*.conf,*.cc,*.cpp,*.h
    \  set smartindent shiftwidth=2 softtabstop=2 expandtab

    au BufReadPre,BufNewFile
    \ *.tex
    \ set wrap shiftwidth=2 softtabstop=2 expandtab
  augroup END

  augroup gap 
  	au BufReadPre,BufNewFile *.gap set filetype=gap 
  augroup END

  augroup markdown
  	au BufReadPre,BufNewFile *.md set filetype=markdown
  augroup END

  augroup perl
    " reset (disable previous 'augroup perl' settings)
    au!  

    au BufReadPre,BufNewFile
    \ *.pl,*.pm
    \ set formatoptions=croq smartindent shiftwidth=2 softtabstop=2 cindent cinkeys='0{,0},!^F,o,O,e' " tags=./tags,tags,~/devel/tags,~/devel/C
    " formatoption:
    "   t - wrap text using textwidth
    "   c - wrap comments using textwidth (and auto insert comment leader)
    "   r - auto insert comment leader when pressing <return> in insert mode
    "   o - auto insert comment leader when pressing 'o' or 'O'.
    "   q - allow formatting of comments with "gq"
    "   a - auto formatting for paragraphs
    "   n - auto wrap numbered lists
    "   
  augroup END

  " Always jump to the last known cursor position. 
  " Don't do it when the position is invalid or when inside
  " an event handler (happens when dropping a file on gvim). 
  autocmd BufReadPost * 
    \ if line("'\"") > 0 && line("'\"") <= line("$") | 
    \   exe "normal g`\"" | 
    \ endif 
    
endif 

set nomodeline   " disable the magic "vim: .." lines in files
