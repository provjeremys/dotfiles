execute pathogen#infect()
syntax enable 
set shell=zsh           " bring ZShell config in
let mapleader=","       " leader is comma
colorscheme badwolf     " try it out

" highlights characterse over 80 width
set cc=120

set showcmd             " Will display the command as it is typed
set tabstop=2           " number of visual spaces per TAB
set softtabstop=2       " number of spaces in tab when editing
set shiftwidth=2        " size of an "indent
set expandtab           " tabs are spaces
set smarttab            " find next tabstop and insert spaces until it
set number              " show line numbers
set cursorline          " highlight current line
set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw only when we need to.
set showmatch           " highlight matching [{()}]
set incsearch           " search as characters are entered
set ignorecase          " ignore case in search, use \C to enable
set smartcase           " if you use upper-case, turn on Case Sensitive
set hlsearch            " highlight matches
set foldlevelstart=10   " open most folds by default
set foldmethod=indent   " Auto-define folds by indentation
set spelllang=en        " English for spelling!
set splitbelow          " Open new split windows UNDER current window
set splitright          " Open new vsplit windows RIGHT of current window
set switchbuf=split, open
set backspace=2         " Same as indent, eol, start, allows backspace essentially anywhere in insert mode
set modeline            " Allows files to define some variables (e.g., filetype)
" New, better words!
set spellfile=$HOME/dotfiles/en.utf-8.add
" enables Leader + y to do clipboard copy in visual mode
vnoremap <silent> <leader>y :<CR>:let @a=@" \| execute "normal! vgvy" \| let res=system("pbcopy", @") \| let @"=@a<CR> 
" enables Leader + h to set vim pwd on local buffer
nnoremap <silent> <leader>h :lcd %:p:h<CR>
" enables Leader + d to diff current file buffer
nnoremap <silent> <leader>d :DiffChangesDiffToggle<CR>
" enables Leader + D to diff all current windows
nnoremap <silent> <leader>D :windo diffthis<CR>

filetype indent on      " load filetype-specific indent files
" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" Alt+j/k add lines below/above
nnoremap <silent><A-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><A-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>

" Remove trailing whitespace from file
nnoremap <silent> <leader>ws :%s/\s\+$//g<CR>

" Take the jest coverage and convert it to PR format
let @c='kkBt|jjdET|jjd'

" Take a row from postgres with headers and make an insert sequelize line
let @v='I|jk:s/\v\s+\|/|/g:s/\v\|\s+/|/g:s/\v\|([^\|]*)/''\1'', /g::silent! s/\v''''/NULL/gExxa)jk'
let @p='OAOAI|jk:s/\v\s+\|/|/g:s/\v\|\s+/|/g:s/\v\|([^\|]*)/\1, /gI(jkExxa) VALUES (jkOBdd@vOAEJx'

" move to beginning/end of line
noremap B ^
noremap E $

" $/^ doesn't do anything
noremap $ <nop>
noremap ^ <nop>

" move between windows sanely
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>
nnoremap <silent> > :exec "vertical resize +1"<CR>
nnoremap <silent> < :exec "vertical resize -1"<CR>
nnoremap <silent> + :exec "resize +1"<CR>
nnoremap <silent> - :exec "resize -1"<CR>
nmap <silent> H gT
nmap <silent> L gt

" highlight last inserted text
nnoremap gV `[v`]
" jk is escape
inoremap jk <esc>
" Show count of last find
nnoremap <leader>/ :%s///gn<CR>
" Super-undo
nnoremap <leader>u :GundoToggle<CR>
" open ag.vim: Close window with :ccl(ose)
nnoremap <leader>a :Ag! 
" Z for Vim!
nnoremap <leader>z :Z 
" edit vimrc/zshrc and load vimrc bindings
nnoremap <leader>ev :tabnew $MYVIMRC<CR>
nnoremap <silent> <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>ez :tabnew ~/.zshrc<CR>
nnoremap <leader>ee :tabnew ~/.zshenv<CR>
nnoremap <leader>ej :tabnew ~/.jira.d/config.yml<CR>
nnoremap <leader>ed :tabnew ~/dotfiles<CR>

" CtrlP settings
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

" File-type specific settings
autocmd Filetype javascript setlocal ts=4 sw=2 sts=0 suffixesadd=.js,.jsx
autocmd Filetype typescript setlocal ts=4 sw=4 sts=0 suffixesadd=.ts,.tsx
autocmd Filetype typescript,javascript highlight OverLength ctermbg=red ctermfg=white guibg=#592929
autocmd Filetype typescript,javascript match OverLength /\%121v.\+/
autocmd Filetype markdown setlocal spell
autocmd Filetype text setlocal linebreak spell

" Jira green text
map <silent> <leader>jg :setlocal indentkeys-=<:><CR>a{color:#14892c}{color}jk7h:setlocal indentkeys+=<:><CR>a
map <silent> <leader>jr :setlocal indentkeys-=<:><CR>a{color:#d04437}{color}jk7h:setlocal indentkeys+=<:><CR>a
map <silent> <leader>jo :setlocal indentkeys-=<:><CR>a{color:#f79232}{color}jk7h:setlocal indentkeys+=<:><CR>a

