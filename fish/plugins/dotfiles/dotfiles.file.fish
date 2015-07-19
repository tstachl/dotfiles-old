# NAME
#   dotfiles.file - Manage all the dotfiles
#
# SYNOPSIS
#   dotfiles.files [OPTIONS]
#
# OPTIONS
#   --link
#     Creates a backup of the original file and links the new file
#   --unlink
#     Removes the sym link and restores the backup if one exists
#
# DESCRIPTION
#   Links or unlinks dotfiles; creates a backup and restores from it on unlink
#
function dotfiles.file --argument-names option --argument-names file_path -d 'Manage all dotfiles'
  set -g __dotfiles_backup_path $dot_path/backup

  if not test -d $__dotfiles_backup_path
    mkdir $__dotfiles_backup_path
  end

  switch $option
    case '--link'
      dotfiles.file.link $file_path
    case '--unlink'
      dotfiles.file.unlink $file_path
    case '*'
      omf.log red 'Unknown option'
  end
end

function dotfiles.file.link --argument-names file_path -d 'Link a dotfile'
  if test -e $dot_path/$file_path
    set -l file_name      (basename $file_path)
    set -l dotfile_name   .$file_name

    if readlink $HOME/$dotfile_name | grep $dot_path >/dev/null
      return
    end

    if test -e $HOME/$dotfile_name
      mv $HOME/$dotfile_name $__dotfiles_backup_path/$dotfile_name
    end

    ln -s $dot_path/$file_path $HOME/$dotfile_name
  else
    omf.log red "$dot_path/$file_path does not exist!"
  end
end

function dotfiles.file.unlink --argument-names file_path -d 'Unlink a dotfile'
  if test -e $dot_path/$file_path
    set -l file_name      (basename $file_path)
    set -l dotfile_name   .$file_name

    rm $HOME/$dotfile_name

    if test -e $__dotfiles_backup_path/$dotfile_name
      mv $__dotfiles_backup_path/$dotfile_name $HOME/$dotfile_name
    end
  else
    omf.log red "$dot_path/$file_path does not exist!"
  end
end
