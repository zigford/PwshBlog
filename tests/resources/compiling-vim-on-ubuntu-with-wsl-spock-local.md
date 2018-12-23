Compiling VIM on Ubuntu with WSL

As a Windows Admin by day, but a longtime vim and linux user, I've flocked to
Microsoft's [WSL](https://en.wikipedia.org/wiki/Windows_Subsystem_for_Linux)
like a moth to the flame. 

Being a heavy vim user with a distaste for tmux (due to the incompatible
keybindings, PS, I know they can be changed to somewhat match vim), I was very
excited to hear about vim's new terminal feature in version 8.1!! I immediatley
installed the latest vim in Windows and it's cool. However I want a matching
linux version in the WSL, so I thought I'd write this quick article on compiling
for Ubuntu 18.04.

# Preperation

You will need to install a few dev packages and build tools 
before we get started. The WSL file-system isn't known for
it's speed, so do this prep work in the background while doing
something else.

_Note, this build is doesn't contain any
requiremnts to build with the gui. If your looking for that, 
try [here](https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source)_

```
sudo apt-get update sudo apt-get install libncurses5-dev libatk1.0-dev python3-dev ruby-dev lua5.3-0 lua5.3-dev libperl-dev git build-essential
```

Clone the vim source tree 

```
mkdir src cd src git clone https://github.com/vim/vim
```

Configure the source 

```
./configure --with-compiledby="${USER}@$(hostname)" --enable-terminal --enable-python3interp --enable-perlinterp --enable-luainterp --disable-gui make
```

Install vim 

```
sudo make install
```

Now go off into the sunset and happily vim.

Tags: vim, ubuntu, wsl
