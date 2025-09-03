#!/bin/bash

#todo
#vim
#vim config
#tmux config
#bashrc
#instructions/resources on how to use

# VIM

cd ~
git clone https://github.com/vim/vim
cd vim/src
# LDFLAGS idk command yet
LDFLAGS=-L$HOME/usr/local/lib ./configure --enable-python3interp --prefix=$HOME/usr/local
make 
make install

# installing plug 
curl -fLo ~/.vim/autoload/plug.vim --create-dirs     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# vimrc

echo "let mapleader = \" \"

set number

set background=dark
autocmd FileType c setlocal cindent
autocmd FileType c setlocal autoindent

autocmd FileType c setlocal cinoptions==>4,n-2,{2,^-2,:s,=s,l1,gs,hs,ts,is,bs

autocmd FileType c setlocal shiftwidth=6
autocmd FileType c setlocal tabstop=6


call plug#begin('~/.vim/plugged')

Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --clangd-completer' } 
Plug 'morhetz/gruvbox'
Plug 'liuchengxu/vim-which-key'
Plug 'sheerun/vim-polyglot'
Plug 'ojroques/vim-oscyank', {'branch': 'main'}

call plug#end()

nmap <leader>c <Plug>OSCYankOperator
nmap <leader>cc <leader>c_
vmap <leader>c <Plug>OSCYankVisual

let g:ycm_key_invoke_completion = '<C-Space>'

let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_enabled = 1

nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
let g:which_key_timeout = 200 

let g:gruvbox_contrast_dark= 'hard'
colorscheme gruvbox" > ~/.vimrc

# tmux conf 
echo "bind r source-file ~/.tmux.conf
set-window-option -g mode-keys vi
set-option -g allow-rename off
bind-key -T copy-mode-vi 'v' send -X begin-selection
bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel

set -s set-clipboard external

set -g base-index 1
setw -g pane-base-index 1

set -g pane-border-style fg=#5b5b5b
set -g pane-active-border-style \"bg=default fg=#8e90f9\"

set -g status-position top
set -g status-justify absolute-centre
set -g status-style 'fg=default bg=default'
set -g status-right ''
set -g status-right-length 0 
set-option -g status-left '[#S] [#P]'
set -g status-left-length 100
setw -g window-status-current-style 'fg=WHITE bg=default bold'
setw -g window-status-current-format '#I:#W '
setw -g window-status-style 'fg=WHITE'

bind -r ^ last-window
bind -r k select-pane -U
bind -r j select-pane -D
bind -r h select-pane -L
bind -r l select-pane -R

run-shell ~/clone/path/resurrect.tmux" > ~/.tmux.conf

git clone https://github.com/tmux-plugins/tmux-resurrect ~/clone/path

# bashrc setup via bash_profile linking to it

echo "alias vim='~/usr/local/bin/vim'" >> ~/.bashrc
echo '' >> ~/.bash_profile
echo 'if [ -f ~/.bashrc ]; then' >> ~/.bash_profile
echo '    . ~/.bashrc' >> ~/.bash_profile
echo 'fi' >> ~/.bash_profile

rm -rf vim 
# INSTRUCTIONS 

echo "Thank you for installing!! Firstly, I am going to give a TLDR for people who already are familiar with these tools, just to know where the locations of stuff is.
vim config; ~/.vimrc
bash config; ~/.bashrc
vim bin file; ~/usr/local/bin/vim 
tmux config; ~/.tmux.conf

VIMOSC-YANK is on leader + c
leader is default on spacebar
PLEASE DOWNLOAD THE PLUGINS FOR VIM. [esc][:PlugInstall]
This will give you colours and plugins! If you want, but I explain it later; download lsp via [:LspInstallServer]

=============================================
======== Resources // Quick tutorial ========
=============================================


Hi! You're in vim right now! First, you should read through this, until I tell you to open tmux!
>>>>>>BASIC MOVING AROUND IN VIM<<<<<<<
   k
h	l 
   j
h to go left. j to go down. k to go up. l to go right!
Get used to these, as it is easier than using your mouse to to move around!
The idea behind vim is to reduce the time between typing out lines of code // making it feel more flowly and allowing for more macros. Similar to the ones you could find in something like excel.
To go from input mode (normal typing) to command mode, press [esc]. To go to normal mode from input mode, press [i]!

So make sure you understand how it works!! You don't have to use everything but at least having a small foundation could be nice, as you may stumble around or find some command that could be useful for you.

Okay,now lets start with tmux!

NOTE;
ALL COMMANDS WILL BE PUT IN [COMMAND] BRACKETS TO MAKE IT EASIER TO SEE. I use <field> to denote things you have to write yourself. Do NOT forget the '' if there is a space in the field

===============================================
===============================================
=================== Tmux ======================
===============================================
===============================================

Simply, tmux allows you to have multiple terminals at once.
To make a new session; type out the command [tmux] or [tmux new], or with a session name [tmux new -s 'session name']
As an educational/useful test. I would like you to open up this set of instructions with [vim ~/vim_tmux_script_resources.txt] in the tmux environment.

ORDER OF COMMANDS (assuming you're still in vim. IN NORMAL MODE. If not, press [esc])
[:q] to quit vim
[tmux] to open tmux
[vim ~/vim_tmux_script_resources.txt]

==============

Now lets start playing with tmux.
To make a new 'Pane', which is essentially an extra terminal. 
Type [ctrl-b + %] for a horizontal split pane
Type [ctrl-b + \"] for a vertical split pane

To swap between panes;
Type [ctrl-b + h/j/k/l], just like moving in vim 
To remove panes;
Type [ctrl-b + x]

Now, we will make new 'Windows', which is essentially extra 'Tabs'
[ctrl-b + c] to make a new window 
[ctrl-b + ,] to reanme the window 
[ctrl-b + 1..9] to swap between windows

You can make multiple sessions of tmux. I will not explain it here, but you can swap between them with [ctrl-b + (] and [ctrl-b + )]. 

We have a tmux plugin called tmux_ressurection which allows us to save our sessions that last after reboot! 
To save, [ctrl-b ctrl-s]
To load, [ctrl-b ctrl-r]

===============================================
===============================================
=================== VIM =======================
===============================================
===============================================

There's a lot to go over. I want to to make a new pane and make a new file with the command [vim test_file.txt]. 
We will quickly go over some simple commands and then point you towards resources.

========================
== Quiting and Saving == 
========================
In Normal Mode; (press [esc] if youre not sure)
To quit vim, do [:q]. 
To save do [:w]
To save and quit do [:wq]

======================================
==== SETUP (must do! for plugins) ====
======================================

In vim, type [:PlugInstall] for plugins.
To install your LSP via YouCompleteMe, type [:LspInstallServer]
You can press tab to autocomplete these commands btw!

Now [:q] to leave vim, and then open it back up so everything is installed!

========================
== Normal Mode Basics ==
========================

First, go to insert mode with [i]. And then type out any sentence with multiple words. Go back to Normal mode with [esc]
To move around word by word. 
Forwards to start of next word, [w].
Forwards to end of current word, [e]
Backwards to the start of the previous word [b]

To go to the next instance of a character write [f + <character>]. For example you want to go to the next , in the sentence, typing [f,] brings you there. 
To go back, you use [F + <character] instead!

To go to the start of a line, [0]
To go to the end of a line, [$]

To hop between parentheses, use [%]
To hop between paragraphs, use [{] or [}] 

To go to a certain line, write [<line number> + g]. To go to the top, [g + g], and the bottom [G]

================================
== Visual Mode / Copy Pasting ==
================================

To select the entire section of words you made; enter Visual mode via [v]
Now, move around with h/j/k/l/w/e/b, and then once you're finished your selection. I want you to copy the text; this is done in Normal mode
To copy a word, [y]
To copy to your system, [space + c] using vim-oscyank 


Now, in normal mode to paste it on the current line, [p]. As well, [P] keeps it in your clipboard. (I recommend using [P] 99% of the time over [p] because its easy to accidentally delete your current clipboard item otherwise)

===================
== Deleting Text == 
===================

To delete text, you can be in visual mode and select it, and then press [d]
You can also do [d + w/e/b] for deleting words. To delete a line, do [dd].

==============================
== Multiple commands in row ==
==============================

With ALL of these commands, you can do them multiple times in a row, so for example [10 + l] will bring you 10 lines down. [10 + d + w] will delete the next 10 words. etc etc.

========================
== Insert Mode extras ==
========================

To make a new line below your current line and then put you into Insert mode, [o]
For above; [O]

To go into Insert mode at the end of a line, [A]
To go into Intert mode before your current character, [a] (compared to [i], which puts you after your current character)

============
== FINDER == 
============
To do the ctrl+f finder thing. You write /<word> and then press enter to 'lock it in'. Then use N/n to go forward and back. To remove the current highlighting, type [:noh] in normal mode

============= A BIT MORE ADNVANCED =================

=================================
== Marks <-------- VERY USEFUL == 
=================================

To set a mark, type [m + <some letter>]. To jump back to said mark, type [' + <said letter>]. Try it out, do [m + a] on the middle of the document. Go to the top, type out [' + a] and then you jump back there! It's really handy for having marks at certain important points (ex. main function, certain important functions/structs, etc.)

===================
== Simple Macros == 
===================

To start recording a macro, write [q + <command letter>] and then do the movements/deletions/pastings you want. To end recording press [q] again. 
To replay a macro, write [@ + <command letter>].

In this case, I want you to try this out, for example you can write [qw] to start recording, [v $ y o esc P] as your command, and then [q] to to stop recording. When you now write [@w] you select the whole line, copy it, and then paste it underneath. If you want to run this command multiple times, you could do like [3@w] 

============= Super basic config stuff ==============
vim config is in ~/.vimrc, for example you can change your theme with colorscheme <theme_name>. And new plugins via [Plug '<github link>']. For everything else you should look at learnvim resource.

================================================================
================================================================
========================== RESOURCES ===========================
================================================================
================================================================

=== TMUX ===
I like this website, it tells you just a bunch of the easier/simpler commands for tmux. It's really all you need though! I recommend looking at this if you are lost about something.
https://tmuxcheatsheet.com/

==== VIM ====
In vim, [:vimtutor] to learn basics. If its not there, you can run it in your terminal via [sh ~/usr/local/bin/vimtutor]

This is kind of silly, but it can be useful; 
https://openvim.com/

This website is geuinely the best resource though. 
https://learnvim.irian.to/" > ~/vim_tmux_script_resources.txt

vim ~/vim_tmux_script_resources.txt
