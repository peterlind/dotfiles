scriptencoding utf-8
set encoding=utf-8
" We're running Vim, not Vi!
set nocompatible

" setup pathogen
call pathogen#infect()

"bling
"set background=dark
"colorscheme ir_black
"colorscheme solarized
colorscheme dracula
set gfn=Monaco:h12

set showmode
set number
set cursorline

" always diff vertical
set diffopt=vertical
" show matching parentheses
set showmatch

" use indents of 2 spaces, and have them copied down lines:
set shiftwidth=2
set shiftround
set expandtab
set autoindent
set ai sw=2 sts=2 et

syntax on             " Enable syntax highlighting
syntax enable         " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

"status bar
set laststatus=2
set statusline=\ %F%m%r%h\ %w\ \ Line:\ %l/%L:%c\ Filetype:\ %y\ Format:\ %{&ff}
"syntastic
set statusline+=\ %#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" make searches case-insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase

"jump to search term
set incsearch

"highlight
set hlsearch

" share buffer to osx clipboard
set clipboard=unnamed

" Settings for VimClojure
let vimclojure#HighlightBuiltins=1
let vimclojure#ParenRainbow=1

" Easier use of Command-T (see http://vim.wikia.com/wiki/Mapping_keys_in_Vim_-_Tutorial_(Part_3))
let mapleader = ","

" make sure to specify a default
map <Leader>e :w! <bar> !ruby %<CR>

" NERDTree
map <Leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>
map <Leader>df :execute 'NERDTreeFind '<CR>
let NERDTreeShowHidden=1

map <Leader>t :execute 'CtrlP'<CR>

" format xml files (http://vim.wikia.com/wiki/Format_your_xml_document_using_xmllint)
map <leader>x :silent 1,$!xmllint --format --recover - 2>/dev/null<CR>

" typo stuff
cmap :W :w
cmap :Q :q

" Show unwanted whitespace
"set listchars=tab:-✈,trail:,extends:>
set listchars=tab:->,trail:,extends:>
set list!

"emacs stuff (only insert mode)
inoremap  <C-E> <End>
inoremap  <C-A> <Home>

" move to previous/next line
set whichwrap+=<,>,h,l,[,]

"remove highlighted search results
map <leader><leader> :noh<CR>

" MacVIM shift+arrow-keys behavior (required in .vimrc)
"let macvim_hig_shift_movement = 1

" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

if !exists("*s:CloseIfOnlyNerdTreeLeft")
  function s:CloseIfOnlyNerdTreeLeft()
    if exists("t:NERDTreeBufName")
      if bufwinnr(t:NERDTreeBufName) != -1
        if winnr("$") == 1
          q
        endif
      endif
    endif
  endfunction
endif
" json


autocmd BufRead,BufNewFile {*.md,*.mkd,*.markdown}    set ft=markdown
map <leader>j  <Esc>:%!json_pp<CR>
autocmd BufRead,BufNewFile {*.json}                   set ft=json
" filetype to make html.erb snippets work
" see
" http://stackoverflow.com/questions/4658737/vim-html-erb-snippets-snipmate-need-a-vim-tip
autocmd BufNewFile,BufRead {*.html.erb,*.erb} set filetype=eruby.html.rails

" python
autocmd BufNewFile,BufRead *.py setlocal shiftwidth=4
autocmd BufNewFile,BufRead *.py setlocal softtabstop=4

" java
autocmd BufNewFile,BufRead *.java setlocal shiftwidth=4
autocmd BufNewFile,BufRead *.java setlocal softtabstop=4


" fix <C-]> mapping
map <leader>f <C-]>
map <leader>g g]

" look in .git for tags
set tags=.git/tags

" use ripgrep
let g:ackprg = 'rg --column'

" from billskog
nmap <Leader>l O<Esc>"%pA:<C-R>=line(".")<CR><Esc>0d$"_ddu

" folding
set foldmethod=syntax
set foldlevel=10
nnoremap <space> za

"" lint js and jsx
"let g:syntastic_javascript_checkers = ['eslint']
"let g:syntastic_javascript_eslint_exe = '$(yarn bin)/eslint'
"
"" rubocop lint
"let g:syntastic_ruby_checkers = ['rubocop']
"
"let g:syntastic_scss_checkers = ['sass-lint']

" sanity
map ö :
map Ö :
command W w

runtime macros/matchit.vim

" fugitive Ggrep open quickfix
autocmd QuickFixCmdPost *grep* cwindow

command PathFull let @+ = expand("%:p")              " full path
nnoremap <leader>ff :PathFull<CR>|

command PathRel let @+ = expand("%")                 " relative path
nnoremap <leader>fr :PathRel<CR>|

command PathFilename let @+ = expand("%:t")          " just filename
nnoremap <leader>fn :PathName<CR>|

if has("gui_running")
  :source ~/.gvimrc
endif

set backupdir=/tmp//
set directory=/tmp//
set undodir=/tmp//

" prettier
" Running before saving, changing text or leaving insert mode
" when running at every change you may want to disable quickfix
" let g:prettier#quickfix_enabled = 0
let g:prettier#quickfix_auto_focus = 0
let g:prettier#autoformat = 0
augroup Prettier
  autocmd!
  autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
augroup  END
