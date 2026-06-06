DIRSTACKSIZE=30
DIRSTACKFILE=~/.cache/zsh/dirstack

mkdir -p $(dirname $DIRSTACKFILE)
touch $DIRSTACKFILE

# The load dirs into stack from given file.
if [[ -f $DIRSTACKFILE && $#dirstack -eq 0 ]]; then
    dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
    [[ -d $dirstack[1] ]] && cd $dirstack[1] && cd $OLDPWD
fi

# store dirs stack on dir change
function chpwd () {
    print -l $PWD ${(u)dirstack} > $DIRSTACKFILE
}

# DIRSTACK
setopt autopushd pushdsilent pushdtohome
setopt pushdignoredups
