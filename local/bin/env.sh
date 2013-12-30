JAVA_HOME=/home/pawel/dev/java/jdk/current
SCALA_HOME=/home/pawel/dev/scala/current
GRADLE_HOME=/home/pawel/dev/java/util/gradle/gradle-current
M2_HOME=/home/pawel/dev/java/util/maven/apache-maven-current
ANT_HOME=/home/pawel/dev/java/util/ant/apache-ant-current
GROOVY_HOME=/home/pawel/dev/groovy/groovy-sdk-current
LEIN_HOME=/home/pawel/dev/lein/lein-current
SBT_HOME=/home/pawel/dev/sbt/sbt

export JAVA_HOME
export SCALA_HOME
export GRADLE_HOME
export M2_HOME
export ANT_HOME
export GROOVY_HOME

PATH=${PATH}:/home/pawel/.local/bin:/home/pawel/bin
PATH=${PATH}:${JAVA_HOME}/bin
PATH=${PATH}:${SCALA_HOME}/bin
PATH=${PATH}:${GRADLE_HOME}/bin
PATH=${PATH}:${M2_HOME}/bin
PATH=${PATH}:${ANT_HOME}/bin
PATH=${PATH}:${GROOVY_HOME}/bin
PATH=${PATH}:${LEIN_HOME}
PATH=${PATH}:/home/pawel/dev/java/ide/intellij-idea/idea/bin
PATH=${PATH}:${SBT_HOME}/bin

export PATH

TERMINAL=urxvt
#TERMINAL=xfce4-terminal
EDITOR=vim
BROWSER=google-chrome

export TERMINAL
export EDITOR
export BROWSER

GTK2_RC_FILES=/usr/share/themes/zukitwo/gtk-2.0/gtkrc
export GTK2_RC_FILES

# anti alias fonts in java apps
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'

# rbenv: https://github.com/sstephenson/rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

alias emacs='emacs --no-site-file --no-splash'
alias e='emacs -nw -ib 0 -T emacs --no-site-file --no-splash'
