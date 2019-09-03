#/bin/zsh
_vroom_completions()
{
  pieces=($COMP_LINE)
  if [ "${pieces[$COMP_CWORD-1]}" != "-b" ] ; then
    return
  fi
  COMPREPLY=($(compgen -W "$(git branch -a | sed 's/[\* ]//g')" -- "${pieces[$COMP_CWORD]}"))
}
complete -F _vroom_completions vroom

