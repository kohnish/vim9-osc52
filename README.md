vim9-osc52
=========

A minimal vim plugin for sending the default register as osc52 to copy texts to local clipboard on remote session like SSH or for vim compiled without X support.

Runtime requirements
--------------------
 - printf
 - base64
 - vim with vim9script support

Usage
-----
Installation:
```vim
# For users want to avoid installing anything
augroup OSC52Copy
    autocmd!
    autocmd TextYankPost * system("printf $'\\e]52;c;%s\\a' \"$(base64 <<(</dev/stdin))\" >> /dev/tty", v:event.regcontents)
augroup END


# Installing the plugin
mkdir -p ~/.vim/pack/plugins/start
cd ~/.vim/pack/plugins/start
git clone https://github.com/kohnish/vim9-osc52.git

# Configuration examples (vim9script):
# For users who want to copy every yank to clipaboard.
autocmd TextYankPost * g:Osc52CopyDefaultRegister()

# For users who want to toggle auto copy status
g:osc52_copy_enabled = 1
augroup OSC52Copy
    autocmd!
    autocmd TextYankPost * if get(g:, 'osc52_copy_enabled', 1) | g:Osc52CopyDefaultRegister() | endif
augroup END
def Osc52Toggle(): void
    if g:osc52_copy_enabled == 1
        g:osc52_copy_enabled = 0
    else
        g:osc52_copy_enabled = 1
    endif
enddef
command Osc52Toggle Osc52Toggle()
noremap <F4> :Osc52Toggle<CR>
```

Tmux configuration example for OSC52
```
set-option -g set-clipboard on
# For mac xsel -i should be replaced with pbcopy
set-hook -g 'pane-set-clipboard' "run-shell '(tmux show-buffer | xsel -i)'"
```

