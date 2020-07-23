" need system application
" 1.ctags (universal ctags)
" 2.pynvim(pip install pynvim)
" 3.the_silver_searcher (for fzf :Ag)
" 4.nerd fonts(github.com/ryanoasis/nerd-fonts)


" ===
" === auto load plug
" ===

if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ====================
" === Editor Setup ===
" ====================
" ===
" === System
" ===
"set clipboard=unnamedplus
let &t_ut=''
set autochdir


" ===
" === Editor behavior
" ===
set number
set relativenumber
set cursorline
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
" set list
" set listchars=tab:\|\ ,trail:▫
set scrolloff=4
set ttimeoutlen=0
set notimeout
set viewoptions=cursor,folds,slash,unix
set wrap
set textwidth=0
set indentexpr=
set foldmethod=indent
set foldlevel=99
" set foldenable     " zo for open zc for close,(zo,z0,zc,zC,za,zA,[z,]z,zj,zk
set formatoptions-=tc
set splitright
set splitbelow
"set noshowmode
set hlsearch
set showcmd
set wildmenu
set ignorecase
set smartcase
set shortmess+=c
" set inccommand=split
set completeopt=longest,noinsert,menuone,noselect,preview
set ttyfast
set lazyredraw    " don't redraw implement macro
set novisualbell
set laststatus=2
set encoding=UTF-8
silent !mkdir -p ~/.config/nvim/tmp/backup 
silent !mkdir -p ~/.config/nvim/tmp/undo
set backupdir=~/.config/nvim/tmp/backup,.
set directory=~/.config/nvim/tmp/backup,.
if has('persistent_undo')
    set undofile
    set undodir=~/.config/nvim/tmp/undo,.
endif
"set colorcolumn=100
"set updatetime=1000
set virtualedit=block
set mouse=a

" ctags
set tags=./.tags;,.tags    " don't forget renew ctags, don't use exuberant ctags, ** Univeral ctags ** instead.

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


" ===
" === Basic Mappings
" ===
" let mapleader="\"
" noremap ; :

" noremap ff <Esc>:w<CR>
" inoremap ff <Esc>:w<CR>

" rc
noremap <space>rc :e ~/.config/nvim/init.vim<CR>
" Indentation
nnoremap < <<
nnoremap > >>
" nohl
noremap <space><CR> :nohlsearch<CR>
"split
noremap sl :set splitright<CR>:vsp<space>
noremap sh :set nosplitright<CR>:vsp<space>
noremap sj :set splitbelow<CR>:split<space>
noremap su :set nosplitbelow<CR>:split<space>

" resplit
" noremap srh <C-w>t<C-w>H
" noremap srv <C-w>t<C-w>K
" noremap s<right> <C-w>b<C-w>H
" noremap s<down> <C-w>b<C-w>K

" resize
noremap <up> :res +5<CR>
noremap <down> :res -5<CR>
noremap <left> :vertical resize -5<CR>
noremap <right> :vertical resize +5<CR>

" command mode cursor movement
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>

" window focus
noremap <space>h <C-w>h
noremap <space>l <C-w>l
noremap <space>j <C-w>j
noremap <space>k <C-w>k

" tab focus
" noremap J :tabNext<CR>
" noremap K :tabprevious<CR>

" <++> placeholder
noremap <space><space> <Esc>/<++><CR>:nohlsearch<CR>c4l

" Call figlet
noremap tx :r !figlet<space>

noremap <space>s :%s//g<left><left>

" emacs key map in insert mode
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-a> <Esc>I
inoremap <C-e> <Esc>A

" move up/down without moving the curosr
noremap <C-u> 5<C-y>
noremap <C-d> 5<C-e>

noremap B :Buffer<CR>

" Compile function
noremap <f2> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!gcc % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		set splitbelow
		exec "!g++ -std=c++11 % -Wall -o %<"
		:sp
		:res -15
		:term ./%<
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
        set splitbelow
        :sp
		:term python3 %
	elseif &filetype == 'html'
		silent! exec "!".g:mkdp_browser." % &"
	elseif &filetype == 'markdown'
		exec "MarkdownPreview"
	elseif &filetype == 'tex'
		silent! exec "VimtexStop"
		silent! exec "VimtexCompile"
	elseif &filetype == 'javascript'
		set splitbelow
		:sp
		:term export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .
	elseif &filetype == 'go'
		set splitbelow
		:sp
		:term go run .
	endif
endfunc


call plug#begin('~/.config/nvim/plugged')
   

" General Highlighter
" hightlight the word under the cousor
Plug 'RRethy/vim-illuminate'
Plug 'ajmwagar/vim-deus'
Plug 'tomasiser/vim-code-dark'

" Status line
Plug 'liuchengxu/eleline.vim'

" File navigation
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
" don't get install the_silver_searcher to use :Ag to search string in text
Plug 'junegunn/fzf', { 'do':{ -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'    " change to project directory

" Git
Plug 'tpope/vim-fugitive'    " use Git command at Ex mode directory
Plug 'airblade/vim-gitgutter'    " display changes

" json
Plug 'elzr/vim-json'

" python
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins', 'for' :['python', 'vim-plug']}

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'mzlogin/vim-markdown-toc', { 'for': ['gitignore', 'markdown', 'vim-plug'] }    " :GenTocGFM/Redcarpet/GitLab/Marked
" Plug 'dkarter/bullets.vim'

" other
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'    " ysiw, ys, cs, ds
Plug 'gcmt/wildfire.vim'     "type <Enter> to visual i ''
Plug 'junegunn/vim-after-object'  " da= to delete what's after =
Plug 'godlygeek/tabular'  " Tabularize <regex> to align
" Plug 'easymotion/vim-easymotion'  " <leader><leader>w to jump to particular word  TODO 按键与wiki冲突
" Plug 'chrisbra/NrrwRgn'    " edit the selected region in a new window
Plug 'lambdalisue/suda.vim'    " 'w suda://%'   write with sudo mode
Plug 'junegunn/goyo.vim'    " :Goyo to turn on write mode
Plug 'ryanoasis/vim-devicons'    " icon  TODO
Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-speeddating'
Plug 'skywind3000/vim-terminal-help'


" tags
Plug 'ludovicchabant/vim-gutentags'  " generate ctags auto 


" asdf

"              " split or joint lines
"              " Plug 'AndrewRadev/splitjoin.vim'    " gS, gJ
"              " Plug 'skywind3000/asynctasks.vim'
"              " Plug 'skywind3000/asyncrun.vim'
"              
"              "  " snippets
"              "  Plug 'SirVer/ultisnips'
"              "  Plug 'excelkks/vim-snippets'
"              
"              
"              
"              " TODO
"              " check and semantic errors
"              Plug 'dense-analysis/ale'
"              
"              " debug TODO
"              " Plug 'puremourning/vimspector', {'do': './install_gadget.py --enable-c --enable-python --enable-go'}
"              
"              
"              
"              " latex
"              " Plug 'lervag/vimtex'
"              Plug 'xuhdev/vim-latex-live-preview',   {'for': 'tex'}
"              
"              
"              " tarbar
"              Plug 'majutsushi/tagbar'
"              
"              
"              " coc.nvim
"              Plug 'neoclide/coc.nvim', {'branch': 'release'}
"              
"              
call plug#end()


" ===
" === vim-illuminate
" ===
let g:Illuminate_delay = 550
let g:Illuminate_ftblacklist=['nerdtree']
let g:Illuminate_highlightUnderCursor = 0
" hi illuminatedWord cterm=undercurl gui=undercurl

" ===
" === vim-deus
" ===
set t_Co=256

" let &t_8f = "\<Esc>[38;2%lu;%lu;%lum"
" let &t_8b = "\<Esc>[48;2%lu;%lu;%lum"

set background=dark    " setting dark mode
colors deus
"colorscheme desert
let g:deus_termcolors=256

" " ===
" " === vim-code-dark
" " ===
" set t_Co=256
" colorscheme codedark
" set background=dark    " setting dark mode

" ===
" === nerdtree
" ===
noremap <c-n> :NERDTreeToggle<CR>

" ===
" === airblade/vim-rooter
" ===
"    let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_patterns = ['Rakefile', '.root', '.svn', '.project', '.git/']
autocmd BufEnter * :Rooter

" ===
" === numirias/semshi
" ===
let g:semshi#error_sign=v:false

" ===
" === markdown-preview.nvim
" ===

" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 1

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 1

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
" let g:mkdp_markdown_css = '~/markdown.css'

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = '8222'

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '${name}'

" ===
" === vim-markdown-toc
" ===
let g:vmt_auto_update_on_save = 0
let g:vmt_dont_insert_fence = 1
let g:vmt_fence_text = 'TOC'
let g:vmt_fence_closing_text = '/TOC'
let g:vmt_cycle_list_item_markers = 1

" ===
" === vim-after-object
" ===
autocmd VimEnter * call after_object#enable('=', ':', '-', '#', ' ', '/', '\')

" ===
" === tabular
" ===
vmap ga :Tabularize /

" ===
" === vimwiki/vimwiki
" ===
let g:vimwiki_list = [{'path': '~/vimwiki/',
            \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_folding = 'expr'
let g:vimwiki_diary_months = {
      \ 1: '一月', 2: '二月', 3: '三月',
      \ 4: '四月', 5: '五月', 6: '六月',
      \ 7: '七月', 8: '八月', 9: '九月',
      \ 10: '十月', 11: '十一月', 12: '十二月'
      \ }

" ===
" === vim-terminal-help
" ===
" Usage
" ALT + =         : toggle terminal below
" ALT + SHIFT + h : move to the window on the left.
" ALT + SHIFT + l : move to the window on the right.
" ALT + SHIFT + j : move to the window on the below.
" ALT + SHIFT + k : move to the window on the above.
" ALT + SHIFT + p : move to the window on the previous window.
" ALT + -         : paste regiter 0 to terminal.
" ALT + q         : switch to terminal normal mode.

" ===
" === vim-gutentags
" ===
" 自动索引 ctags自动更新

" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

"              
"              
"              "     " ===
"              "     " === asynctasks.vim && asyncrun.vim
"              "     " ===
"              "     "     let g:asyncrun_open = 6
"              "     "     let g:asynctasks_term_pos = 'tab'
"              "     "     " noremap <silent><f5> :AsyncTask file-run<cr>
"              "     "     noremap <silent><f5> :AsyncTask file-build<cr>
"              "     "     " project root directory
"              "     "     let g:asyncrun_rootmarks = ['.git', '.svn', '.root', '.project', '.hg']
"              
"              
"              "    " ===
"              "    " === vimspector
"              "    " ===
"              "    let g:vimspector_enable_mappings = 'HUMAN'
"              "    function! s:read_template_into_buffer(template)
"              "    	" has to be a function to avoid the extra space fzf#run insers otherwise
"              "    	execute '0r ~/.config/nvim/sample_vimspector_json/'.a:template
"              "    endfunction
"              "    command! -bang -nargs=* LoadVimSpectorJsonTemplate call fzf#run({
"              "    			\   'source': 'ls -1 ~/.config/nvim/sample_vimspector_json',
"              "    			\   'down': 20,
"              "    			\   'sink': function('<sid>read_template_into_buffer')
"              "    			\ })
"              "    noremap <space>vs :tabe .vimspector.json<CR>:LoadVimSpectorJsonTemplate<CR>
"              "    sign define vimspectorBP text=☛ texthl=Normal
"              "    sign define vimspectorBPDisabled text=☞ texthl=Normal
"              "    sign define vimspectorPC text=🔶 texthl=SpellBad
"              
"              
"              
"              " ===
"              " === vim-latex-live-preview
"              " ===
"              autocmd filetype tex setl updatetime=1000
"              let g:livepreview_engine = 'xelatex'
"              let g:livepreview_previewer='open -a Skim'
"              
"              
"              " ===
"              " === coc.nvim
"              " ===
"              " TextEdit might fail if hidden is not set.
"              set hidden
"              
"              "    " Some servers have issues with backup files, see #649.
"              "    set nobackup
"              "    set nowritebackup
"              
"              " Give more space for displaying messages.
"              set cmdheight=2
"              
"              " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
"              " delays and poor user experience.
"              set updatetime=300
"              
"              " Don't pass messages to |ins-completion-menu|.
"              set shortmess+=c
"              
"              " Always show the signcolumn, otherwise it would shift the text each time
"              " diagnostics appear/become resolved.
"              if has("patch-8.1.1564")
"                " Recently vim can merge signcolumn and number column into one
"                set signcolumn=number
"              else
"                set signcolumn=yes
"              endif
"              
"              " Use tab for trigger completion with characters ahead and navigate.
"              " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
"              " other plugin before putting this into your config.
"              "
"              inoremap <silent><expr> <TAB>
"                          \ pumvisible() ? coc#_select_confirm():
"                          \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump', ''])\<CR>" :
"                          \ <SID>check_back_space() ? "\<TAB>" :
"                          \ coc#refresh()
"              inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"              
"              
"              function! s:check_back_space() abort
"                let col = col('.') - 1
"                return !col || getline('.')[col - 1]  =~# '\s'
"              endfunction
"              
"              let g:coc_snippet_next = '<tab>'
"              let g:coc_snippet_prev = '<S-tab>'
"              
"              inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"              inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"              " make <cr> select the first conpletion item and confirm the conpletion when
"              " no item has been select
"              inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>" 
"              " format 
"              inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"              
"              
"              " Use <leader><space> to trigger completion.
"              inoremap <silent><expr> <C-\> coc#refresh()
"              
"              " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
"              " position. Coc only does snippet and additional edit on confirm.
"              " <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
"              if exists('*complete_info')
"                inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
"              else
"                inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"              endif
"              
"              " Use `[g` and `]g` to navigate diagnostics
"              " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
"              nmap <silent> [g <Plug>(coc-diagnostic-prev)
"              nmap <silent> ]g <Plug>(coc-diagnostic-next)
"              
"              " GoTo code navigation.
"              nmap <silent> gd <Plug>(coc-definition)
"              nmap <silent> gy <Plug>(coc-type-definition)
"              nmap <silent> gi <Plug>(coc-implementation)
"              nmap <silent> gr <Plug>(coc-references)
"              
"              " Use K to show documentation in preview window.
"              nnoremap <silent> K :call <SID>show_documentation()<CR>
"              
"              function! s:show_documentation()
"                if (index(['vim','help'], &filetype) >= 0)
"                  execute 'h '.expand('<cword>')
"                else
"                  call CocAction('doHover')
"                endif
"              endfunction
"              
"              " Highlight the symbol and its references when holding the cursor.
"              autocmd CursorHold * silent call CocActionAsync('highlight')
"              
"              " Symbol renaming.
"              nmap <leader>rn <Plug>(coc-rename)
"              
"              " Formatting selected code.
"              xmap <leader>f  <Plug>(coc-format-selected)
"              nmap <leader>f  <Plug>(coc-format-selected)
"              
"              "    " auto signature
"              "    augroup mygroup
"              "      autocmd!
"              "      " Setup formatexpr specified filetype(s).
"              "      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"              "      " Update signature help on jump placeholder.
"              "      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
"              "    augroup end
"              
"              
"              " Applying codeAction to the selected region.
"              " Example: `<leader>aap` for current paragraph
"              xmap <leader>a  <Plug>(coc-codeaction-selected)
"              nmap <leader>a  <Plug>(coc-codeaction-selected)
"              
"              " Remap keys for applying codeAction to the current buffer.
"              nmap <leader>ac  <Plug>(coc-codeaction)
"              " Apply AutoFix to problem on the current line.
"              nmap <leader>qf  <Plug>(coc-fix-current)
"              
"              " Map function and class text objects
"              " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
"              xmap if <Plug>(coc-funcobj-i)
"              omap if <Plug>(coc-funcobj-i)
"              xmap af <Plug>(coc-funcobj-a)
"              omap af <Plug>(coc-funcobj-a)
"              xmap ic <Plug>(coc-classobj-i)
"              omap ic <Plug>(coc-classobj-i)
"              xmap ac <Plug>(coc-classobj-a)
"              omap ac <Plug>(coc-classobj-a)
"              
"              " Use CTRL-S for selections ranges.
"              " Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
"              nmap <silent> <C-s> <Plug>(coc-range-select)
"              xmap <silent> <C-s> <Plug>(coc-range-select)
"              
"              " Add `:Format` command to format current buffer.
"              command! -nargs=0 Format :call CocAction('format')
"              
"              " Add `:Fold` command to fold current buffer.
"              command! -nargs=? Fold :call     CocAction('fold', <f-args>)
"              
"              " Add `:OR` command for organize imports of the current buffer.
"              command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
"              
"              " Add (Neo)Vim's native statusline support.
"              " NOTE: Please see `:h coc-status` for integrations with external plugins that
"              " provide custom statusline: lightline.vim, vim-airline.
"              set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
"              
"              " Mappings for CoCList
"              " Show all diagnostics.
"              nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
"              " Manage extensions.
"              nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
"              " Show commands.
"              nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
"              " Find symbol of current document.
"              nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
"              " Search workspace symbols.
"              nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
"              " Do default action for next item.
"              nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
"              " Do default action for previous item.
"              nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
"              " Resume latest coc list.
"              nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
"              
"              
"              " ===
"              " === Dress up my vim
"              " ===
set termguicolors
let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
hi NonText ctermfg=gray guifg=gray10

