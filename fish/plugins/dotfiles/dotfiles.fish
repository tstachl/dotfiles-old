# NAME
#   dotfiles - Dotfiles helper
#
# DESCRIPTION
#   Takes care of all the dotfile configurations that are specified.
#

function dotfiles -d "Dotfiles helper"
  if test (count $argv) -gt 0
    switch $argv[1]
      case 'link'
        dotfiles.file --link $argv[2..-1]
      case 'unlink'
        dotfiles.file --unlink $argv[2..-1]
      case 'self-update'
        omf.git --update $dot_path

        if [ $status -eq 0 ]
          omf.log 'green' 'Dotfiles have been updated successfully.'
        end
      case '*'
        dotfiles.helper
    end
  else
    dotfiles.helper
  end
end
