CLI-stuff
=========

#Prerequisites#
* PHP installed and [added to your $PATH](http://blog.eukhost.com/webhosting/how-do-i-add-my-php-directory-to-the-path-on-windows/)
* Download [ANSICON](https://github.com/Project-CleverWeb/Perfect-Shell/tree/master/windows/resources/ansicon), and [install it](https://github.com/adoxa/ansicon/blob/master/readme.txt) **(windows only)**
&nbsp;

* **Notice 1:** Linux will automatically add php to your path if installed via `apt-get` or `yum`
* **Notice 2:** Currently the ANSICON source on github is incomplete, and does not contain the `x86` and `x64` folders. The download link supplied is to one of my own repos that has the complete version of ANSICON in it. **I do not own or contribute to ANSICON.**

#The Script#
This script will soon become apart of a [larger project](https://github.com/Project-CleverWeb/Perfect-Shell) of mine, but of course you can play with the current working version.

#Usage#
**NOTE:** All examples assume the script is located in a file called `color.php` and it is located in the current directory.

The only required variable is a string supplied via either the `-s` argument or `STDIN`. This means both of the following will work without error:

    php color.php -s "my name is frank"

    echo my name is frank | php color.php

**NOTE:** Right now the default text color is white, and it is hard-coded in. A future build will likely allow this to be changed on-the-fly.

**However,** if both `STDIN` and `-s` are provided, `STDIN` will not be modified and it will be prepended to `-s`. 

    php color.php -s "hello, " -c yellow | php color.php -s Frank -c red

The above example would print "hello, Frank" where 'hello, ' is yellow, and 'Frank' is red.

**Please note:** Quotes are only required around a string if it has a `space` character in it.

#Other Variables#

Unlike the string variable, the remaining variables are not required, but each must use their respective argument.

The first optional argument is `-c` which colors the text of the string (see [*Ex 2*](#ex-2)). The next argument is `-C` which colors the background of the string (see [*Ex 3*](#ex-3)). And then there is the `-S` argument, which allows changing the style of the text (see [*Ex 4*](#ex-4)).

There is also the `--no-stdin` argument which will discard the `STDIN` string. This is more for future compatibly, which may allow `STDIN` to supply settings or other information.

Finally, You can easily **view an example of all the colors and styles** available by using the `--print-all` argument (see [*Ex 1*](#ex-1)). Please keep in mind this will discard all the other variables.

#Examples#
####Ex 1:####
This will print all the possible colors and styles, but will ignore all other supplied variables, including STDIN.

    php color.php --print-all

####Ex 2:####
This will show the git diff short-stat where just the text is yellow.

    git diff --shortstat | php color.php -c light_yellow

####Ex 3:#####
(*Linux*) This will show the current directory with blue text on a white background.

    pwd | php color.php -c blue -C white

####Ex 4:####
This will show the string "task complete: Make example #4" where "Make example #4" has a strike through it.

    echo "task complete: " | php color.php -s "Make example #4" -S strike

####Ex 5:####
(*Linux*) Assuming you put the function `git-unpushed` into your `~/.bashrc` file, the following would print "Not Pushed: 2" in a bold green text, given you have 2 commits ready to be pushed to Github in this directory.

    function git-unpushed {
        brinfo=$(git branch -v)
        if [[ $brinfo =~ ("[ahead "([[:digit:]]*)]) ]]
        then
            echo "Not Pushed: ${BASH_REMATCH[2]}"
        fi
    }
    
    git-unpushed | php color.php -c green -S bold