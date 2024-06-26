" .vimrc

" Enable color syntax highlighting
syntax on

" Vim Theme
colorscheme twilight256

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

" Enable line numbers
set number

" Defines a new custom Vim command called W to assume sudo privileges
"    when file is opened without sudo.
" :execute  - Begins an execution of multiple Vim commands
" ':silent w !sudo tee % > /dev/null'
"    writes the current buffer to a file using the tee command with
"    superuser privileges (using sudo)
"    The % symbol represents the current file name
"    The > /dev/null part discards the output of the tee command
" | - Separates multiple Vim commands.
" :edit! - Reloads the current buffer, discarding any changes made
"    after the previous write command.
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!

" Disable arrow keys in ALL modes
noremap <Up> <NOP>
noremap! <Up> <NOP>
noremap <Down> <NOP>
noremap! <Down> <NOP>
noremap <Left> <NOP>
noremap! <Left> <NOP>
noremap <Right> <NOP>
noremap! <Right> <NOP>

" Disable Page Up, Page Down, Home, and End keys in INSERT mode
noremap! <PageUp> <NOP>
noremap! <PageDown> <NOP>
noremap! <Home> <NOP>
noremap! <End> <NOP>

" Move cursor to the first character in a line
noremap H ^

" Move cursor to the last character in a line
noremap L g_

" Move cursor down file 5 lines
noremap J 5j

" Move cursor up file 5 lines
noremap K 5k

" Move cursor and screen down 1/2 page
noremap m <C-D>

" Move cursor and screen up 1/2 page
noremap , <C-U>

" Move screen up 5 lines (without moving cursor)
noremap <C-J> 5<C-E>

" Move screen down 5 lines (without moving cursor)
noremap <C-K> 5<C-Y>

" Jump to last change
nnoremap gI `.

" Search and replace word under the cursor
nnoremap gr *``:%s/<C-R>///gc<left><left><left>

" Search word under the cursor
nnoremap gf *``/<C-R>/<CR>N

