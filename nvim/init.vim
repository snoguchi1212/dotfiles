"vimで用いるshell
    set shell=/bin/zsh

"vimので用いるフォント
    set guifont="Hack Nerd font"

"shiftを(>, <)利用した時の文字の幅
    set shiftwidth=4

"Tabを利用した時の移動文字列
    set tabstop=4

"Tabをspaceに置き換える
	set expandtab

"文字のwrap設定
    set textwidth=0

"自動インデント設定
    set autoindent

"ハイライト検索
    set hlsearch

"クリップボードへの登録
    set clipboard=unnamed

"行番後の表示
    set number

"シンタックスの表示
    syntax on

"autocomplete
"" <Enter>で次候補<S-Enter>で前候補, <Tab>で決定, <Esc>でキャンセル
inoremap <silent><expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : "\<C-j>"
inoremap <silent><expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-k>"
inoremap <silent><expr> <Enter> coc#pum#visible() ? coc#pum#next(1) : "\<Enter>"
inoremap <silent><expr> <S-Enter> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Enter>"
inoremap <silent><expr> <Esc> coc#pum#visible() ? coc#pum#cancel() : "\<Esc>"
inoremap <silent><expr> <C-h> coc#pum#visible() ? coc#pum#cancel() : "\<C-h>"
inoremap <silent><expr> <Tab> coc#pum#visible() ? coc#pum#confirm(): "\<Tab>"


"""(vim-polyglot)
" CSVでは使わない
let g:polyglot_disabled = ['csv']
"""

"プラグインの設定
call plug#begin()
    Plug 'ntk148v/vim-horizon'
    Plug 'preservim/nerdtree'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'sheerun/vim-polyglot'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

"""(vim-horizon)
" if you don't set this option, this color might not correct "

colorscheme horizon

"lightline"
let g:lightline = {}
let g:lightline.colorscheme = 'horizon'
"""

"""(vim-gitgutter)
" turn on line highlighting by default
let g:gitgutter_highlight_lines = 1
""""

"""(NERDTree)
" ショートカットの設定
nnoremap <C-n> :NERDTreeToggle<CR>

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
"""
