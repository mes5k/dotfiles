" tabs as spaces
set autoindent
set autowrite
set showmatch
set wrapmargin=0
set report=1
set ts=4
set nobackup
set ignorecase
set smartcase
set nocp
set expandtab
set hlsearch

:filetype indent off

" for when you accidentally type :W or :WQ or :Q
:cmap W w
:cmap Q q

":colorscheme solarized
":colorscheme github
":colorscheme desert
":colorscheme default
":colorscheme peachbuff
":colorscheme shine
":colorscheme zellner

" Show trailing whitepace
:highlight ExtraWhitespace ctermbg=green guibg=green
:match ExtraWhitespace /\s\+$/

" Show tab characters
:highlight Tabs ctermbg=187 guibg=187
:2match Tabs /\t/

"" This is OK where line length really matters, but obscures other highlights.
"" Show characters beyond 95 width limit
":highlight OverLength ctermbg=lightgrey guibg=lightgrey
":call matchadd('OverLength', '\%>95v.\+')

" turns showmatch off
let loaded_matchparen = 1

" for mac color syntax
:syntax on

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" preserve <tab> in makefiles
autocmd FileType make set noexpandtab

" highlights carriage returns (\r) as ^M at end of line
set fileformats=unix

" load vim plugins with pathogen
execute pathogen#infect()

" Highlight nextflow files as groovy
au BufNewFile,BufRead *.nf set filetype=groovy

" Highlight Jenkinsfile files as groovy
au BufNewFile,BufRead Jenkinsfile set filetype=groovy

" Highlight json files as javascript
au BufNewFile,BufRead *.json set filetype=javascript

" Highlight cromwell conf files as wdl
au BufNewFile,BufRead *.conf set filetype=wdl

" Highlight Vagrantfile files as ruby
au BufNewFile,BufRead Vagrantfile set filetype=ruby

" see Linux Security Cookbook 7.24, pg 170 for details
augroup encrypted
	au!
	autocmd BufReadPre,FileReadPre	*.gpg,*.asc set viminfo=
	autocmd BufReadPre,FileReadPre	*.gpg,*.asc set noswapfile 
	autocmd BufReadPre,FileReadPre	*.gpg set bin 
	autocmd BufReadPre,FileReadPre	*.gpg,*.asc let ch_save = &ch|set ch=2 
	autocmd BufReadPost,FileReadPost	*.gpg,*.asc 
				\ '[,']!sh -c 'gpg --decrypt 2> /dev/null' 
	autocmd BufReadPost,FileReadPost	*.gpg set nobin 
	autocmd BufReadPost,FileReadPost	*.gpg,*.asc 
				\ let &ch = ch_save|unlet ch_save
	autocmd BufReadPost,FileReadPost	*.gpg,*.asc 
				\ execute ":doautocmd BufReadPost " . expand("%:r")
	autocmd BufWritePre,FileWritePre	*.gpg 
				\ '[,']!sh -c 'gpg --default-recipient-self -e 2>/dev/null'
	autocmd BufWritePre,FileWritePre	*.asc 
				\ '[,']!sh -c 'gpg --default-recipient-self -e -a 2>/dev/null'
	autocmd BufWritePost,FileWritePost	*.gpg,*.asc u
augroup END

