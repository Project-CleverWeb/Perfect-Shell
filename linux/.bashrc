#!/bin/bash

#  Customize BASH PS1 prompt to show current GIT repository and branch.
#  by Mike Stewart - http://MediaDoneRight.com

#  SETUP CONSTANTS
#  Bunch-o-predefined colors.  Makes reading code easier than escape sequences.
#  I don't remember where I found this.  o_O

# Reset
Color_Off="\[\033[0m\]"       # Text Reset

# Regular Colors
Black="\[\033[0;30m\]"        # Black
Red="\[\033[0;31m\]"          # Red
Green="\[\033[0;32m\]"        # Green
Yellow="\[\033[0;33m\]"       # Yellow
Blue="\[\033[0;34m\]"         # Blue
Purple="\[\033[0;35m\]"       # Purple
Cyan="\[\033[0;36m\]"         # Cyan
White="\[\033[0;37m\]"        # White

# Bold
B_Black="\[\033[1;30m\]"       # Black
B_Red="\[\033[1;31m\]"         # Red
B_Green="\[\033[1;32m\]"       # Green
B_Yellow="\[\033[1;33m\]"      # Yellow
B_Blue="\[\033[1;34m\]"        # Blue
B_Purple="\[\033[1;35m\]"      # Purple
B_Cyan="\[\033[1;36m\]"        # Cyan
B_White="\[\033[1;37m\]"       # White

# Underline
U_Black="\[\033[4;30m\]"       # Black
U_Red="\[\033[4;31m\]"         # Red
U_Green="\[\033[4;32m\]"       # Green
U_Yellow="\[\033[4;33m\]"      # Yellow
U_Blue="\[\033[4;34m\]"        # Blue
U_Purple="\[\033[4;35m\]"      # Purple
U_Cyan="\[\033[4;36m\]"        # Cyan
U_White="\[\033[4;37m\]"       # White

# Background
BG_Black="\[\033[40m\]"       # Black
BG_Red="\[\033[41m\]"         # Red
BG_Green="\[\033[42m\]"       # Green
BG_Yellow="\[\033[43m\]"      # Yellow
BG_Blue="\[\033[44m\]"        # Blue
BG_Purple="\[\033[45m\]"      # Purple
BG_Cyan="\[\033[46m\]"        # Cyan
BG_White="\[\033[47m\]"       # White

# High Intensty
H_Black="\[\033[0;90m\]"       # Black
H_Red="\[\033[0;91m\]"         # Red
H_Green="\[\033[0;92m\]"       # Green
H_Yellow="\[\033[0;93m\]"      # Yellow
H_Blue="\[\033[0;94m\]"        # Blue
H_Purple="\[\033[0;95m\]"      # Purple
H_Cyan="\[\033[0;96m\]"        # Cyan
H_White="\[\033[0;97m\]"       # White

# Bold High Intensty
BH_Black="\[\033[1;90m\]"      # Black
BH_Red="\[\033[1;91m\]"        # Red
BH_Green="\[\033[1;92m\]"      # Green
BH_Yellow="\[\033[1;93m\]"     # Yellow
BH_Blue="\[\033[1;94m\]"       # Blue
BH_Purple="\[\033[1;95m\]"     # Purple
BH_Cyan="\[\033[1;96m\]"       # Cyan
BH_White="\[\033[1;97m\]"      # White

# High Intensty backgrounds
BGH_Black="\[\033[0;100m\]"   # Black
BGH_Red="\[\033[0;101m\]"     # Red
BGH_Green="\[\033[0;102m\]"   # Green
BGH_Yellow="\[\033[0;103m\]"  # Yellow
BGH_Blue="\[\033[0;104m\]"    # Blue
BGH_Purple="\[\033[10;95m\]"  # Purple
BGH_Cyan="\[\033[0;106m\]"    # Cyan
BGH_White="\[\033[0;107m\]"   # White

# Various variables you might want for your PS1 prompt instead
Time12h="\T"
Time12a="\@"
PathShort="\w"
PathFull="\W"
NewLine="\n"
Jobs="\j"
sp=" "
host="\h"
user="\u"


function git-unpushed {
    brinfo=$(git branch -v)
    if [[ $brinfo =~ ("[ahead "([[:digit:]]*)]) ]]
    then
        echo "Not Pushed: ${BASH_REMATCH[2]}"
    fi
}

function git-untracked {
    untracked=$(git clean --dry-run | wc -l)
    if [ $untracked -gt 0 ]
    then
        echo "Untracked: "$untracked
    fi
}




# This PS1 snippet was adopted from code for MAC/BSD I saw from:
# http://allancraig.net/index.php?option=com_content&view=article&id=108:ps1-export-command-for-git&catid=45:general&Itemid=96
# I tweaked it to work on UBUNTU 11.04 & 11.10 plus made it mo' better

export PS1=$NewLine$BIGreen$user$BIWhite"@"$host"  "$BIBlue$PathShort$NewLine$Color_Off" "'$(git branch &>/dev/null;\
if [ $? -eq 0 ]; then \
  echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
  if [ "$?" -eq "0" ]; then \
    # @4 - Clean repository - nothing to commit
    echo $(__git_ps1 " '$IWhite'('$IGreen'%s'$IWhite') '$IYellow'`git-unpushed`"); \
  else \
    # @5 - Changes to working tree
    echo $(__git_ps1 " '$IWhite'('$IYellow'%s'$IWhite') '$IYellow'`git diff --shortstat` '$IRed'`git-untracked`"); \
  fi) '$Color_Off' "; \
else \
  # @2 - Prompt when not in GIT repo
  echo "'"\[\033[1;97m\](\[\033[1;36m\]\$(/bin/ls -1 | /usr/bin/wc -l | /bin/sed 's: ::g') Items\[\033[1;97m\], \[\033[1;36m\]\$(/bin/ls -lah | /bin/grep -m 1 total | /bin/sed 's/total //')b\[\033[1;97m\])  \T"$Color_Off' "; \
fi)'"\n  "$BIWhite"$: "
