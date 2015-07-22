# Path to your dotfiles.
if test -L (status --current-filename)
  set -x dot_path    (dirname (dirname (readlink (status --current-filename))))
else
  set -x dot_path    (dirname (dirname (status --current-filename)))
end

# Set color profile
set -x LC_TERM_PROFILE base16-monokai.dark

# Path to your oh-my-fish.
set fish_path         $dot_path/oh-my-fish

# Path to your custom folder (default path is ~/.oh-my-fish/custom)
set fish_custom       $dot_path/fish

# My default user
set default_user      'tstachl'

# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish

# Custom plugins and themes may be added to ~/.oh-my-fish/custom
# Plugins and themes can be found at https://github.com/oh-my-fish/
Theme 'thomasstachl'
Plugin 'dotfiles'

# Make sure we're up to date
if status --is-login
  eval sh $HOME/.config/base16-shell/$LC_TERM_PROFILE.sh
  omf self-update
  dotfiles self-update
end

# Add all the dotfiles
dotfiles link git/gitattributes
dotfiles link git/gitconfig
dotfiles link git/gitignore
dotfiles link git/gitk
dotfiles link git/tigrc

dotfiles link vim/vimrc

# Aliases
alias devcon "ssh -L 27018:localhost:27017 devcon"
alias tml "abduco"
alias tma "abduco -a"
alias tmc "abduco -c"
