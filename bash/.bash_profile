# See following for more information: http://www.infinitered.com/blog/?p=19
MAGICK_HOME=/usr/local/bin/ImageMagick-6.5.2

# For Apache Tomcat
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home
export CATALINA_HOME=/usr/local/tomcat

# Path ------------------------------------------------------------
if [ `uname -s` == 'Darwin' ]; then
  # OS-X SPECIFIC
	export PATH=$JAVA_HOME/bin:$CATALINA_HOME/bin:/usr/local/cox/bin:~/bin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:$MAGICK_HOME:$PATH
else
	export PATH=/usr/local/cox/bin:~/bin:/opt/local/bin:/usr/local/sbin:/usr/local/bin:/usr/local/mysql/bin:$MAGICK_HOME:$PATH
fi

# export DYLD_LIBRARY_PATH=$MAGICK_HOME/lib
export MAGICK_HOME=$MAGICK_HOME

# Load in .bashrc -------------------------------------------------
source ~/.bashrc

# Notes: ----------------------------------------------------------
# When you start an interactive shell (log in, open terminal or iTerm in OS X,
# or create a new tab in iTerm) the following files are read and run, in this order:
#     profile
#     bashrc
#     .bash_profile
#     .bashrc (only because this file is run (sourced) in .bash_profile)
#
# When an interactive shell, that is not a login shell, is started
# (when you run "bash" from inside a shell, or when you start a shell in
# xwindows [xterm/gnome-terminal/etc] ) the following files are read and executed,
# in this order:
#     bashrc
#     .bashrc

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
