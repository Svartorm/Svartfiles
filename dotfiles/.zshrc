##### Init Scripts #####
source ~/.zsh/zsh_init

##### Aliases #####
source ~/.zsh/zsh_aliases

##### Scripts #####
for SCRIPT in ~/.zsh/scripts/*; do
	source $SCRIPT
done
