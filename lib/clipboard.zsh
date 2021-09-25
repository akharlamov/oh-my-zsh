# System clipboard integration
#
# This file has support for doing system clipboard copy and paste operations
# from the command line in a generic cross-platform fashion.
#
# On OS X and Windows, the main system clipboard or "pasteboard" is used. On other
# Unix-like OSes, this considers the X Windows CLIPBOARD selection to be the
# "system clipboard", and the X Windows `xclip` command must be installed.

# clipcopy - Copy data to clipboard
#
# Usage:
#
#  <command> | clipcopy    - copies stdin to clipboard
#
#  clipcopy <file>         - copies a file's contents to clipboard
#
function clipcopy() {
  emulate -L zsh
  local file=$1
  if [[ $OSTYPE == darwin* ]]; then
    if [[ -z $file ]]; then
      pbcopy
    else
      cat $file | pbcopy
    fi
  elif [[ $OSTYPE == (cygwin|msys)* ]]; then
    if [[ -z $file ]]; then
      cat > /dev/clipboard
    else
      cat $file > /dev/clipboard
    fi
  else
    if (( $+commands[xclip] )); then
      if [[ -z $file ]]; then
        xclip -in -selection clipboard
      else
        xclip -in -selection clipboard $file
      fi
    elif (( $+commands[xsel] )); then
      if [[ -z $file ]]; then
        xsel --clipboard --input 
      else
        cat "$file" | xsel --clipboard --input
      fi
    else
      print "clipcopy: Platform $OSTYPE not supported or xclip/xsel not installed" >&2
      return 1
    fi
  fi
}

# clippaste - "Paste" data from clipboard to stdout
#
# Usage:
#
#   clippaste   - writes clipboard's contents to stdout
#
#   clippaste | <command>    - pastes contents and pipes it to another process
#
#   clippaste > <file>      - paste contents to a file
#
# Examples:
#
#   # Pipe to another process
#   clippaste | grep foo
#
#   # Paste to a file
#   clippaste > file.txt
function clippaste() {
  emulate -L zsh

  if [[ "${OSTYPE}" == darwin* ]] && (( ${+commands[pbcopy]} )) && (( ${+commands[pbpaste]} )); then
    function clipcopy() { pbcopy < "${1:-/dev/stdin}"; }
    function clippaste() { pbpaste; }
  elif [[ "${OSTYPE}" == (cygwin|msys)* ]]; then
    function clipcopy() { cat "${1:-/dev/stdin}" > /dev/clipboard; }
    function clippaste() { cat /dev/clipboard; }
  elif [ -n "${WAYLAND_DISPLAY:-}" ] && (( ${+commands[wl-copy]} )) && (( ${+commands[wl-paste]} )); then
    function clipcopy() { wl-copy < "${1:-/dev/stdin}"; }
    function clippaste() { wl-paste; }
  elif [ -n "${DISPLAY:-}" ] && (( ${+commands[xclip]} )); then
    function clipcopy() { xclip -in -selection clipboard < "${1:-/dev/stdin}"; }
    function clippaste() { xclip -out -selection clipboard; }
  elif [ -n "${DISPLAY:-}" ] && (( ${+commands[xsel]} )); then
    function clipcopy() { xsel --clipboard --input < "${1:-/dev/stdin}"; }
    function clippaste() { xsel --clipboard --output; }
  elif (( ${+commands[lemonade]} )); then
    function clipcopy() { lemonade copy < "${1:-/dev/stdin}"; }
    function clippaste() { lemonade paste; }
  elif (( ${+commands[doitclient]} )); then
    function clipcopy() { doitclient wclip < "${1:-/dev/stdin}"; }
    function clippaste() { doitclient wclip -r; }
  elif (( ${+commands[win32yank]} )); then
    function clipcopy() { win32yank -i < "${1:-/dev/stdin}"; }
    function clippaste() { win32yank -o; }
  elif [[ $OSTYPE == linux-android* ]] && (( $+commands[termux-clipboard-set] )); then
    function clipcopy() { termux-clipboard-set < "${1:-/dev/stdin}"; }
    function clippaste() { termux-clipboard-get; }
  elif [ -n "${TMUX:-}" ] && (( ${+commands[tmux]} )); then
    function clipcopy() { tmux load-buffer "${1:--}"; }
    function clippaste() { tmux save-buffer -; }
  elif [[ $(uname -r) = *icrosoft* ]]; then
    function clipcopy() { clip.exe < "${1:-/dev/stdin}"; }
    function clippaste() { powershell.exe -noprofile -command Get-Clipboard; }
  else
    if (( $+commands[xclip] )); then
      xclip -out -selection clipboard
    elif (( $+commands[xsel] )); then
      xsel --clipboard --output
    else
      print "clipcopy: Platform $OSTYPE not supported or xclip/xsel not installed" >&2
      return 1
    fi
  fi
}
