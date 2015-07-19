# NAME
#   dotvim - Dotvim helper
#
# DESCRIPTION
#   Clones dotvim into Dotfiles directory and keeps it updated.
#

function dotvim -d "Dotvim helper"
  if test (count $argv) -gt 0
    switch $argv[1]
      case 'self-update'
        omf.git --update $dotvim_path

        if [ $status -eq 0 ]
          omf.log 'green' 'Dotvim has been updated successfully.'
        end
      case '*'
        dotvim.helper
    end
  else
    dotvim.helper
  end
end
