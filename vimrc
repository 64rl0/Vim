" .vimrc
" vim: ft=vim

"   __|    \    _ \  |      _ \   __| __ __| __ __|
"  (      _ \     /  |     (   | (_ |    |      |
" \___| _/  _\ _|_\ ____| \___/ \___|   _|     _|


" ----------------
" Colors and Fonts
" ----------------
" Enable color syntax highlighting
syntax on

" Disabling background so we use the shell bg
autocmd ColorScheme * highlight Normal       ctermbg=NONE guibg=NONE
autocmd ColorScheme * highlight LineNr       ctermbg=NONE guibg=NONE
autocmd ColorScheme * highlight CursorLine   ctermbg=NONE guibg=NONE
autocmd ColorScheme * highlight StatusLine   ctermbg=NONE guibg=NONE
autocmd ColorScheme * highlight StatusLineNC ctermbg=NONE guibg=NONE

" When on, uses |highlight-guifg| and |highlight-guibg| attributes in the terminal
set termguicolors

" Enable the cursor line highlight
set cursorline

" Vim Theme
colorscheme catppuccin_mocha


" ------------
" VIM SETTINGS
" ------------
" This option has the effect of making Vim either more Vi-compatible, or make Vim behave in a more useful way
set nocompatible

" Influences the working of <BS>
set backspace=indent,eol,start

" Enable loading the plugin files for specific file types
" Enable indent file for specific file types with
filetype plugin on
filetype indent on

" Enable line numbers
set number relativenumber

" Show (partial) command in the status bar
set showcmd
" set showcmdloc="statusline" " disabled as doesn't work

" Yank and paste with the system clipboard
set clipboard^=unnamed,unnamedplus

" Commands and search patterns in the history
set history=10000

" Maximum number of changes that can be undone
set undolevels=1000000

" The time in milliseconds that is waited for a mapped key sequence to complete
set timeoutlen=2000

" The time in milliseconds that is waited for a key code sequence to complete
set ttimeoutlen=100

" Set the leader key
let mapleader = "\\"


" ---------
" VIM SPELL
" ---------
" Spell enabled
set spell

" This means US English
set spelllang=en_us

" Name of the word list file where words are added for the |zg| and |zw|
set spellfile=$HOME/.vim/spell/en.utf-8.add

" List of options for spell checking
set spelloptions=camel


" -----------------------------------------
" Text, whitespaces, tab and indent related
" -----------------------------------------
" Expand TABs to spaces
set expandtab

" <Tab> in front of a line inserts blanks according to 'shiftwidth'
set smarttab

" The width of a TAB is set to 4
" Still it is a \t. It is just that Vim will interpret it to be having a width of 4
set tabstop=4

" Sets the number of columns for a TAB
set softtabstop=4

" Indents will have a width of 4
set shiftwidth=4

" Copy indent from current line when starting a new line
set autoindent

" Do smart autoindenting when starting a new line
set smartindent

" Show whitespaces
set listchars=eol:$,tab:>·,trail:~,extends:>,precedes:<,space:·


" ------
" Search
" ------
" Ignore case when searching
set ignorecase

" Override the 'ignorecase' option if the search pattern contains upper case characters
set smartcase

" Highlight search results
set hlsearch

" Make clearing the last used search pattern highlighting
nnoremap <silent> <leader>cp :let @/ = ""<CR>

" Search word under the cursor
nnoremap <leader>f *``/<C-r>/<CR>N

" Replace word under the cursor
nnoremap <leader>r *``:%s/<C-r>///gc<left><left><left>


" --------
" VimEnter
" --------
autocmd VimEnter * if argc() == 0 | call ToggleNetrw() | endif


" ------
" MOTION
" ------
" Disable arrow keys in NORMAL modes
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Move cursor to the first character in a line
noremap B ^
" noremap H ^

" Move cursor to the last character in a line
noremap E g_
" noremap L g_

" Move cursor down file 5 lines
noremap J 5j

" Move cursor up file 5 lines
noremap K 5k

" Move screen down 5 lines without moving cursor
" CTRL-J
noremap <C-j> 5<C-e>5j
inoremap <C-j> <C-o>5<C-e><C-o>5j

" Move screen up 5 lines without moving cursor
" CTRL-K
noremap <C-k> 5<C-y>5k
inoremap <C-k> <C-o>5<C-y><C-o>5k

" Move screen down 1/2 page without moving cursor
" ALT-J
noremap ∆ <C-d>
inoremap ∆ <C-o><C-d>

" Move screen up 1/2 page without moving cursor
" ALT-K
noremap ˚ <C-u>
inoremap ˚ <C-o><C-u>

" Move screen down 1 line with cursor
" ALT-SHIFT-J
noremap Ô 5<C-e>
inoremap Ô <C-o>5<C-e>

" Move screen up 1 line with cursor
" ALT-SHIFT-K
noremap  5<C-y>
inoremap  <C-o>5<C-y>

" Drop a mark before jumping so we can easily come back with 'j
nnoremap <silent> gg :<C-u>call MarkAndJump("gg")<CR>
nnoremap <silent> G :<C-u>call MarkAndJump("G")<CR>

" Jump to last line on the window
" noremap gH H

" Jump to middle line on the window
" noremap gM M

" Jump to first line on the window
" noremap gL L


" ---------------
" CUSTOM COMMANDS
" ---------------
" Use W to assume sudo privileges when file is opened without sudo.
" :<C-u> Clears any existing input in the command-line buffer
" execute Begins an execution of multiple Vim commands
" ':silent w !sudo tee % > /dev/null'
"    writes the current buffer to a file using the tee command with
"    superuser privileges (using sudo)
"    The % symbol represents the current file name
"    The > /dev/null part discards the output of the tee command
" | - Separates multiple Vim commands.
" :edit! - Reloads the current buffer, discarding any changes made
"    after the previous write command.
command! W :execute ':silent w !sudo tee % > /dev/null' | :edit!


" -------
" BUFFERS
" -------
" Enter buffer navigation
nnoremap <C-w>b :<C-u>call EnterBuffersNavigationMode()<CR>


" -------
" WINDOWS
" -------
" Enter windows navigation
nnoremap <C-w>w :<C-u>call EnterWindowsNavigationMode()<CR>

" Enter resize mode
nnoremap <C-w>r :<C-u>call EnterResizeMode()<CR>

" Enter window zoom mode
nnoremap <C-w>z :<C-u>call Zoom()<CR>
nnoremap <C-w><C-z> :<C-u>call Zoom()<CR>


" ----
" TABS
" ----
" Enter tabs navigation
nnoremap <C-w>t :<C-u>call EnterTabsNavigationMode()<CR>


" ----------------
" PLUGINS PACKLOAD
" ----------------
" -----
" netrw
" -----
" Disable top banner
let g:netrw_banner = 0

" Buffer settings to enable Number and RelativeNumber as off by default
let g:netrw_bufsettings = 'noma nomod nu rnu nobl nowrap ro'

" List style
let g:netrw_liststyle = 1

" Make vertical splitting the default for previewing files
let g:netrw_preview = 1

" The v key splits the window vertically with the new window and cursor at the left
let g:netrw_altv = 1

" The o key splits the window horizontally with the new window and cursor at the top
let g:netrw_alto = 0

" Specify initial size of new windows made with o or v
let g:netrw_winsize = 20

" Toggle netrw only NORMAL mode
" Simulate CMD-1 on macOS
nnoremap ∞ :<C-u>call ToggleNetrw()<CR>
nnoremap <leader>e :<C-u>call ToggleNetrw()<CR>
nnoremap <C-w>e :<C-u>call ToggleNetrw()<CR>
nnoremap <C-w><C-e> :<C-u>call ToggleNetrw()<CR>

" Use V to open netrw selected file in a new split and rebalance split widths
autocmd FileType netrw nnoremap <buffer>V :<C-u>call NetrwOpenVSplit()<CR>

" Disable vim-airline within Netrw window
autocmd FileType netrw let b:airline_disable_statusline = 1

" -------------
" vim-gitgutter
" -------------
" Color scheme settings
highlight SignColumn      guibg=NONE
highlight GitGutterAdd    guifg=#A6E3A1 guibg=NONE
highlight GitGutterChange guifg=#89B4FA guibg=NONE
highlight GitGutterDelete guifg=#F38BA8 guibg=NONE

" Don't let vim-gitgutter set up any mappings at all
let g:gitgutter_map_keys = 0

" Navigate hunks
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

" Enable and disable GitGutterAutoPreviewHunk
nmap <leader>pha :<C-u>call ToggleGitGutterAutoPreviewHunk()<CR>

" Preview a hunk changes
nmap <leader>ph :<C-u>call ToggleGitGutterPreviewHunk()<CR>


" -----------
" vim-airline
" -----------
" Enable vim-airline
let g:airline_enabled = 1

" Theme
let g:airline_theme = 'catppuccin_mocha'

" Automatically displays all buffers when there's only one tab open
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''

" Symbols in the statusline
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

call extend(g:airline_symbols, {
  \ 'readonly': "ro",
  \ 'whitespace': "!",
  \ 'linenr': " ln:",
  \ 'maxlinenr': "",
  \ 'colnr': " cn:",
  \ 'branch': "on",
  \ 'notexists': "[?]",
  \ 'crypt': "[crypt]",
  \ 'dirty': '[!]',
  \ }, 'keep')


" --------
" Undotree
" --------
" Set window layout
let g:undotree_WindowLayout = 2

" Toggle Undotree
nnoremap <leader>u :UndotreeToggle<CR><C-w>1w


" --------------
" vim-commentary
" --------------
" My favorite file type isn't supported!
" autocmd FileType apache setlocal commentstring=#\ %s


" ------------------------------
" ALE (Asynchronous Lint Engine)
" ------------------------------
" Color scheme settings
highlight ALEErrorSign   guifg=#F38BA8 guibg=NONE
highlight ALEWarningSign guifg=#F9E2AF guibg=NONE

" Format for echo messages
let g:ale_echo_msg_format = '[%linter%] [%severity%] --> %s'

" Disabling highlighting
let g:ale_set_highlights = 0

" The default VirtualEnv directory
let g:ale_virtualenv_dir_names = [expand('$VIRTUAL_ENV'), '/Users/carlogtt/Dropbox/SDE/VirtualEnvs/generic-new']

" Fix files when save
let g:ale_fix_on_save = 1

" Enable fixers for all files
let g:ale_fixers = {'*': ['trim_whitespace']}

" Navigate errors
nmap ]a <Plug>(ale_next_wrap)
nmap [a <Plug>(ale_previous_wrap)


" -------
" vim-lsp
" -------
" Call OnLspBufferEnabled only for languages that has the server registered
augroup lsp_install
    autocmd!
    autocmd User lsp_buffer_enabled call OnLspBufferEnabled()
augroup END

" Disable diagnostics support
let g:lsp_diagnostics_enabled = 0


" ------------
" auto-compl-pop
" ------------
set completeopt=menuone,longest
set shortmess+=c


" ------------
" vim-floaterm
" ------------
" Floaterm size
let g:floaterm_width = 0.9
let g:floaterm_height = 0.9

nnoremap <leader>tt :FloatermToggle<CR>
tnoremap <leader>tt <C-\><C-n>:FloatermToggle<CR>

nnoremap <leader>tc :FloatermNew<CR>
tnoremap <leader>tc <C-\><C-n>:FloatermNew<CR>

nnoremap <leader>tp :FloatermPrev<CR>
tnoremap <leader>tp <C-\><C-n>:FloatermPrev<CR>

nnoremap <leader>tn :FloatermNext<CR>
tnoremap <leader>tn <C-\><C-n>:FloatermNext<CR>

nnoremap <leader>lg :FloatermNew lazygit<CR>


" -----------
" vim-oscyank
" -----------
nmap <leader>y <Plug>OSCYankOperator
nmap <leader>yy <leader>c_
vmap <leader>y <Plug>OSCYankVisual

" maximum length of a selection, 0 for unlimited length
let g:oscyank_max_length = 0

" disable message on successful copy
let g:oscyank_silent = 0

" trim surrounding whitespaces before copy
let g:oscyank_trim = 0

" the OSC52 format string to use
let g:oscyank_osc52 = "\x1b]52;c;%s\x07"


" ---------
" FUNCTIONS
" ---------
" Function to drop a mark and jump to line or top or bottom
function! MarkAndJump(prefix)
    if v:count > 0
        execute "normal! m" . "j" . v:count . a:prefix
    else
        execute "normal! m" . "j" . a:prefix
    endif
endfunction

" Function to enter buffer navigation mode and set temporary mappings
function! EnterBuffersNavigationMode()
    " Save the current mappings
    let g:save_left = maparg('h', 'n')
    let g:save_right = maparg('l', 'n')

    " Set new mappings for navigation
    nnoremap <silent> h :<C-u>bprevious<CR>
    nnoremap <silent> l :<C-u>bnext<CR>

    " Set <Esc> to exit buffers navigation mode and restore mappings
    nnoremap <silent> <Esc> :<C-u>call ExitBuffersNavigationMode()<CR>

    " Notify user
    echo "Buffers NavigationMode enabled"
endfunction

" Function to exit buffers navigation mode and restore original mappings
function! ExitBuffersNavigationMode()
    if !empty(g:save_left)
        execute 'nnoremap <silent> h ' . g:save_left
        unlet g:save_left
    else
        nunmap <silent> h
    endif

    if !empty(g:save_right)
        execute 'nnoremap <silent> l ' . g:save_right
        unlet g:save_right
    else
        nunmap <silent> l
    endif

    " Unmap <Esc> from exiting buffers navigation mode
    nunmap <silent> <Esc>

    " Notify user
    echo "Buffers NavigationMode disabled"
endfunction

" Function to enter windows navigation mode and set temporary mappings
function! EnterWindowsNavigationMode()
    " Save the current mappings
    let g:save_rotate = maparg('w', 'n')
    let g:save_quit = maparg('q', 'n')
    let g:save_up = maparg('k', 'n')
    let g:save_down = maparg('j', 'n')
    let g:save_left = maparg('h', 'n')
    let g:save_right = maparg('l', 'n')

    " Set new mappings for navigation
    nnoremap <silent> w <C-w>w
    nnoremap <silent> q <C-w>q
    nnoremap <silent> k <C-w>k
    nnoremap <silent> j <C-w>j
    nnoremap <silent> h <C-w>h
    nnoremap <silent> l <C-w>l

    " Set <Esc> to exit windows navigation mode and restore mappings
    nnoremap <silent> <Esc> :<C-u>call ExitWindowsNavigationMode()<CR>

    " Notify user
    echo "Windows NavigationMode enabled"
endfunction

" Function to exit windows navigation mode and restore original mappings
function! ExitWindowsNavigationMode()
    if !empty(g:save_rotate)
        execute 'nnoremap <silent> w ' . g:save_rotate
        unlet g:save_rotate
    else
        nunmap <silent> w
    endif

    if !empty(g:save_quit)
        execute 'nnoremap <silent> q ' . g:save_quit
        unlet g:save_quit
    else
        nunmap <silent> q
    endif

    if !empty(g:save_up)
        execute 'nnoremap <silent> k ' . g:save_up
        unlet g:save_up
    else
        nunmap <silent> k
    endif

    if !empty(g:save_down)
        execute 'nnoremap <silent> j ' . g:save_down
        unlet g:save_down
    else
        nunmap <silent> j
    endif

    if !empty(g:save_left)
        execute 'nnoremap <silent> h ' . g:save_left
        unlet g:save_left
    else
        nunmap <silent> h
    endif

    if !empty(g:save_right)
        execute 'nnoremap <silent> l ' . g:save_right
        unlet g:save_right
    else
        nunmap <silent> l
    endif

    " Unmap <Esc> from exiting windows navigation mode
    nunmap <silent> <Esc>

    " Notify user
    echo "Windows NavigationMode disabled"
endfunction

" Function to enter resize mode and set temporary mappings
function! EnterResizeMode()
    " Save the current mappings
    let g:save_up = maparg('<Up>', 'n')
    let g:save_down = maparg('<Down>', 'n')
    let g:save_left = maparg('<Left>', 'n')
    let g:save_right = maparg('<Right>', 'n')

    " Set new mappings for resizing
    nnoremap <silent> <Up> :<C-u>resize +3<CR>
    nnoremap <silent> <Down> :<C-u>resize -3<CR>
    nnoremap <silent> <Left> :<C-u>vertical resize -3<CR>
    nnoremap <silent> <Right> :<C-u>vertical resize +3<CR>

    " Set <Esc> to exit resize mode and restore mappings
    nnoremap <silent> <Esc> :<C-u>call ExitResizeMode()<CR>

    " Notify user
    echo "Windows ResizeMode enabled"
endfunction

" Function to exit resize mode and restore original mappings
function! ExitResizeMode()
    if has_key(g:, 'save_up')
        execute 'nnoremap <silent> <Up> ' . g:save_up
        unlet g:save_up
    else
        nunmap <silent> <Up>
    endif

    if has_key(g:, 'save_down')
        execute 'nnoremap <silent> <Down> ' . g:save_down
        unlet g:save_down
    else
        nunmap <silent> <Down>
    endif

    if has_key(g:, 'save_left')
        execute 'nnoremap <silent> <Left> ' . g:save_left
        unlet g:save_left
    else
        nunmap <silent> <Left>
    endif

    if has_key(g:, 'save_right')
        execute 'nnoremap <silent> <Right> ' . g:save_right
        unlet g:save_right
    else
        nunmap <silent> <Right>
    endif

    " Unmap <Esc> from exiting resize mode
    nunmap <silent> <Esc>

    " Notify user
    echo "Windows ResizeMode disabled"
endfunction

" Function to enter zoom mode
function! Zoom()
    if winnr('$') > 1
        let lst = win_findbuf(bufnr())
        call filter(lst, "tabpagewinnr(win_id2tabwin(v:val)[0], '$') == 1")
        if len(lst) >=# 1
            call win_gotoid(lst[0])
        else
            tab split
        endif
    else
        let lst = win_findbuf(bufnr())
        call filter(lst, "v:val !=# " . win_getid())
        if len(lst) >=# 1
            wincmd c
            call win_gotoid(lst[0])
        endif
    endif
endfunction

" Function to enter tabs navigation mode and set temporary mappings
function! EnterTabsNavigationMode()
    " Save the current mappings
    let g:save_left = maparg('h', 'n')
    let g:save_right = maparg('l', 'n')

    " Set new mappings for navigation
    nnoremap <silent> h :<C-u>tabprevious<CR>
    nnoremap <silent> l :<C-u>tabnext<CR>

    " Set <Esc> to exit tabs navigation mode and restore mappings
    nnoremap <silent> <Esc> :<C-u>call ExitTabsNavigationMode()<CR>

    " Notify user
    echo "Tabs NavigationMode enabled"
endfunction

" Function to exit tabs navigation mode and restore original mappings
function! ExitTabsNavigationMode()
    if !empty(g:save_left)
        execute 'nnoremap <silent> h ' . g:save_left
        unlet g:save_left
    else
        nunmap <silent> h
    endif

    if !empty(g:save_right)
        execute 'nnoremap <silent> l ' . g:save_right
        unlet g:save_right
    else
        nunmap <silent> l
    endif

    " Unmap <Esc> from exiting tabs navigation mode
    nunmap <silent> <Esc>

    " Notify user
    echo "Tabs NavigationMode disabled"
endfunction

" Function to ToggleNetrw sidebar
let g:NetrwIsOpen = 0
let g:NetrwFound = 0

function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i
                let g:NetrwFound = 1
            endif
            let i-=1
        endwhile
            if g:NetrwFound == 1
            let g:NetrwIsOpen = 0
            let g:NetrwFound = 0
        else
            silent Lexplore
            let g:NetrwIsOpen = 1
            let g:NetrwFound = 0
        endif
    else
        silent Lexplore
        let g:NetrwIsOpen=1
    endif
endfunction

" Function to use V to open file selected in netrw in a new vertical split
function! NetrwOpenVSplit()
    normal v
    wincmd =
    wincmd h
endfunction

" Function to enable the GitGutterAutoPreviewHunk
function! GitGutterAutoPreviewHunkEnable()
    if !g:GitGutterAutoPreviewStatus
        augroup GitGutterAutocommand
            autocmd!
            autocmd CursorMoved * if gitgutter#hunk#in_hunk(line(".")) | GitGutterPreviewHunk | else | pclose | endif
        augroup END
        let g:GitGutterAutoPreviewStatus = 1
        echo "GitGutterAutoPreview enabled"
    else
        echo "GitGutterAutoPreview is already enabled"
    endif
endfunction

" Function to disable the GitGutterAutoPreviewHunk
function! GitGutterAutoPreviewHunkDisable()
    if g:GitGutterAutoPreviewStatus
        augroup GitGutterAutocommand
            autocmd!
            pclose
        augroup END
        let g:GitGutterAutoPreviewStatus = 0
        echo "GitGutterAutoPreview disabled"
    else
        echo "GitGutterAutoPreview is already disabled"
    endif
endfunction

" Function to toggle the GitGutterAutoPreviewHunk
let g:GitGutterAutoPreviewStatus = 0

function! ToggleGitGutterAutoPreviewHunk()
    if !g:GitGutterAutoPreviewStatus
        call GitGutterAutoPreviewHunkEnable()
    else
        call GitGutterAutoPreviewHunkDisable()
    endif
endfunction

" Function to toggle the GitGutterPreviewHunk
let g:GitGutterPreviewStatus = 0

function! ToggleGitGutterPreviewHunk()
    if !g:GitGutterPreviewStatus
        let l:output = execute('GitGutterPreviewHunk')
        if l:output !~ 'Cursor is not in a hunk'
            let g:GitGutterPreviewStatus = 1
        else
            echo "Cursor is not in a hunk"
        endif
    else
        execute 'pclose'
        let g:GitGutterPreviewStatus = 0

    endif
endfunction

" Initialize vim-lsp
function! OnLspBufferEnabled() abort
    setlocal omnifunc=lsp#complete
endfunction

