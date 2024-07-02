" .vimrc

"   __|    \    _ \  |      _ \   __| __ __| __ __|
"  (      _ \     /  |     (   | (_ |    |      |
" \___| _/  _\ _|_\ ____| \___/ \___|   _|     _|


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
"    will interpret it to be having a width of 4
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

" Open file explorer (netrw) only NORMAL mode
nnoremap <leader>o :<C-U>Ex<CR>

" Close file explorer (netrw) only NORMAL mode
nnoremap <leader>O :<C-U>bprevious<CR>

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
" Define a variable to keep track of autocommand status
let g:gitgutter_autocommand_enabled = 0

" Function to enable the autocommand
function! GitGutterAutoPreviewHunkEnable()
    if !g:gitgutter_autocommand_enabled
        augroup GitGutterAutocommand
            autocmd!
            autocmd CursorMoved * if gitgutter#hunk#in_hunk(line(".")) | GitGutterPreviewHunk | else | pclose | endif
        augroup END
        let g:gitgutter_autocommand_enabled = 1
        echo "GitGutter autocommand enabled"
    else
        echo "GitGutter autocommand is already enabled"
    endif
endfunction

" Function to disable the autocommand
function! GitGutterAutoPreviewHunkDisable()
    if g:gitgutter_autocommand_enabled
        augroup GitGutterAutocommand
            autocmd!
        augroup END
        let g:gitgutter_autocommand_enabled = 0
        pclose
        echo "GitGutter autocommand disabled"
    else
        echo "GitGutter autocommand is already disabled"
    endif
endfunction

" Map shortcuts to enable and disable GitGutterAutoPreviewHunk
nmap <leader>aph :<C-U>call GitGutterAutoPreviewHunkEnable()<CR>
nmap <leader>APH :<C-U>call GitGutterAutoPreviewHunkDisable()<CR>

" Preview a hunk changes
nmap ph :<C-U>GitGutterPreviewHunk<CR>

" Execute :pclose and close hunk preview
nmap PH :<C-U>pclose<CR>

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

