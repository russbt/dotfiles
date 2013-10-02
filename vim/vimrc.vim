" Russ' VIM setup script
" Last update: 10/1/13
"
" Notable choices:
"   Never use tabs (always use spaces instead)
"   Key mappings more like Windows (and sort-of like Mac)
"   Navigation more tailored to arrow keys
"   Font choice that doesn't suck, and font size-change on-the-fly
"   Make searching more responsive and less picky
"   Useful shortcuts for code-folding
"   Larger default window size
"   Color selection: dark-grey background
"   File-type-specific settings for tab-stops
"   Set up to use tabs for individual files
"   Misc keyboard bindings
"
" Vim plugins used:
"   verilog_systemverilog : location lost - includes OVM/UVM highlighting
"   SpaceHI               : http://www.vim.org/scripts/script.php?script_id=443
"   NERDTree              : http://www.vim.org/scripts/script.php?script_id=1658
"   Align                 : http://www.vim.org/scripts/script.php?script_id=294
"   MultipleSearch        : http://www.vim.org/scripts/script.php?script_id=479
"   peaksea               : http://vim.sourceforge.net/scripts/script.php?script_id=760
"
" Useful key-combos:
"   --Tabs--
"     <Ctrl>-<Tab>           : Switch to next tab
"     <Ctrl>-<Shift>-<Tab>   : Switch to previous tab
"     <F8>                   : Toggle tab mode
"   --Scrolling--
"     <Ctrl>-<Up>            : Scroll up
"     <Ctrl>-<Down>          : Scroll down
"     <Ctrl>-<Left>          : Word left
"     <Ctrl>-<Right>         : Word right
"   --Editing--
"     <Ctrl>-X/C/V/Z/R       : Cut/Copy/Paste/Undo/Redo
"     <Ctrl>-Q               : Enter "visual" mode (since Ctrl-Z is now Undo)
"   --Search/Replace--
"     ./                     : Multi-search
"     ./                     : Multi-search in all buffers
"     ;;                     : Search/replace (in "normal") mode
"     ;,                     : Search/replace case-insensitive (in "normal") mode
"     <Ctrl>-N               : Clear search highlighting
"     <F5>                   : Toggle hide/display last-search highlight
"     <Ctrl>-G               : Repeat last search (only when in "insert" mode)
"     _$                     : Strip trailing spaces
"   --Viewing--
"     ,-  /  ,=              : Smaller / Larger font size (in "normal") mode
"     <Ctrl>-<Alt>-<Left>    : Collapse current fold
"     <Ctrl>-<Alt>-<Right>   : Expand current fold
"     <Ctrl>-<Alt>-<Up>      : Collapse all folds
"     <Ctrl>-<Alt>-<Down>    : Collapse all folds
"     <Ctrl>-<LeftMouse>     : Rectangle-select
"     ,l                     : Toggle showing invisibles (in "normal") mode
"     <F2>                   : Toggle row/column crosshairs
"
" Other useful commands:
"   :Align                   : Align parts of lines to the same column
"   :Search                  : Multi-search (with multiple colors)

" ------- General ------- {{{
"
set nocompatible       " Enable VIM features that aren't in VI
set hidden             " Allow switching between files without having to save first
set undolevels=100     " lots of undo
set history=200        " keep 200 lines of command line history
set ruler              " show the cursor position all the time
set showcmd            " display incomplete commands
set diffopt+=iwhite    " ignore whitespace in diff mode
if !has("unix") && has("gui_running")
  " For Windows only, keep swap files on local drive to avoid "Delayed Write Failed" errors
  set dir=c:\\temp
endif
"}}}

" ------- Indenting/tabs ------- {{{
set shiftwidth=4   " default to 4 spaces
set softtabstop=4  " default to 4 spaces
set autoindent     " always set autoindenting on
set expandtab      " use spaces instead of tabs (can be overridden per-file-type)
"}}}

" ------- Scrolling ------- {{{
"
" Map <Ctrl-Down> and <Ctrl-Up> to scroll up and down. This has do be done
" before sourcing mswin.vim because that remaps the {rhs} of the map commands
:nnoremap <C-Down> <C-E>
:vnoremap <C-Down> <C-E>
:inoremap <C-Down> <C-X><C-E>
:noremap <C-Up> <C-Y>
:vnoremap <C-Up> <C-Y>
:inoremap <C-Up> <C-X><C-Y>
"}}}

" ------- Add Windows-like behavior  ------- {{{
"  This sets up things including:
"    Ctrl-X/C/V for cut/copy/paste
"    Ctrl-Z for undo
"    Ctrl-Q for visual mode (since Ctrl-V is now paste)
source $VIMRUNTIME/mswin.vim
"}}}

" ------- Fonts ------- {{{
"
" Use a non-hideous font and make changing font-size on-the-fly easy:
"    ,=  -> larger, ,-  -> smaller   (On a Mac, you can use cmd-= and cmd--)

" Font selection
if has("gui_running")
  if has("gui_gtk2")
    " Redhat, etc
    set guifont=Monospace\ 12
  elseif has("gui_macvim")
    " MacVim (OS X)
    set guifont=Consolas:h14
  elseif has("X11")
    " Some other unix-y flavor
    set guifont=-adobe-courier-medium-r-normal-*-*-140-*-*-m-*-iso10646-1
  else
    " Windows
    set gfn=Consolas:h12:cDEFAULT
  endif
endif

" Enable adjusting the font size on the fly
" from:  http://vim.wikia.com/wiki/Change_font_size_quickly
function! AdjustFontSize(amount)
  if has("gui_running")
    if has("gui_gtk2")
      let s:pattern = '^\(.* \)\([1-9][0-9]*\)\(.*\)$'
    else
      let s:pattern = '^\(.*:h\)\(\d\+\)\(.*\)$'
    endif

    let s:minfontsize = 6
    let s:maxfontsize = 16
    let leading = substitute(&guifont, s:pattern, '\1', '')
    let cursize = substitute(&guifont, s:pattern, '\2', '')
    let trailing = substitute(&guifont, s:pattern, '\3', '')
    let newsize = cursize + a:amount
    if (newsize >= s:minfontsize) && (newsize <= s:maxfontsize)
      let newfont = leading . newsize . trailing
      let &guifont = newfont
    endif
  endif
  "echoerr "You need to run the GTK2 version of Vim to use this function."
endfunction

function! LargerFont()
  call AdjustFontSize(1)
endfunction
command! LargerFont call LargerFont()

function! SmallerFont()
  call AdjustFontSize(-1)
endfunction
command! SmallerFont call SmallerFont()

if has("gui_running")
  map ,= :LargerFont<CR>
  map ,- :SmallerFont<CR>
endif
"}}}

" ------- Search ------- {{{
" Ignore case when searching
set ignorecase
" Unless I include caps in the search string
set smartcase
" Search as soon as I start typing
set incsearch

" Switch on highlighting the last used search pattern.
set hlsearch

" Multi-search (multiple colors for consecutive searches)
let g:MultipleSearchMaxColors = 4
noremap ./ :Search 
noremap .? :SearchBuffers 

" Function to call SearchReset, if MultipleSearch has been installed
function SafeSearchReset()
  if (exists(':Search'))
    SearchReset
  endif
endfunction

" Make F5 toggle highlight mode (to turn it off after a search)
map <F5> :set hls!<bar>set hls?<bar>call SafeSearchReset()<CR>

" Clear search matches with <Ctrl-N>
nmap <silent> <C-N> :silent noh<bar>call SafeSearchReset()<CR>

" Turn highliting back on for the next search
nnoremap / :set hlsearch<CR>/
nnoremap * :set hlsearch<CR>*

" Search & replace
noremap ;; :%s:::g<Left><Left><Left>

" Search & replace, case-insensitive
noremap ;' :%s:::cg<Left><Left><Left><Left>

" Shortcut to insert a \(\) in search & replace string
cmap ;\ \(\)<Left><Left>

" Make Ctrl-G be find-next in insert mode
inoremap <C-G> <C-O>n
"}}}

" ------- Folding ------- {{{
if has("folding")
  " see http://www.linux.com/archive/feature/114138 for tips

  "use markers (curly-braces) instead of side-band
  set foldmethod=marker

  "open & close folds with ctrl-alt-left/right
  nmap <C-A-Right> zo
  nmap <C-A-Left> zc
  inoremap <C-A-Right> <C-O>zo
  inoremap <C-A-Left> <C-O>zc

  "open & close ALL folds with ctrl-alt-down/up
  nmap <C-A-Down> zR
  nmap <C-A-Up> zM
  inoremap <C-A-Down> <C-O>zR
  inoremap <C-A-Up> <C-O>zM
endif
"}}}

" ------- Misc Visuals ------- {{{

" Set window height to 45 lines of text
if has("gui_running")
  :set lines=45 columns=120
endif

" Turn on syntax highlighting if more than 2 colors available
if &t_Co > 2 || has("gui_running")
  syntax on
endif

" Use a non-hideous color scheme
"  from: http://vim.sourceforge.net/scripts/script.php?script_id=760
if ! has("gui_running")
  set t_Co=256
endif
set background=dark
colorscheme peaksea

" Let rectangle-select (block-select) mode include non-existant characters
set virtualedit=block
" Rectangle-select with mouse
noremap <C-LeftMouse> <LeftMouse><Esc><C-Q>
noremap <C-LeftDrag> <LeftDrag>

" Make sure to keep at least 3 lines visible above/below the cursor
:set scrolloff=3

" Enable highlighting of tabs and end-spaces by default - spacehi.vim
" Toggle highlighting of special characters with <F3>
if has("autocmd")
  autocmd BufNewFile,BufReadPost,FilterReadPost,FileReadPost,Syntax * SpaceHi
  au FileType help NoSpaceHi
endif
"}}}

" ------- File-type specific setup ------- {{{
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " set up indentation on a per-file-type basis
  " See: http://vim.wikia.com/wiki/Indenting_source_code
  autocmd FileType python setlocal shiftwidth=4 softtabstop=4
  autocmd FileType verilog setlocal shiftwidth=3 softtabstop=3
  autocmd FileType verilog_systemverilog setlocal shiftwidth=3 softtabstop=3
  autocmd FileType cpp setlocal shiftwidth=3 softtabstop=3

  augroup END

endif " has("autocmd")
"}}}

" ------- Tab-pages (i.e. window tabs)  ------- {{{
" See http://vim.wikia.com/wiki/Using_tab_pages
"         New buffers (from command-line or with :e) open in a tab
"         Use C-Tab and C-S-Tab to cycle through buffers
"         If file opens in a split-window instead of tab, press "Ctrl-w T";
"         also can press <F8> to split all open buffers out to tabs (and back)
"
let notabs = 0                       " Start with tabs enabled
set tabpagemax=99                    " Effectively no max number of tabs
set switchbuf=usetab,newtab          " New buffers open in a tab
:nnoremap <C-Tab> :sbnext<CR>        " Ctrl-Tab switches to the next tab
:nnoremap <S-C-Tab> :sbprevious<CR>  " Ctrl-Shift-Tab switches to previous tab
nnoremap <silent> <F8> :let notabs=!notabs<Bar>:if notabs<Bar>:tabo<Bar>:else<Bar>:tab ball<Bar>:tabn<Bar>:endif<CR>
     " F8 switches between buffers in tabs or not (good for fixing when tabs
     " get messed up)
if has("autocmd")
  " All newly opened or created buffers open in a tab
  au BufAdd,BufNewFile,BufRead * nested tab sball
endif

" Tab headings (labels)
function GuiTabLabel()
    let label = ''
    let bufnrlist = tabpagebuflist(v:lnum)

    " Add '+' if one of the buffers in the tab page is modified
    for bufnr in bufnrlist
        if getbufvar(bufnr, "&modified")
            let label = '+'
            break
        endif
    endfor

    " Append the number of windows in the tab page if more than one
    let wincount = tabpagewinnr(v:lnum, '$')
    if wincount > 1
        let label .= wincount
    endif
    if label != ''
        let label .= ' '
    endif

    " Append the buffer name (not full path)
    return label . "%t"
endfunction
set guitablabel=%!GuiTabLabel()
"}}}

" ------- Misc key-bindings ------- {{{
" source or edit vimrc
:nmap ,s :execute 'source ~/vimrc.vim'
:nmap ,v :execute 'e ~/vimrc.vim'

" toggle invisibles
:nmap ,l :set list!<CR>

" Remove trailing spaces. ALSO - look at :retab to change tabs to spaces
:nmap _$ :% s_\s\+$__g <CR>
:vmap _$ :  s_\s\+$__g <CR>

:nmap ,r :set textwidth=78 <CR> gqap  " re-flow text to 78 columns

" Make F4 toggle NERDTree
" see: http://www.vim.org/scripts/script.php?script_id=1658
" switch between tree & edit window with Ctrl-W w
" ? = get help, o = open/close dir or open file, C = make dir new root
map <F4> :NERDTreeToggle<CR>

" Make F2 toggle line and column highlighting
map <F2> :set cursorline! cursorcolumn!<CR>

" Enter settings for Align plugin: see http://www.vim.org/scripts/script.php?script_id=294 and
" http://mysite.verizon.net/astronaut/vim/align.html
:nmap ,aa :AlignCtrl =lp1P0|
"}}}

" ---------------------------------------------------------------------
"      Disabled code, for reference {{{
" ---------------------------------------------------------------------

" -------- Network file editing -----
"if !has("unix") && has("gui_running")
  " For Windows, use pscp
"  let g:netrw_scp_cmd  = '"C:\Program Files (x86)\PuTTY\pscp.exe\" -q -batch'
"  let g:netrw_sftp_cmd = '"C:\Program Files (x86)\PuTTY\psftp.exe"'
"  let g:netrw_ssh_cmd = '"C:\Program Files (x86)\PuTTY\plink.exe -ssh"'
"  let g:netrw_scp_cmd  = 'pscp.exe -q -batch'
"  let g:netrw_sftp_cmd = 'psftp.exe'
"  let g:netrw_ssh_cmd = 'plink.exe -ssh'
""endif

"set rulerformat=%20(%l,%c%V%=%5(%p%%%)%)
" default rulerformat=%20(%l,%c%V%=%5(%p%%%)%)  see http://www.linux.com/archive/feature/120126 for some good ideas
" also see:
"      All I care about is if the file format is not unix. If it's not, I want a big red warning. That way I'm not the jerk who checks in a file that causes every line to get modified by the diff patch.
"      So, I added this to my existing statusline:
"        %9*%{&ff=='unix'?'':&ff.'\ format'}%*
"    from: http://vim.wikia.com/wiki/Change_end-of-line_format_for_dos-mac-unix

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" I don't know what this is for
"set diffexpr=MyDiff()
"function MyDiff()
"  let opt = '-a --binary '
"  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
"  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
"  let arg1 = v:fname_in
"  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
"  let arg2 = v:fname_new
"  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
"  let arg3 = v:fname_out
"  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
"  let eq = ''
"  if $VIMRUNTIME =~ ' '
"    if &sh =~ '\<cmd'
"      let cmd = '""' . $VIMRUNTIME . '\diff"'
"      let eq = '"'
"    else
"      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
"    endif
"  else
"    let cmd = $VIMRUNTIME . '\diff'
"  endif
"  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
"endfunction

" Example of search/replace string to make verilog instance from verilog ports
"320,345s:\(input\)\=\s*\(output\)\=\s*\(reg\)\=\s*\(\[.*\]\)\=\s*\(\S*\),:.\5 (\5),:cg

"  " edit ejava vhd and verilog files as vhdl/verilog
"  "    see: http://vimdoc.sourceforge.net/htmldoc/filetype.html#new-filetype
"  au BufRead,BufNewFile *_vhd.ejava	setfiletype vhdl
"  au BufRead,BufNewFile *_v.ejava	setfiletype verilog
"}}}

