" .vimrc
" vim: ft=vim

"   __|    \    _ \  |      _ \   __| __ __| __ __|
"  (      _ \     /  |     (   | (_ |    |      |
" \___| _/  _\ _|_\ ____| \___/ \___|   _|     _|


" ------------
" VIM SETTINGS
" ------------
" This option has the effect of making Vim either more Vi-compatible, or make Vim behave in a more useful way
set nocompatible

" Enable color syntax highlighting
syntax on

" Disabling background so we use the shell bg
autocmd ColorScheme * highlight Normal     ctermbg=NONE guibg=NONE
autocmd ColorScheme * highlight LineNr     ctermbg=NONE guibg=NONE
autocmd ColorScheme * highlight CursorLine ctermbg=NONE guibg=NONE

" Vim Theme
colorscheme catppuccin_mocha

" When on, uses |highlight-guifg| and |highlight-guibg| attributes in the terminal
set termguicolors

" Enable the cursor line highlight
set cursorline

" Enable line numbers
set number relativenumber

" Show (partial) command in the status bar
set showcmd
set showcmdloc="statusline"

" Commands and search patterns in the history
set history=1000000

" Maximum number of changes that can be undone
set undolevels=1000000

" The time in milliseconds that is waited for a key code or mapped key sequence to complete
set timeoutlen=1500

" The width of a TAB is set to 4.
" Still it is a \t. It is just that Vim will interpret it to be having a width of 4
set tabstop=4

" Sets the number of columns for a TAB
set softtabstop=4

" Indents will have a width of 4
set shiftwidth=4

" Expand TABs to spaces
set expandtab

" Copy indent from current line when starting a new line
set autoindent

" Do smart autoindenting when starting a new line
set smartindent

" Yank and paste with the system clipboard
set clipboard^=unnamed,unnamedplus

" Set the leader key
let mapleader = "\\"


" --------
" VimEnter
" --------
autocmd VimEnter * if argc() == 0 | Lexplore | endif


" ------
" MOTION
" ------
" Disable arrow keys in ALL modes
noremap <Up> <NOP>
inoremap <Up> <NOP>
noremap <Down> <NOP>
inoremap <Down> <NOP>
noremap <Left> <NOP>
inoremap <Left> <NOP>
noremap <Right> <NOP>
inoremap <Right> <NOP>

" Disable Page Up, Page Down, Home, and End keys in INSERT mode
inoremap <PageUp> <NOP>
inoremap <PageDown> <NOP>
inoremap <Home> <NOP>
inoremap <End> <NOP>

" Move cursor to the first character in a line
noremap H ^

" Move cursor to the last character in a line
noremap L g_

" Move cursor down file 5 lines
noremap J 5j

" Move cursor up file 5 lines
noremap K 5k

" Move screen down 5 lines with cursor
" CTRL-J
noremap <C-J> 5<C-E>5j
inoremap <C-J> <ESC>5<C-E>5j

" Move screen up 5 lines with cursor
" CTRL-K
noremap <C-K> 5<C-Y>5k
inoremap <C-K> <ESC>5<C-Y>5k

" Move screen down 1/2 page with cursor
" ALT-J
noremap ∆ <C-D>
inoremap ∆ <ESC><C-D>

" Move screen up 1/2 page with cursor
" ALT-K
noremap ˚ <C-U>
inoremap ˚ <ESC><C-U>

" Move screen down without moving cursor
" ALT-SHIFT-J
noremap Ô 5<C-E>
inoremap Ô <ESC>5<C-E>

" Move screen up without moving cursor
" ALT-SHIFT-K
noremap  5<C-Y>
inoremap  <ESC>5<C-Y>

" Drop a mark before jumping so we can easily come back with 'j
nnoremap <silent> gg :<C-U>call MarkAndJump("gg")<CR>
nnoremap <silent> G :<C-U>call MarkAndJump("G")<CR>

" Jump to last change
nnoremap gI `.

" Jump to last line on the window
noremap gH H

" Jump to middle line on the window
noremap gM M

" Jump to first line on the window
noremap gL L


" ---------------
" CUSTOM COMMANDS
" ---------------
" Use W to assume sudo privileges when file is opened without sudo.
" :<C-U> Clears any existing input in the command-line buffer
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

" Search word under the cursor
nnoremap <leader>f *``/<C-R>/<CR>N

" Replace word under the cursor
nnoremap <leader>r *``:%s/<C-R>///gc<left><left><left>

" Comment line out with #
nnoremap <leader># 0i# <ESC>0

" Comment line out with "
nnoremap <leader>" 0i" <ESC>0

" Comment line out with //
nnoremap <leader>/ 0i// <ESC>0


" -------
" BUFFERS
" -------
" Enter buffer navigation
nnoremap <C-W>b :<C-U>call EnterBuffersNavigationMode()<CR>


" -------
" WINDOWS
" -------
" Enter windows navigation
nnoremap <C-W>w :<C-U>call EnterWindowsNavigationMode()<CR>

" Enter resize mode
nnoremap <C-W>r :<C-U>call EnterResizeMode()<CR>

" Enter window zoom mode
nnoremap <C-W>z :<C-U>call Zoom()<CR>
nnoremap <C-W><C-Z> :<C-U>call Zoom()<CR>


" ----
" TABS
" ----
" Enter tabs navigation
nnoremap <C-W>t :<C-U>call EnterTabsNavigationMode()<CR>


" -------
" PLUGINS
" -------
" -----
" netrw
" -----
" Disable top banner
let g:netrw_banner = 0

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
nnoremap <C-W>e :<C-U>call ToggleNetrw()<CR>
nnoremap <C-W><C-E> :<C-U>call ToggleNetrw()<CR>

" Use V to open netrw selected file in a new split and rebalance split widths
autocmd FileType netrw nnoremap <buffer>V :<C-U>call NetrwOpenVSplit()<CR>


" -------------
" vim-gitgutter
" -------------
" Don't let vim-gitgutter set up any mappings at all
let g:gitgutter_map_keys = 0

" Signs colours
highlight GitGutterAdd    ctermfg=34
highlight GitGutterChange ctermfg=39
highlight GitGutterDelete ctermfg=160

" Disable SignColumn background colour
highlight SignColumn guibg=NONE ctermbg=NONE

" Enable and disable GitGutterAutoPreviewHunk
nmap <leader>pha :<C-U>call ToggleGitGutterAutoPreviewHunk()<CR>

" Preview a hunk changes
nmap <leader>ph :<C-U>call ToggleGitGutterPreviewHunk()<CR>


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

" Only the extensions listed will be loaded
" let g:airline_extensions = ['tabline', 'hunks']


" --------
" Undotree
" --------
nnoremap <C-W>u :UndotreeToggle<CR><C-W>h<C-W>k
nnoremap <C-W><C-U> :UndotreeToggle<CR><C-W>h<C-W>k


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
    nnoremap <silent> h :<C-U>bprevious<CR>
    nnoremap <silent> l :<C-U>bnext<CR>

    " Set <Esc> to exit buffers navigation mode and restore mappings
    nnoremap <silent> <Esc> :<C-U>call ExitBuffersNavigationMode()<CR>

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
    nnoremap <silent> w <C-W>w
    nnoremap <silent> q <C-W>q
    nnoremap <silent> k <C-W>k
    nnoremap <silent> j <C-W>j
    nnoremap <silent> h <C-W>h
    nnoremap <silent> l <C-W>l

    " Set <Esc> to exit windows navigation mode and restore mappings
    nnoremap <silent> <Esc> :<C-U>call ExitWindowsNavigationMode()<CR>

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
    nnoremap <silent> <Up> :<C-U>resize +3<CR>
    nnoremap <silent> <Down> :<C-U>resize -3<CR>
    nnoremap <silent> <Left> :<C-U>vertical resize -3<CR>
    nnoremap <silent> <Right> :<C-U>vertical resize +3<CR>

    " Set <Esc> to exit resize mode and restore mappings
    nnoremap <silent> <Esc> :<C-U>call ExitResizeMode()<CR>

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
    nnoremap <silent> h :<C-U>tabprevious<CR>
    nnoremap <silent> l :<C-U>tabnext<CR>

    " Set <Esc> to exit tabs navigation mode and restore mappings
    nnoremap <silent> <Esc> :<C-U>call ExitTabsNavigationMode()<CR>

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

