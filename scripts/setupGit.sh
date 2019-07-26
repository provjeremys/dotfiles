#!/bin/sh

usage="$(basename "$0") Creates new SSH tokens and hostnames for one or more GitHub accounts.

If you want to add a new secondary account, enter 2 or more for the number of accounts and use 'skip' for the first account username.
 
This command takes no arguments."

while getopts ':hn' option; do
  case "$option" in
    h) echo "$usage"
       exit
       ;;
  esac
done

echo "Setting up Git"
read -p "How many git accounts? " gitCount
if [ $gitCount -gt 1 ] ; then
  echo "
The first github account will be the 'default', meaning if you
don't change the domain during cloning from 'github.com', that will be used.
All others will require you to change to 'github.com-<username>.

If you want to add a new secondary account, enter 2 or more for the number 
of accounts and use 'skip' for the first account username."
fi
if [ $gitCount -gt 0 ] ; then
  eval "$(ssh-agent -s)" > /dev/null
  for i in $(seq 1 $gitCount); do
    read -p "GitHub Username $i: " userName
    if [ "$userName" == "skip" ] ; then
      continue
    fi

    read -p "(P)assword or (t)oken: " passToke
    passToke=$(echo $passToke | tr '[A-Z]' '[a-z]')
    cred="Password"
    if [[ $passToke == "t"* ]] ; then
      cred="Token"
    fi
    read -s -p "GitHub $cred $i: " password
    echo -e ''

    fileName=id_rsa_$userName

    fullFileName="$HOME/.ssh/$fileName"

    ssh-keygen -t rsa -b 4096 -C $userName -f $fullFileName
    public=$(<${fullFileName}.pub)
    payload='{"title": "'$HOSTNAME'", "key": "'$public'"}'

    # Need to check for two-factor as failure mode
    result=$(curl --silent --output -H "Content-Type: application/json" -d "${payload}" -u "${userName}:${password}" "https://api.github.com/user/keys")

    if [[ $result == *"OTP"* ]] ; then
      read -s -p "Enter the the current 2FA code: " tfc
      curl -H "X-GitHub-OTP: ${tfc}" -H "Content-Type: application/json" -d "${payload}" -u "${userName}:${password}" "https://api.github.com/user/keys"
    fi

    touch $HOME/.ssh/config
    domain=github.com
    if [ $i -gt 1 ] ; then
      domain=github.com-$userName
    else
      if [[ $passToke == "t"* ]] ; then
        cat<<END >> $HOME/dotfiles/.doNotCommit
export GITHUB_TOKEN=${password}
END
      fi
      read -p "Global git user name: " guser
      read -p "Global git user email: " gemail
      cat<<END > $HOME/dotfiles/.gitconfig.personal
[user]
  name = ${guser}
  email = ${gemail}

END
    fi
    cat<<END >> $HOME/.ssh/config
Host ${domain}
  HostName github.com
  User ${userName}
  PreferredAuthentications publickey
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ${fullFileName}
  IdentitiesOnly yes

END
echo -e "Adding key to ssh-agent"
ssh-add -K $fullFileName
done
fi

