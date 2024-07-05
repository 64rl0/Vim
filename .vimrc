" .vimrc
" vim: ft=vim

"   __|    \    _ \  |      _ \   __| __ __| __ __|
"  (      _ \     /  |     (   | (_ |    |      |
" \___| _/  _\ _|_\ ____| \___/ \___|   _|     _|


"This option has the effect of making Vim either more Vi-compatible, or make Vim behave in a more useful way
set nocompatible

" Enable color syntax highlighting
syntax on

" Disabling background so we use the shell bg
autocmd ColorScheme * highlight Normal     ctermbg=NONE guibg=NONE
autocmd ColorScheme * highlight LineNr     ctermbg=NONE guibg=NONE
autocmd ColorScheme * highlight CursorLine ctermbg=NONE guibg=NONE

" Vim Theme
colorscheme molokai

" Enable the cursor line highlight
set cursorline

" Enable line numbers
set number

" The width of a TAB is set to 4. Still it is a \t. It is just that Vim
" will interpret it to be having a width of 4
set tabstop=4

" Sets the number of columns for a TAB
set softtabstop=4

" Indents will have a width of 4
set shiftwidth=4

" Expand TABs to spaces
set expandtab

" Yank and paste with the system clipboard
set clipboard^=unnamed,unnamedplus

" Set the leader key
let mapleader = "\\"

" Defines a new custom Vim command called W to assume sudo privileges
"    when file is opened without sudo.
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
command! W :<C-U>execute ':silent w !sudo tee % > /dev/null' | :edit!

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

" Move screen down without moving cursor
" ALT-SHIFT-J
noremap Ô 5<C-E>
inoremap Ô <ESC>5<C-E>

" Move screen up without moving cursor
" ALT-SHIFT-K
noremap  5<C-Y>
inoremap  <ESC>5<C-Y>

" Move screen down 5 lines with cursor
noremap <C-J> 5<C-E>5j
inoremap <C-J> <ESC>5<C-E>5j

" Move screen up 5 lines with cursor
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


" Drop a mark before jumping so we can easily come back with 'j
function! MarkAndJump(prefix)
    if v:count > 0
        execute "normal! m" . "j" . v:count . a:prefix
    else
        execute "normal! m" . "j" . a:prefix
    endif
endfunction

nnoremap <silent> gg :<C-U>call MarkAndJump("gg")<CR>
nnoremap <silent> G :<C-U>call MarkAndJump("G")<CR>

" Jump to last change
nnoremap gI `.


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


" ----
" TABS
" ----
" Tab new
noremap <C-T> :<C-U>tabnew<CR>

" Tab next
noremap <C-Tab> :<C-U>tabnext<CR>
noremap <right> :<C-U>tabnext<CR>

" Tab previous
noremap <C-S-Tab> :<C-U>tabprevious<CR>
noremap <left> :<C-U>tabprevious<CR>


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
let g:netrw_altv = 0

" The o key splits the window horizontally with the new window and cursor at the top
let g:netrw_alto = 0

" Specify initial size of new windows made with o or v
let g:netrw_winsize = 20

" ToggleNetrw
let g:NetrwIsOpen = 0

function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i
                let g:NetrwIsOpen=0
            endif
            let i-=1
        endwhile
    else
        silent Lexplore
        let g:NetrwIsOpen=1
    endif
endfunction

" Toggle netrw only NORMAL mode
nnoremap <leader>e :<C-U>call ToggleNetrw()<CR>


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

" Show and hide hunk as the pointer enter and leaves the changed hunk
let g:GitGutterAutoPreviewStatus = 0

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
function! ToggleGitGutterAutoPreviewHunk()
    if !g:GitGutterAutoPreviewStatus
        call GitGutterAutoPreviewHunkEnable()
    else
        call GitGutterAutoPreviewHunkDisable()
    endif
endfunction

" Show and hide hunk
let g:GitGutterPreviewStatus = 0

" Function to toggle the GitGutterPreviewHunk
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

" Map shortcuts to enable and disable GitGutterAutoPreviewHunk
nmap <leader>pha :<C-U>call ToggleGitGutterAutoPreviewHunk()<CR>

" Preview a hunk changes
nmap <leader>ph :<C-U>call ToggleGitGutterPreviewHunk()<CR>


" -----------
" vim-airline
" -----------
" Enable vim-airline
let g:airline_enabled = 1

" Theme
let g:airline_theme = 'simple_carlogtt_ver'

" Automatically displays all buffers when there's only one tab open
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_close_button = 0

" Only the extensions listed will be loaded
" let g:airline_extensions = ['tabline', 'hunks']

