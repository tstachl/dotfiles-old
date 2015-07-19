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

    if test -e $HOME/$dotfile_name
      dotfiles.file.backup $dotfile_name
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
      dotfiles.file.restore $dotfile_name
    end
  else
    omf.log red "$dot_path/$file_path does not exist!"
  end
end

function dotfiles.file.backup --argument-names file_name -d 'Creates a backup'
  mv $HOME/$file_name $__dotfiles_backup_path/$file_name
  omf.log green "Created a backup for $file_name to $__dotfiles_backup_path."
end

function dotfiles.file.restore --argument-names file_name -d 'Restores from backup'
  mv $__dotfiles_backup_path/$file_name $HOME/$file_name
  omf.log green "Restored $file_name to $HOME."
end
