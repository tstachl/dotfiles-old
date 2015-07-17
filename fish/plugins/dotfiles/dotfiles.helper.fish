# NAME
#   dotfiles.helper - Prints Dotfiles help
#
# DESCRIPTION
#   Prints all functions supported by Dotfiles helper
#
function dotfiles.helper -d 'Prints all functions supported by Dotfiles helper'
  omf.log normal 'Dotfiles are the personal dotfiles of Thomas and this helper'
  omf.log normal 'makes sure all the files are hooked up correctly.'
  omf.log normal ''
  omf.log normal '  Examples:'
  omf.log normal '    dotfiles link .gitconfig git/config'
  omf.log normal '    dotfiles unlink .gitconfig'
  omf.log normal '    dotfiles backup .gitconfig'
  omf.log normal '    dotfiles self-update'
end
