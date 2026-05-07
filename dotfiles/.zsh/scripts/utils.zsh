# Easy way to extract/create archives
alias mktar='tar -cvf'
alias mkbz2='tar -cvjf'
alias mkgz='tar -cvzf'
function extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1;;
           *.tar.gz)    tar xvzf $1;;
           *.bz2)       bunzip2 $1 ;;
           *.rar)       unrar x $1 ;;
           *.gz)        gunzip $1  ;;
           *.tar)       tar xvf $1 ;;
           *.tbz2)      tar xvjf $1;;
           *.tgz)       tar xvzf $1;;
           *.zip)       unzip $1   ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1;;
           *) echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
}

## Moving files
# Copy file with a progress bar
function cpp()
{
	set -e
	strace -q -ewrite cp -r -- "${1}" "${2}" 2>&1 \
	| awk '{
	count += $NF
	if (count % 10 == 0) {
		percent = count / total_size * 100
		printf "%3d%% [", percent
		for (i=0;i<=percent;i++)
			printf "="
			printf ">"
			for (i=percent;i<100;i++)
				printf " "
				printf "]\r"
			}
		}
	END { print "" }' total_size=$(stat -c '%s' "${1}") count=0
}

# Copy and go to the directory
function cpg ()
{
	if [ -d "$2" ];then
		cp -r $1 $2 && cd $2
	else
		cp -r $1 $2
	fi
}

# Move and go to the directory
function mvg ()
{
	if [ -d "$2" ];then
		mv -r $1 $2 && cd $2
	else
		mv -r $1 $2
	fi
}

# Create and go to the directory
function mkdirg ()
{
	mkdir -p $1
	cd $1
}

function translate() {
  wget -U "Mozilla/5.0" -qO - "http://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=$2&dt=t&q=$(echo $1 | sed "s/[\"'<>]//g")" | sed "s/,,,0]],,.*//g" | awk -F'"' '{print $2, $6}';
}

alias busy="cat /dev/urandom | hexdump -C | grep 'ca fe'"

function discordupdate ()
{
  sudo pacman -Syy
  sudo pacman -Sy discord 
  sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"
}

function pasteimage ()
{
  wl-paste >> "$1.png"
}
