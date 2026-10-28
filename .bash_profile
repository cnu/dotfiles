#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

. "$HOME/.local/share/../bin/env"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# >>> railway initialize >>>
source "$HOME/.railway/env"
# <<< railway initialize <<<

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/cnu/.lmstudio/bin"
# End of LM Studio CLI section

