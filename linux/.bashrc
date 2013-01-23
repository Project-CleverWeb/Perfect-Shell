#!/bin/bash

# Reset
export No_Color="\[\033[0m\]"        # Default Color
export Bold="\[\033[1;0m\]"
export Underline="\[\033[4;0m\]"

# Regular Colors
export Black="\[\033[0;30m\]"        # Black
export Red="\[\033[0;31m\]"          # Red
export Green="\[\033[0;32m\]"        # Green
export Yellow="\[\033[0;33m\]"       # Yellow
export Blue="\[\033[0;34m\]"         # Blue
export Purple="\[\033[0;35m\]"       # Purple
export Cyan="\[\033[0;36m\]"         # Cyan
export White="\[\033[0;37m\]"        # White

# Bold
export B_Black="\[\033[1;30m\]"      # Black
export B_Red="\[\033[1;31m\]"        # Red
export B_Green="\[\033[1;32m\]"      # Green
export B_Yellow="\[\033[1;33m\]"     # Yellow
export B_Blue="\[\033[1;34m\]"       # Blue
export B_Purple="\[\033[1;35m\]"     # Purple
export B_Cyan="\[\033[1;36m\]"       # Cyan
export B_White="\[\033[1;37m\]"      # White

# Underline
export U_Black="\[\033[4;30m\]"      # Black
export U_Red="\[\033[4;31m\]"        # Red
export U_Green="\[\033[4;32m\]"      # Green
export U_Yellow="\[\033[4;33m\]"     # Yellow
export U_Blue="\[\033[4;34m\]"       # Blue
export U_Purple="\[\033[4;35m\]"     # Purple
export U_Cyan="\[\033[4;36m\]"       # Cyan
export U_White="\[\033[4;37m\]"      # White

# Background
export BG_Black="\[\033[40m\]"       # Black
export BG_Red="\[\033[41m\]"         # Red
export BG_Green="\[\033[42m\]"       # Green
export BG_Yellow="\[\033[43m\]"      # Yellow
export BG_Blue="\[\033[44m\]"        # Blue
export BG_Purple="\[\033[45m\]"      # Purple
export BG_Cyan="\[\033[46m\]"        # Cyan
export BG_White="\[\033[47m\]"       # White

# High Intensty
export H_Black="\[\033[0;90m\]"      # Black
export H_Red="\[\033[0;91m\]"        # Red
export H_Green="\[\033[0;92m\]"      # Green
export H_Yellow="\[\033[0;93m\]"     # Yellow
export H_Blue="\[\033[0;94m\]"       # Blue
export H_Purple="\[\033[0;95m\]"     # Purple
export H_Cyan="\[\033[0;96m\]"       # Cyan
export H_White="\[\033[0;97m\]"      # White

# Bold High Intensty
export BH_Black="\[\033[1;90m\]"     # Black
export BH_Red="\[\033[1;91m\]"       # Red
export BH_Green="\[\033[1;92m\]"     # Green
export BH_Yellow="\[\033[1;93m\]"    # Yellow
export BH_Blue="\[\033[1;94m\]"      # Blue
export BH_Purple="\[\033[1;95m\]"    # Purple
export BH_Cyan="\[\033[1;96m\]"      # Cyan
export BH_White="\[\033[1;97m\]"     # White

# High Intensty backgrounds
export BGH_Black="\[\033[0;100m\]"   # Black
export BGH_Red="\[\033[0;101m\]"     # Red
export BGH_Green="\[\033[0;102m\]"   # Green
export BGH_Yellow="\[\033[0;103m\]"  # Yellow
export BGH_Blue="\[\033[0;104m\]"    # Blue
export BGH_Purple="\[\033[10;95m\]"  # Purple
export BGH_Cyan="\[\033[0;106m\]"    # Cyan
export BGH_White="\[\033[0;107m\]"   # White

# Various variables
export Time12h="\T"
export Time24h="\t"
export Time="\@"
export sPath="\w"
export Path="\W"
export NL="\n"
export Jobs="\j"
export Host="\h"
export HostLong="\H"
export User="\u"

# Default values (ps = Perfect-Shell variable; psc = Perfect-Shell color variable)


export ps_spacer="  "
export ps_host=$Host
export ps_dir=$sPath
export ps_time=$Time

export psc_rootuser=$H_Red        # Requires root version of Perfect-Shell!
export psc_rootsym=$H_Red         # Requires root version of Perfect-Shell!

export psc_commands=$No_Color
export psc_user=$H_Green
export psc_at=$No_Color
export psc_host=$No_Color
export psc_dir=$H_Blue
export psc_items=$H_Cyan
export psc_dir_size=$H_Cyan
export psc_time=$No_Color
export psc_sym=$No_Color
export psc_clean_branch=$H_Green   # Git only
export psc_dirty_branch=$H_Yellow  # Git only
export psc_git_changes=$H_Yellow   # Git only
export psc_git_untracked=$H_Red    # Git only
export psc_not_pushed=$H_Yellow    # Git only


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
    echo "'"$Bold($psc_items\$(/bin/ls -1 | /usr/bin/wc -l | /bin/sed 's: ::g') Items$Bold, $psc_dir_size\$(/bin/ls -lah | /bin/grep -m 1 total | /bin/sed 's/total //')b$Bold)"$ps_spacer$ps_time$No_Color'"; \
  fi)'$NL"  "$psc_sym"\$$No_Color: "$psc_commands
