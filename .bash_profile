# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

# replace pre-installed git version by Apple
export PATH="/usr/local/bin:$PATH"

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for many Bash commands
if which brew &> /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
	source "$(brew --prefix)/share/bash-completion/bash_completion";
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
	complete -o default -o nospace -F _git g;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults;

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;

# For rbenv & ruby-build library @Allen
export RBENV_ROOT="/usr/local/var/rbenv"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# For 64 System compile
export ARCHFLAGS="-arch x86_64"

# Android adb
export PATH=$PATH:~/Library/Android/sdk/platform-tools

# VSCode
code () {
    if [[ $# = 0 ]]
    then
        open -a "Visual Studio Code"
    else
        [[ $1 = /* ]] && F="$1" || F="$PWD/${1#./}"
        open -a "Visual Studio Code" --args "$F"
    fi
}

# OSX Packages Uninstaller
export PATH=$PATH:$HOME/.pkg_uninstaller

# Add environment variable COCOS_CONSOLE_ROOT for cocos2d-x
export COCOS_CONSOLE_ROOT=/Applications/Cocos/Cocos2d-x/cocos2d-x-3.10/tools/cocos2d-console/bin
export PATH=$COCOS_CONSOLE_ROOT:$PATH

# Add environment variable COCOS_X_ROOT for cocos2d-x
export COCOS_X_ROOT=/Applications/Cocos/Cocos2d-x
export PATH=$COCOS_X_ROOT:$PATH

# Add environment variable COCOS_TEMPLATES_ROOT for cocos2d-x
export COCOS_TEMPLATES_ROOT=/Applications/Cocos/Cocos2d-x/cocos2d-x-3.10/templates
export PATH=$COCOS_TEMPLATES_ROOT:$PATH

# add NDK path
export PATH=$PATH:/Users/Allen/android-ndk-r10e

# Add environment variable NDK_ROOT for cocos2d-x
export NDK_ROOT=/Users/Allen/android-ndk-r10e
export PATH=$NDK_ROOT:$PATH

# ant
export ANT_HOME=/Users/Allen/android-ant-1.9.7
export PATH=${PATH}:${ANT_HOME}/bin
export JAVA_HOME="$(/usr/libexec/java_home -v 1.7)"

# Add environment variable ANDROID_SDK_ROOT for cocos2d-x
export ANDROID_SDK_ROOT=/Users/Allen/android-sdk-macosx/
export PATH=$ANDROID_SDK_ROOT:$PATH
export PATH=$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools:$PATH

# Add environment variable ANT_ROOT for cocos2d-x
export ANT_ROOT=/Users/Allen/apache-ant-1.9.7/bin/
export PATH=$ANT_ROOT:$PATH

export NVM_DIR="/Users/Allen/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# sequelize
export PATH=$PATH:/Users/Allen/api-boilerplate/node_modules/.bin

# http://stackoverflow.com/questions/12594541/npm-global-install-cannot-find-module
export NODE_PATH=~/.nvm/versions/node/v7.6.0/lib/node_modules

# shadowsocks 全局代理 use polipo https://jingsam.github.io/2016/05/08/setup-shadowsocks-http-proxy-on-ubuntu-server.html
export http_proxy="http://127.0.0.1:8123/"
