# Path to your dotfiles.
set dot_path          (dirname (dirname (readlink (status --current-filename))))

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
omf self-update
dotfiles self-update

# Add all the dotfiles
dotfiles link git/gitattributes
dotfiles link git/gitconfig
dotfiles link git/gitignore
dotfiles link git/gitk
dotfiles link git/tigrc
