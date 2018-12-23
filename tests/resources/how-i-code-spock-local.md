How I Code

###Updated 17/08/2018

Coding can be fun. I've enjoyed coding from a young age, starting with
[GW-Basic](https://en.m.wikipedia.org/wiki/GW-BASIC) at maybe 6, 7, or 8.

I remember my brother Alex seemed like a real genius with the computer (an IBM
clone made by Acer 8086 XT). Using Basic he could make the computer do anything
and was writing his own games.

Back then, how we edited code would make us laugh today and I would say we take
the humble text editor for granted. Even something like notepad.exe is amazing
compared to tools of yesteryear. Here is a sample to illustrate: 
To see your code you would have to type `LIST<ENTER>`:   

        >LIST

        10 PRINT "WELCOME TO JESSES GAME"
        20 PRINT "ENTER YOUR NAME"
        30 $I = INPUT
        40 PRINT "WELCOME $I, STRAP YOURSELF IN"

To edit a line of code you would re-write it by typing it in, line number and 
all.

        20 PRINT "ENTER YOUR FULL NAME"

And to insert a line, start a line with a number between existing lines

        31 $A=$I

When you ran out of in-between-lines there was a command you could run to
reindex your lines which would space them all out 10 between each other.

Since then, the notepad, notepad++, programmers notepad, vim, nano, gedit, 
bbedit and countless other advanced (or not-so-advanced) text editors have
evolved.

vi was born out of ed a streaming text editor which didn't really have a user
interface so it was kind of more like how I edited my BASIC programs. One thing 
it did have were commands. Example of vim commands:

You've just run your script/app and get a syntax error on line 432. 

>      PS> .\bigscript.ps1
>      At C:\bigscript.ps1:432 char:27
>      + if ($true) {echo "True" | {echo true}}
>      +                           ~~~~~~~~~~~
>      Expressions are only allowed as the first element of a pipeline.
>      + CategoryInfo          : ParserError: (:) [], ParseException
>      + FullyQualifiedErrorId : ExpressionsMustBeFirstInPipeline

So you crack open bigscript in vim (btw, vim is amazing at handling big files)
Enter, `432Gf|a?<ESC>:wq` done.

To break that down, `432G` will put the cursor at line 432, `f|` will move the 
cursor _forward_ to the `|`, `a?` will _append_ a `?`, then \<ESC> will return
vim back to normal mode and `:wq` puts vim in command mode and execute _w_rite
_q_uit. 

Now that might seem a bit obtuse if your not a vim user, but to me that is
muscle memory and if coding is your life, this is something you are going to
want to learn.

If this interests you, and you start your vim journey, then read on. I will
share my vim configuration and history of using vim.

My vim story
---

When my Dad was about the same age as I am now (35), he went back to 
University to study Computer Science. I remember him bringing home Slackware 
and RedHat on floppies, which we would install and he would give me lessons on 
using Vi possibly vim, but I didn't know at the time.  (This is probably around
1996).

Since finishing School and entering the workforce I have mostly worked in
Windows environments. Even still, with the occasionaly need to touch GNU/Linux
at work and often testing Distro's at home I would always feel more efficient
when using Vi/m.

My feeling when using another editor is that moving around and changing text
feels so lethargic when done one button at a time. This drove me in recent
years to keep a copy of vim in my home profile.

Around 2011 I switched from VBScript and the occasional perl script to writing
fulltime in Powershell, so it made sense to try a few different editors which
are more native to the Windows platform. I tried Visual Studio Code, Powershell
ISE, Notepad++ and still kept coming back to vim.

Visual Studio Code is a great alternative, and it's Powershell extensions are
very good. If you do choose to use it, install the vim extension too. It brings 
the vim commands to vscode.
Hoever being an electron app, it suffers from performance and memory
consumption issues. I love squeezing every drop of battery out of my PC and
when you see 7mb RAM on Vim vs 500Mb+ on VSCode, you might rethink your
choices.

Therefore I've resorted to delving into the world of customizing vim and 
setting up plugins.

One of the main things I'm trying to acheive is a cross platform configuration.
You see, at work I'm on Windows and MacOs and at home I'm on Gentoo Linux. So I
have written my .vimrc file to work on any platform. I usually sync it with 
OneDrive for Business and symlink it into my linux/mac/Windows home directory 
with a seperate setup script.  Without further ado, here it is with some
comments

##.vimrc

    if has("win32")                               " Check if on windows \
                                                  " Also supports has(unix)
        source $VIMRUNTIME/mswin.vim              " Load a special vimscript \
                                                  " ctrl+c and ctrl+v support
        behave mswin                              " Like above
        set ff=dos                                " Set file format to dos
        let os='win'                              " Set os var to win
        set noeol                                 " Don't add an extra line \
                                                  " at the end of each file
        set nofixeol                              " Disable the fixeol : Not \
                                                  " not sure why this is needed
        set backupdir=~/_vimtmp,.                 " Set backupdir rather \
                                                  " than leaving backup files \
                                                  " all over the fs
        set directory=~/_vimtmp,.                 " Set dir for swp files \
                                                  " rather than leaving files \
                                                  " all over the fs
        set undodir=$USERPROFILE/vimfiles/VIM_UNDO_FILES " Set persistent undo\
                                                  " files
                                                  " directory
        let plug='$USERPROFILE/.vim'              " Setup a var used later to \
                                                  " store plugins
        set shell=powershell                      " Set shell to powershell \
                                                  " on windows
        set shellcmdflag=-command                 " Arg for powrshell to run
    else
        set backupdir=~/.vimtmp,.
        set directory=~/.vimtmp,.
        set undodir=$HOME/.vim/VIM_UNDO_FILES
        let uname = system('uname')               " Check variant of Unix \
                                                  " running. Linux|Macos
        if uname =~ "Darwin"                      " If MacOS
            let plug='~/.vim'
            let os='mac'                          " Set os var to mac
        else
            if isdirectory('/mnt/c/Users/jpharris')
                let plug='/mnt/c/Users/jpharris/.vim'
                let os='wsl'
            else
                let plug='~/.vim'
                let os='lin'
            endif
        endif
    endif

    execute "source " . plug . "/autoload/plug.vim"
    if exists('*plug#begin')
        call plug#begin(plug . '/plugged')       " Enable the following plugins
        Plug 'tpope/vim-fugitive'
        Plug 'junegunn/gv.vim'
        Plug 'junegunn/vim-easy-align'
        Plug 'jiangmiao/auto-pairs'
        "Plug 'vim-airline/vim-airline'          " Airline disabled for perf
        Plug 'morhetz/gruvbox'
        Plug 'ervandew/supertab'
        Plug 'tomtom/tlib_vim'
        Plug 'MarcWeber/vim-addon-mw-utils'
        Plug 'PProvost/vim-ps1'
        Plug 'garbas/vim-snipmate'
        Plug 'honza/vim-snippets'
        call plug#end()
    endif
                                                 " Remove menu bars
    if has("gui_running")                        " Options for gvim only
        set guioptions -=m                       " Disable menubar
        set guioptions -=T                       " Disable Status bar
        set lines=50                             " Set default of lines
        set columns=80                          " Set default of columns
        if os =~ "lin"
            set guifont=Fira\ Code\ 12
        elseif os =~ "mac"
            set guifont=FiraCode-Retina:h14
        else
            set guifont=Fira_Code_Retina:h12:cANSI:qDRAFT
            set renderoptions=type:directx
            set encoding=utf-8
        endif
        set background=dark
        colorscheme gruvbox
    else
        set mouse=a
        if has('termguicolors')
            set termguicolors                    " Enable termguicolors for \
                                                 " consoles which support 256.
            set background=dark
            colorscheme gruvbox
        endif
    endif

    if has("persistent_undo")
        set undofile                             " Enable persistent undo
    endif

    colorscheme evening                          " Set the default colorscheme
                                                 " Attempt to start vim-plug

    syntax on                                    " Enable syntax highlighting
    filetype plugin indent on                    " Enable plugin based auto \
                                                 " indent
    set tabstop=4                                " show existing tab with 4 \
                                                 " spaces width
    set shiftwidth=4                             " when indenting with '>', \
                                                 " use 4 spaces width
    set expandtab                                " On pressing tab, insert 4 \
                                                 " spaces
    set number                                   " Show line numbers

    " Map F5 to python.exe %=current file
    nnoremap <silent> <F5> :!clear;python %<CR>
    " Remap tab to auto complete 
    imap <C-@> <C-Space>
    " Setup ga shortcut for easyaline in visual mode
    nmap ga <Plug>(EasyAlign)
    " Setup ga shortcut for easyaline in normal mode
    xmap ga <Plug>(EasyAlign)"
 
[Link to vimrc on github](https://github.com/zigford/vim)

Tags: vim, coding, windows, linux, macos
