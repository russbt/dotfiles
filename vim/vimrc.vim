" Russ' VIM setup script
" Last update: 11/17/14
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
"     <F7>                   : Make a commented-out copy of the current line
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
"     <Ctrl>-<Space>         : Toggle fold
"     <Ctrl>-<LeftMouse>     : Rectangle-select
"     ,l                     : Toggle showing invisibles (in "normal") mode
"     <F2>                   : Toggle row/column crosshairs
"     ,t                     : Toggle "tail -F" mode
"
" Other useful commands:
"   :Align                   : Align parts of lines to the same column
"   :Search                  : Multi-search (with multiple colors)

" ------- General ------- {{{
"
set nocompatible       " Enable VIM features that aren't in VI
set hidden             " Allow switching between files without having to save first
set undolevels=1000    " lots of undo
set history=200        " keep 200 lines of command line history
set ruler              " show the cursor position all the time
set showcmd            " display incomplete commands
"set nofoldenable       " don't allow code-folding
let strip_trailing_on_save=0 " enable/disable stripping of trailing whitespace on save
set diffopt+=iwhite    " ignore whitespace in diff mode
if !has("unix") && has("gui_running")
  " For Windows only, keep swap files on local drive to avoid "Delayed Write Failed" errors
  set dir=c:\\temp
  set dir+=$TEMP
endif
if has("autocmd")
  " Remove existing autocmds when .vimrc is re-sourced
  :autocmd!
endif
"}}}

" ------- Plugin Manger (Vim-Plug) ------- {{{
" See: https://github.com/junegunn/vim-plug
" To install plugins, call :PlugInstall
" To update plugins, call :PlugUpdate
" 
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" CSV - currently disabled
"Plug 'chrisbra/csv.vim'

" Initialize plugin system
call plug#end()

"}}}

" ------- Indenting/tabs ------- {{{
set shiftwidth=2   " default to 2 spaces
set softtabstop=2  " default to 2 spaces
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
"    This font should be available (free) on anything modern-ish:
"        https://fonts.google.com/specimen/Inconsolata

" Font selection
if has("gui_running")
  if has("gui_gtk2")
    " Redhat, etc
    set guifont=Consolas\ 12,Inconsolata\ 12,Monospace\ 12
  elseif has("gui_macvim")
    " MacVim (OS X)
    set guifont=Consolas:h18,Inconsolata:h18
  elseif has("X11")
    " Some other unix-y flavor
    set guifont=Consolas\ 12,Inconsolata\ 12,Monospace\ 12,-adobe-courier-medium-r-normal-*-*-140-*-*-m-*-iso10646-1
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
    let s:maxfontsize = 24
    let leading = substitute(&guifont, s:pattern, '\1', '')
    let cursize = substitute(&guifont, s:pattern, '\2', '')
    let trailing = substitute(&guifont, s:pattern, '\3', '')
    let newsize = cursize + a:amount
    if (newsize >= s:minfontsize) && (newsize <= s:maxfontsize)
      let newfont = leading . newsize . trailing
      let &guifont = newfont
      " Note: need the redraw first, so a postponed-redraw doesn't clear the
      " output of echo
      redraw | echom "New font size: " . newsize
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
  if (exists(':SearchReset'))
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

  " toggle fold with ctrl-space
  nmap <C-Space> za
  inoremap <C-Space> za

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
  :set lines=40 columns=120
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
"   (Temorarily? disabled by commenting-out the autocommand line - RCN 2016/12/5
" Toggle highlighting of special characters with <F3>
if has("autocmd")
  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcExSpaceHi
  " and delete existing autocmds in this group (in case vimrc is re-sourced)
  au!

"  autocmd BufNewFile,BufReadPost,FilterReadPost,FileReadPost,Syntax * SpaceHi
  au FileType help NoSpaceHi
  augroup END
endif
"}}}

" ------- File-type specific setup ------- {{{
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcExFT
  " and delete existing autocmds in this group (in case vimrc is re-sourced)
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
  autocmd FileType python setlocal shiftwidth=2 softtabstop=2
  autocmd FileType verilog setlocal shiftwidth=2 softtabstop=2
  autocmd FileType verilog_systemverilog setlocal shiftwidth=2 softtabstop=2
  autocmd FileType cpp setlocal shiftwidth=2 softtabstop=2
  autocmd FileType c setlocal shiftwidth=2 softtabstop=2

  " Function to strip trailing whitespace and then return cursor to former
  " position
  fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
  endfun

  " Automatically strip trailing white space on save
  if (strip_trailing_on_save==1)
    autocmd FileType c,cpp,java,php,ruby,python,verilog,verilog_systemverilog autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
  endif
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
if has("gui")
    let notabs = 0                       " Start with tabs enabled
    set tabpagemax=99                    " Effectively no max number of tabs
    set switchbuf=usetab,newtab          " New buffers open in a tab
    " Ctrl-Tab switches to the next tab
    :nnoremap <C-Tab> :sbnext<CR>
    " Ctrl-Shift-Tab switches to previous tab
    :nnoremap <S-C-Tab> :sbprevious<CR>
    nnoremap <silent> <F8> :let notabs=!notabs<Bar>:if notabs<Bar>:tabo<Bar>:else<Bar>:tab ball<Bar>:tabn<Bar>:endif<CR>
         " F8 switches between buffers in tabs or not (good for fixing when tabs
         " get messed up)
         "
    " Disable the built-in "tabe" command, since it doesn't play nice with the
    " auto-tab stuff below
    :cabbrev tabe <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'e' : 'tabe')<CR>

    if has("autocmd")
      " Put these in an autocmd group, so that we can delete them easily.
      augroup vimrcExWinTab
      " and delete existing autocmds in this group (in case vimrc is re-sourced)
      au!
      " All newly opened or created buffers open in a tab
      au BufAdd,BufNewFile,VimEnter * nested tab sball
      augroup END
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
endif
"}}}

" ------- Misc key-bindings ------- {{{
" source or edit vimrc
:nmap ,s :execute 'source ~/vimrc.vim'
:nmap ,v :execute 'e ~/vimrc.vim'

" toggle invisibles
:nmap ,l :set list!<CR>

" Remove trailing spaces. ALSO - look at :retab to change tabs to spaces
:nmap _$ :call <SID>StripTrailingWhitespaces()<CR>
:vmap _$ :  s_\s\+$__g <CR>

:nmap ,r :set textwidth=78 <CR> gqap  " re-flow text to 78 columns

" Toggle 'tail' mode for current buffer
function! <SID>TailToggle()
  if exists('b:tail_timer_id')
    call tail#stop_tail()
    TabooReset
  else
    call tail#start_tail()
    TabooRename %f (F)
  endif
endfunction
:nmap ,t :call <SID>TailToggle()<CR>

" Make F7 duplicate the current line, with a // comment at the beginning
" TODO: make the comment-charater be filetype-specific
fun! <SID>DuplicateCommentedLine()
  let l = line(".")
  let c = col(".")
  normal yyp
  call cursor(l, 0)
  normal I//
  call cursor(l+1, c)
endfun
nmap <F7> :call <SID>DuplicateCommentedLine()<CR>
imap <F7> <ESC>:call <SID>DuplicateCommentedLine()<CR>li

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

" ------- Compatibility ------- {{{
" Handle arrow-key mapping within tmux
if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif
" }}}

" ------- Random utilities ------- {{{

" Convert between Hex & Decimal
" From: http://vim.wikia.com/wiki/Convert_between_hex_and_decimal
" 
command! -nargs=? -range Dec2hex call s:Dec2hex(<line1>, <line2>, '<args>')
function! s:Dec2hex(line1, line2, arg) range
  if empty(a:arg)
    if histget(':', -1) =~# "^'<,'>" && visualmode() !=# 'V'
      let cmd = 's/\%V\<\d\+\>/\=printf("0x%x",submatch(0)+0)/g'
    else
      let cmd = 's/\<\d\+\>/\=printf("0x%x",submatch(0)+0)/g'
    endif
    try
      execute a:line1 . ',' . a:line2 . cmd
    catch
      echo 'Error: No decimal number found'
    endtry
  else
    echo printf('%x', a:arg + 0)
  endif
endfunction

command! -nargs=? -range Hex2dec call s:Hex2dec(<line1>, <line2>, '<args>')
function! s:Hex2dec(line1, line2, arg) range
  if empty(a:arg)
    if histget(':', -1) =~# "^'<,'>" && visualmode() !=# 'V'
      let cmd = 's/\%V0x\x\+/\=submatch(0)+0/g'
    else
      let cmd = 's/0x\x\+/\=submatch(0)+0/g'
    endif
    try
      execute a:line1 . ',' . a:line2 . cmd
    catch
      echo 'Error: No hex number starting "0x" found'
    endtry
  else
    echo (a:arg =~? '^0x') ? a:arg + 0 : ('0x'.a:arg) + 0
  endif
endfunction
" }}}

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
"
"  " Remove trailing spaces. ALSO - look at :retab to change tabs to spaces
"  :nmap _$ :% s_\s\+$__g <CR>
"  :vmap _$ :  s_\s\+$__g <CR>
"
"}}}


