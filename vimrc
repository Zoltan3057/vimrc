runtime! debian.vim

filetype plugin indent on							" Apply different indent

"
set nocompatible
set number
set relativenumber
set showcmd											" Show (partial) command in status line.
set cursorline
set autoindent
set autowrite										" automatically save before commands like :next and :make
set hidden											" Hide buffers when they are abandoned

" leader键设置 {{{
inoremap jk <ESC>
let mapleader = " "
nmap <bslash> <space>
nnoremap <leader>d dd
nnoremap <leader>ev :vsplit $MYVIMRC<cr>			" Edit my vimrc file
nnoremap <leader>sv :source $MYVIMRC<cr>			" Source my vimrc file
" }}}

" General {{{

" --- mouse {{{
" set mouse=a
" }}}

" --- *.vim 文件读取设置{{{
augroup filetype_vim
		autocmd!
		autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" --- 文件保存功能 {{{
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
" Fast saving
let g:auto_save = 1
let g:auto_save_slient = 1
let g:auto_save_events = ["InsertLeave", "TextChanged"]
nmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
" command W w !sudo tee % > /dev/null

" Set to auto read when a file is changed from the outside
set autoread

" save undo to files
" Notice: clear vimundo
set undofile
set undodir=/home/mario/tmp/.vimundo/
" }}}

" --- wildMenu 设置 {{{
" Turn on the Wild menu (输入:命令时tab补全功能)
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
" }}}

" --- 搜索设置 {{{
"
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
" map <space> /
" map <space> ?

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Disable highlight when <leader><cr> is pressed
" nnoremap <silent> <leader>q :noh<cr>
" }}}

" --- Files, backups and undo {{{
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile
" }}}

" --- *#键搜索 {{{
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>
"}}}

" buffer and tabs 设置 {{{

"" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set tabstop=4
set shiftwidth=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Close the current buffer
" map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
" map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" map <leader>t<leader> :tabnext
" " Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 2
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
set switchbuf=useopen,usetab,newtab
set stal=2
" }}}

" windows {{{

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" map %% to current fold path
" noremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
" }}}

" Status line {{{
" Always show the status line
set laststatus=2

" Format the status line
" set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c
" }}}

" Spell checking {{{
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=
" }}}

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" No annoying sound on errors
" set noerrorbells
" set novisualbell
" set t_vb=
" set tm=500

" Add a bit extra margin to the left
set foldcolumn=1

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>
" }}}

" html 设置{{{
" autocmd BufWritePre,BufRead *.html :normal gg=G   " 自动对齐
" }}}

"  Python 文件设置 {{{

autocmd FileType python let @d = 'oimport pdbpdb.set_trace()'
autocmd FileType python let @m = 'A # [Mario]'
autocmd FileType python let @n = 'o# [Mario]'

"au BufNewFile,BufRead *.py  " au: autocmd
"    \ set tabstop=4         "tab宽度
"    \ set softtabstop=4
"    \ set shiftwidth=4
"    \ set textwidth=79      "行最大宽度
"    \ set expandtab         "tab替换为空格键
"    \ set autoindent        "自动缩进
"    \ set fileformat=unix   "保存文件格式
" }}}

" F5运行程序 {{{
"
"
" --------------- old ----------------
" map <F5> :call CompileRunGcc()<CR>
" func! CompileRunGcc()
"     exec "w"
"     exec '!echo ======== Mario Test ========'
"     if &filetype == 'c'
"         exec '!g++ % -o %<'
"         exec '!time ./%<'
"     elseif &filetype == 'cpp'
"         exec '!g++ % -o %<'
"         exec '!time ./%<'
"     elseif &filetype == 'python'
"         "exec '!time python %'
"         exec '!python %'
"     elseif &filetype == 'sh'
"         :!time bash %
"     endif
"     exec '!echo ======== End ========'
" endfunc
" --------------- old ----------------
"
let g:asyncrun_open = 6
let g:asyncrun_bell = 1
nnoremap <F7> :call asyncrun#quickfix_toggle(6)<cr>
autocmd filetype c nnoremap <silent> <F8> :AsyncRun g++ -w "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
autocmd filetype c nnoremap <silent> <F5> :AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
autocmd filetype python nnoremap <silent> <F5> :AsyncRun -raw python % <cr>

"
" }}}

" Colors and Fonts {{{

" Enable syntax highlighting
syntax enable

" Enable 256 colors palette in Gnome Terminal
" if $COLORTERM == 'gnome-terminal'
"     set t_Co=256
" endif


" colorscheme desert
" set background=dark
let base16colorspace=256
" set termguicolors

" Set extra options when running in GUI mode
" if has("gui_running")
"     set guioptions-=T
"     set guioptions-=e
"     set t_Co=256
"     set guitablabel=%M\ %t
" endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=UTF-8
set fileencodings=utf-8,gb2312,gbk,gb18030

" Use Unix as the standard file type
set ffs=unix,dos,mac
" }}}

" 文件头增加注释 {{{
" 使用F4键调用函数AddAuthor
" map <F4> ms:call AddAuthor()<cr>
"
" function AddAuthor()
"     let n=1
"     while n < 11
"         let line = getline(n)
"         if line=~'[#]*\s*\*\s*\S*Last\s*modified\s*:\s*\S*.*$'
"         call UpdateTitle()
"         return
"     endif
"     let n = n + 1
"     endwhile
"     if &filetype == 'sh'
"         call AddTitleForShell()
"     elseif &filetype == 'python'
"         call AddTitleForPython()
"     else
"         call AddTitleForC()
"     endif
"
" endfunction

"" 表示非.sh或.py结尾的文件添加此函数注释
" function AddTitleForC()
"     call append(0,"/***********************************************************************")
"     call append(1," *")
"     call append(2," * Mario Created on   : ".strftime("%Y-%m-%d %H:%M"))
"     call append(3," * Filename      : ".expand("%:t"))
"     call append(4," * Function      : ")
"     call append(5," *")
"     call append(6," *************************************************************************/")
"     call append(7,"")
" endfunction
"
" "" 表示.py添加此函数注释
" function AddTitleForPython()
"     call append(0,"#!/usr/bin/env python")
"     call append(1,"# coding:utf-8")
"     call append(2,"")
"     call append(3,"# **********************************************************")
"     call append(4,"# * Author        : Mario")
" "    call append(5,"# * Email         : ")
" "    call append(6,"# * Create time   : ".strftime("%Y-%m-%d %H:%M"))
"     call append(7,"# * Last modified : ".strftime("%Y-%m-%d %H:%M"))
"     call append(8,"# * Filename      : ".expand("%:t"))
"     call append(9,"# * Description   : ")
"     call append(10,"# **********************************************************")
"     echohl WarningMsg | echo "Successful in adding the copyright." | echohl None
" endfunction
"
" "" 表示.sh文件添加此行数注释
" function AddTitleForShell()
"     call append(0,"#!/bin/bash")
"     call append(1,"# **********************************************************")
"     call append(2,"# * Author        : pengyongshi")
"     call append(3,"# * Email         : 58217892@qq.com")
"     call append(4,"# * Create time   : ".strftime("%Y-%m-%d %H:%M"))
"     call append(5,"# * Last modified : ".strftime("%Y-%m-%d %H:%M"))
"     call append(6,"# * Filename      : ".expand("%:t"))
"     call append(7,"# * Description   : ")
"     call append(8,"# **********************************************************")
" endfunction
"  }}}

" vim-plug {{{

" +++ plug列表 {{{
call plug#begin('~/.vim/plug')

Plug 'mhinz/vim-startify'                               " startup           初始界面
Plug 'vim-scripts/The-NERD-tree'                        " nerd-tree         文件目录结构
Plug 'Xuyuanp/nerdtree-git-plugin'                      " nerd-tree-git
Plug 'majutsushi/tagbar'                                " tagbar            文件结构
Plug 'ntpeters/vim-better-whitespace'                   " whitespace        冗余空格去除
Plug 'christoomey/vim-tmux-navigator'                   " vimux             窗口移动
Plug 'tpope/vim-commentary'                             " gcc               注释功能
Plug 'chriskempson/base16-vim'                          " themes
Plug 'terryma/vim-multiple-cursors'                     " c-n               多光标功能
Plug 'vim-scripts/DoxygenToolkit.vim'                   " :Dox              Doxygen注释功能(:Dox)
Plug 'itchyny/lightline.vim'                            " lightline
Plug 'tpope/vim-surround'                               " ds,cs,ys(s)       更改surrounding
Plug 'kien/ctrlp.vim'                                   " c-p               正则表达式打开文件(c-p)
Plug 'nathanaelkane/vim-indent-guides'                  "                   缩进显示
Plug 'fholgado/minibufexpl.vim'                         " minibufexpl       缓冲工具
Plug 'easymotion/vim-easymotion'                        " asymotion         移动工具
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
                                                        " PythonMode        {P}包括pylint, rope, pydoc
Plug 'davidhalter/jedi-vim', {'for': 'python', 'branch': 'develop' }
                                                        " JEDI              python 补全工具
Plug 'tpope/vim-fugitive'                               "                   {P}GIT 功能
Plug 'airblade/vim-gitgutter'
Plug 'idanarye/vim-merginal'
Plug 'skywind3000/asyncrun.vim'
Plug 'elzr/vim-json'
Plug '907th/vim-auto-save'                              "                   vim automatic saving

Plug 'godlygeek/tabular', {'for': 'md'}                 "                   Line up text
Plug 'gu-fan/riv.vim'                    "                   Markdown and reStructuredText

" Plug 'benmills/vimux'                                   " vimux             融合tmux
" Plug 'plasticboy/vim-markdowm', {'for':'md'}            "                   Markdown Preview
" Plug 'MikeCoder/markdown-preview.vim'                   "                   Markdown Preview
" Plug 'Valloric/YouCompleteMe',{'for':['c','cpp']}       " YCM               c++ 补全工具
" Plug 'SirVer/ultisnips'                                 " TODO              全代码块补全
" Plug 'tpope/vim-rails'                                  "                   针对RubyOnRails代码
" Plug 'suan/vim-instant-markdown'                        "                   markdown书写功能
" Plug 'godlygeek/tabular'                                " tabular           对齐工具
" Plug 'universal-ctags/ctags'
" Plug 'w0rp/ale'                                         " 需要vim8支持
" Plug 'scrooloose/syntastic'
" Plug 'scrooloose/nerdcommenter'
" Plug 'Raimondi/delimitMate'
" Plug 'octol/vim-cpp-enhanced-highlight'
" Plug 'junegunn/goyo.vim'					              " Hyperfocus-writing in VIM
" Plug 'nathanaelkane/vim-indent-guides'		          " Visually displaying indent levels in VIM
" Plug 'plasticboy/vim-markdown'
" Plug 'yianwillis/vimcdoc'
" Plug 'klen/python-mode'
" Plug 'ryanoasis/vim-devicons'
" Plug 'vim-airline/vim-airline'                          " airline           底行辅助功能  --->lightline
"  junegunn/fzf


call plug#end()

" }}}

" --- lightline <--- Airline setting {{{
let g:lightline = {'colorscheme': 'one',}
" let g:airline_powerline_fonts=1
" let g:airline#extensions#tabline#enabled=1
" let g:airline#extensions#tabline#buffer_nr_show=1
" let g:airline#extensions#tabline#left_sep=''
" let g:airline#extensions#tabline#left_alt_sep=''
" nnoremap [b :bp<CR>
" nnoremap ]b :bn<CR>
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
" }}}

" --- YouCompleteMe {{{
let g:ycm_global_ycm_extra_conf='~/.vim/plug/YouCompleteMe/third_party/ycmd/examples/.ycm_extra_conf.py'
let g:ycm_seed_identifiers_with_syntax = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_confirm_extra_conf = 1
let g:ycm_key_invoke_completion = '<C-a>'
set completeopt=longest,menu
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
" }}}

" --- ctags {{{
set tags+=../tags
set tags+=~/opencv/opencv/tags          " 增加opencv跳转
" }}}

" --- vimux {{{
map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vq :VimuxCloseRunner<CR>
" map <Leader>vm :VimuxPromptCommand("make ")<CR>
" map <Leader>rb :call VimuxRunCommand("clear; rspec " . bufname("%"))<CR>
" map <Leader>rq :call VimuxRunCommand("clear; rspec " . bufname("%"), 0)<CR>
"  }}}

" --- base16{{{
colorscheme base16-atelier-dune
"}}}

" --- vim-easymotion{{{
map  f <Plug>(easymotion-bd-f)
nmap f <Plug>(easymotion-overwin-f)
" s{char}{char} to move to {char}{char}
" nmap s <Plug>(easymotion-overwin-f2)
" Move to line
" map <Leader>l <Plug>(easymotion-bd-jk)
" nmap <Leader>l <Plug>(easymotion-overwin-line)
" Move to word
" map  <Leader>w <Plug>(easymotion-bd-w)
" nmap <Leader>w <Plug>(easymotion-overwin-w)
"  }}}

" --- vim-commentary{{{
"  TODO
" nnoremap <C-_> gcc
"}}}

" --- miniBuf {{{
let g:miniBufExplBRSplit = 1
" noremap <C-TAB>   :MBEbn<CR>
" noremap <C-S-TAB> :MBEbp<CR>
noremap <Leader>t :MBEToggle<cr>
let g:miniBufExplBRSplit = 0   " Put new window above
" let g:miniBufExplVSplit = 30   " column width in chars
" MRU fasion ???
"noremap <C-TAB>   :MBEbf<CR>
"noremap <C-S-TAB> :MBEbb<CR>
"
"  }}}

" --- ctrlP {{{
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
    \ }
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=6
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1

"  }}}

" --- ale {{{
" let g:ale_linters_explicit = 1
" let g:ale_completion_delay = 500
" let g:ale_echo_delay = 20
" let g:ale_lint_delay = 500
" let g:ale_echo_msg_format = '[%linter%] %code: %%s'
" let g:ale_lint_on_text_changed = 'normal'
" let g:ale_lint_on_insert_leave = 1
" let g:airline#extensions#ale#enabled = 1
" " let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
" let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
" " let g:ale_c_cppcheck_options = ''
" let g:ale_cpp_cppcheck_options = ''
" }}}

" --- tagbar {{{
nnoremap <silent> <F9> :TagbarToggle<CR>
let g:tagbar_width = 40
let g:tagbar_left = 1
" }}}

" --- nerd-tree {{{
let g:NERDTreeWinPos="left"
let g:NERDTreeShowLineNumbers=1
let g:NERDTreeShowHidden=1
let g:NERDTreeIgnore = ['\.pyc$', '__pycache__', '.git$[[dir]]', '.idea$[[dir]]']
let g:NERDTreeWinSize = 40
let g:NERDTreeShowBookmarks = 1
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>
map <leader>nB :Bookmark<Space>
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "*",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

"autocmd vimenter * NERDTree
" }}}

" --- vim-instant-markdown {{{
let g:instant_markdown_autostart = 0
let g:instant_markdown_open_to_the_world = 0
let g:instant_markdown_allow_unsafe_content = 0
let g:instant_markdown_allow_external_content = 0
" }}}

" --- syntastic {{{
"设置error和warning的标志
let g:syntastic_enable_signs = 1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='►'
"总是打开Location List（相当于QuickFix）窗口，如果你发现syntastic因为与其他插件冲突而经常崩溃，将下面选项置0
let g:syntastic_always_populate_loc_list = 1
"自动打开Locaton List，默认值为2，表示发现错误时不自动打开，当修正以后没有再发现错误时自动关闭，置1表示自动打开自动关闭，0表示关闭自动打开和自动关闭，3表示自动打开，但不自动关闭
let g:syntastic_auto_loc_list = 1 "修改Locaton List窗口高度
let g:syntastic_loc_list_height = 5
"打开文件时自动进行检查
let g:syntastic_check_on_open = 1
"自动跳转到发现的第一个错误或警告处
let g:syntastic_auto_jump = 1
"进行实时检查，如果觉得卡顿，将下面的选项置为1
let g:syntastic_check_on_wq = 0
"高亮错误
let g:syntastic_enable_highlighting=1
"让syntastic支持C++11
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'

" cpplint extension
let g:syntastic_cpp_cpplint_exec = 'cpplint'
let g:syntastic_cpp_checkers = ['cpplint', 'gcc']
let g:syntastic_cpp_cpplint_thres = 1
let syntastic_aggregate_errors = 1

"  }}}

" --- cscope {{{
source /home/mario/.vim/cscope_maps.vim
"}}}

" --- jedi-vim {{{
" git clone --recursive https://github.com/davidhalter/jedi-vim.git ~/.vim/plug/jedi-vim
let g:jedi#completions_enabled = "<C-N>"
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#completions_enabled = 1
let g:jedi#show_call_signatures = 2
let g:jedi#smart_auto_mappings = 1
let g:jedi#use_splits_not_buffers = 'bottom'
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0
let g:jedi#documentation_command = ""
" }}}

" --- python-mode {{{
let g:pymode = 1
let g:pyindent = 1
let g:pymode_options = 1
let g:pymode_options_colorcolumn = 1
let g:pymode_motion = 1
let g:pymode_folding = 0
let g:pymode_virtualenv = 0
let g:pymode_breakpoint = 0

" run
let g:pymode_run = 0
" let g:pymode_run_bind = '<F5>'

" dot
let g:pymode_doc = 1
let g:pymode_doc_bind = 'K'

" lint
let g:pymode_lint = 1
let g:pymode_lint_on_fly = 0
let g:pymode_lint_on_write = 0
let g:pymode_lint_unmodified = 0
let g:pymode_lint_message = 1
let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe']
let g:pymode_lint_cwindow = 1

let g:pymode_rope = 0

"  }}}

" --- vim-better-whitespace {{{
let g:better_whitespace_ctermcolor='blue'
let g:strip_whitespace_on_save=1
"  }}}
"
" --- vim-indent-guide {{{
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level=1
let g:indent_guides_guide_size=1
"  }}}

" --- vim-markdown-preview {{{
let g:PluginDir = '/home/mario/.vim/plug/markdown-preview.vim'
"  }}}

"

"  }}}

" 快捷键 {{{
" ctrl+G 显示当前目录名
" zR     打开所有folds
" zM     关闭所有fold" space
" 空格已经映射到了"/"
" ss     will toggle and untoggle spell checking
" <leader>pp paste设置toggle
" gJ     将选中的行join（合并）
" c-n    查找，并选中（多cursor）
" :normal @a  execute macro in command
" ~     toggle between lower case letter and capital letter
" }}}

