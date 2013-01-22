#!/bin/bash

# Reset
No_Color="\[\033[0m\]"        # Default Color
Bold="\[\033[1;0m\]"
Underline="\[\033[4;0m\]"

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
B_Black="\[\033[1;30m\]"      # Black
B_Red="\[\033[1;31m\]"        # Red
B_Green="\[\033[1;32m\]"      # Green
B_Yellow="\[\033[1;33m\]"     # Yellow
B_Blue="\[\033[1;34m\]"       # Blue
B_Purple="\[\033[1;35m\]"     # Purple
B_Cyan="\[\033[1;36m\]"       # Cyan
B_White="\[\033[1;37m\]"      # White

# Underline
U_Black="\[\033[4;30m\]"      # Black
U_Red="\[\033[4;31m\]"        # Red
U_Green="\[\033[4;32m\]"      # Green
U_Yellow="\[\033[4;33m\]"     # Yellow
U_Blue="\[\033[4;34m\]"       # Blue
U_Purple="\[\033[4;35m\]"     # Purple
U_Cyan="\[\033[4;36m\]"       # Cyan
U_White="\[\033[4;37m\]"      # White

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
H_Black="\[\033[0;90m\]"      # Black
H_Red="\[\033[0;91m\]"        # Red
H_Green="\[\033[0;92m\]"      # Green
H_Yellow="\[\033[0;93m\]"     # Yellow
H_Blue="\[\033[0;94m\]"       # Blue
H_Purple="\[\033[0;95m\]"     # Purple
H_Cyan="\[\033[0;96m\]"       # Cyan
H_White="\[\033[0;97m\]"      # White

# Bold High Intensty
BH_Black="\[\033[1;90m\]"     # Black
BH_Red="\[\033[1;91m\]"       # Red
BH_Green="\[\033[1;92m\]"     # Green
BH_Yellow="\[\033[1;93m\]"    # Yellow
BH_Blue="\[\033[1;94m\]"      # Blue
BH_Purple="\[\033[1;95m\]"    # Purple
BH_Cyan="\[\033[1;96m\]"      # Cyan
BH_White="\[\033[1;97m\]"     # White

# High Intensty backgrounds
BGH_Black="\[\033[0;100m\]"   # Black
BGH_Red="\[\033[0;101m\]"     # Red
BGH_Green="\[\033[0;102m\]"   # Green
BGH_Yellow="\[\033[0;103m\]"  # Yellow
BGH_Blue="\[\033[0;104m\]"    # Blue
BGH_Purple="\[\033[10;95m\]"  # Purple
BGH_Cyan="\[\033[0;106m\]"    # Cyan
BGH_White="\[\033[0;107m\]"   # White

# Various variables
Time12h="\T"
Time24h="\t"
Time="\@"
sPath="\w"
Path="\W"
NL="\n"
Jobs="\j"
Host="\h"
HostLong="\H"
User="\u"

# Default values (ps = Perfect-Shell variable; psc = Perfect-Shell color variable)

ps_spacer="  "
ps_host=$Host
ps_dir=$sPath
ps_time=$Time

psc_commands=$Bold
psc_user=$BH_Green
psc_at=$Bold
psc_host=$Bold
psc_dir=$BH_Blue
psc_items=$BH_Cyan
psc_dir_size=$BH_Cyan
psc_time=$Bold
psc_sym=$Bold
psc_clean_branch=$H_Green   # Git only
psc_dirty_branch=$H_Yellow  # Git only
psc_git_changes=$H_Yellow   # Git only
psc_git_untracked=$H_Red    # Git only
psc_not_pushed=$H_Red       # Git only



# Lets put it all together now

function git-unpushed {
    brinfo=$(git branch -v)
    if [[ $brinfo =~ ("[ahead "([[:digit:]]*)]) ]]
    then
        echo "Ready To Push: ${BASH_REMATCH[2]}"
    fi
}

function git-untracked {
    untracked=$(git clean --dry-run | wc -l)
    if [ $untracked -gt 0 ]
    then
        echo "Untracked: "$untracked
    fi
}

export PS1=$NL$psc_user$User$psc_at"@"$psc_host$ps_host$ps_spacer$psc_dir$ps_dir$NL" "'$(git branch &>/dev/null;\
  if [ $? -eq 0 ]; then \
    echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
    if [ "$?" -eq "0" ]; then \
      # Clean repository - nothing to commit
      echo $(__git_ps1 " '$No_Color'('$psc_clean_branch'%s'$No_Color')'$ps_spacer$psc_not_pushed'`git-unpushed`"); \
    else \
      # Changes to working tree
      echo $(__git_ps1 " '$No_Color'('$psc_dirty_branch'%s'$No_Color')'$ps_spacer$psc_git_changes'`git diff --shortstat` '$psc_git_untracked'`git-untracked`"); \
    fi) '$No_Color' "; \
  else \
    # Prompt when not in Git repo
    echo "'"'$Bold'('$psc_items'\$(/bin/ls -1 | /usr/bin/wc -l | /bin/sed 's: ::g') Items'$Bold', '$psc_dir_size'\$(/bin/ls -lah | /bin/grep -m 1 total | /bin/sed 's/total //')b'$Bold')"$ps_spacer$ps_time$No_Color'"; \
  fi)'$NL"  "$psc_sym"\$'$No_Color': "$psc_commands
