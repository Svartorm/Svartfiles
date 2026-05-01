##### Init Scripts #####
source ~/.zsh/zsh_init

##### Shell Prompt #####
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

##### Aliases #####
source ~/.zsh/zsh_aliases

##### Scripts #####
for SCRIPT in ~/.zsh/scripts/*; do
	source $SCRIPT
done
