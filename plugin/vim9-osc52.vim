vim9script

g:osc52_stdin_cmd = "printf $'\\e]52;c;%s\\a' \"$(base64 <<(</dev/stdin))\" >> /dev/tty"

def g:Osc52CopyDefaultRegister(): void
    system(g:osc52_stdin_cmd, getreg('"'))
enddef
