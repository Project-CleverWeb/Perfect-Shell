# Perfect-Shell (codename: P-Shell) #

**Site :** [projectcleverweb.com](http://projectcleverweb.com)  
**Description :**  
The idea is to create a day-to-day simple shell that is easy to read, cross OS compatible/consistent, and has git integration. This is not meant to be some overly complex program, it's meant to be just a plain and simple prompt interface. Right now this only supports most linux bash prompts (and possibly Mac). Windows version may be available withing a couple days/weeks.

&nbsp;    

----------

&nbsp;    

##Updates##
Most informational aspects (such us the codex or this readme) will be updated as full versions are released. Requests for ETA's on versions or update will be ignored entirely.  

##Screenshot##
![Prompt Example](http://i.imgur.com/upiZDQu.png "Prompt Example")

##Installation##
**Requirements**  
- {**recommended**} [Install Git](https://help.github.com/articles/set-up-git) (try one of these in terminal: sudo apt-get install git **OR** sudo yum install git) and make sure it's added to your $path (you may need to google how to do this for your OS). Skipping this step will cause errors to appear while browsing Git repositories!  
- {**optional**} Set the upstream for your braches to see 'not pushed' counts. This may be done automatically with some Windows installations of Git.

**Linux/Mac** (Recommended) (installer coming soon)
- Make sure that you have hidden files showing (try ctrl + H/cmd + H)
- Add *.bashrc* to to your */home* directory (e.g. */home/your_name*). If the file already exists, open it in a text editor and add the contents of the new *.bashrc* to the old *.bashrc* (replacing the file should not break anything, but better safe than sorry). This file is sometimes named *.bash_profile*.  
- If you want to make this effect all users and not just yourself, **ONLY** add the contents the *.bashrc* file to the bottom of */etc/bash.bashrc*. The file may have a simular name and not *bash.bashrc*, however experiance says it should be *bash.bashrc*  
- Reopen any bash/terminal windows to see the effect.  

**Linux/Mac (root user)**  
- Coming Soon  

**Windows**  
- Coming Soon (installer)  

##Various Information##

**Contact Us :**  
git@projectcleverweb.com

**ETA's :**  
Forget they exist

**Notices :**  
- Some text is abbreviated, and may not be what you expect. Please see the section below called "[Abbreviations](#abbreviations)" for a guide as to what some abbreviations mean.  
- Windows versions will use [Ancicon](https://github.com/adoxa/ansicon) to render colors. IMPORTANT: At the moment, ansicon's repository does not contain all the proper files, please check this site ([adoxa.3eeweb.com/ansicon/](http://adoxa.3eeweb.com/ansicon/)) to download ansicon.  
- When browsing a linux server that has Perfect-Shell via SSH (e.g. putty) coloring appears oddly. (no known fix)

**Warnings :**  
- Ferdora installs may be a little buggy (WIP)
- Mac installs are **UNTESTED**! To improve this, if you have a Mac please send any issues you have to git@projectcleverweb.com

##Abbreviations##
**Information:** This section will likely be updated fairly often, however not constantly. It would be a good idea to check this section between upgrades for new content.
&nbsp;  
&nbsp;  
- **org** = *The original or organic, may refer to a file or element within a document. The idea being that whatever is being refered to is a starting point.*
- **[comeback]** = *This declars a spot to come back to and fix, adding this to a file, makes it easy to search for areas of script that still need additional information*
- **WIP** = *Work in Progress*
