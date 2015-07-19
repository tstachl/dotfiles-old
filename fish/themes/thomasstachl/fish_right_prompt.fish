# Show git status
function get_git_status -d "Gets the current git status"
  if command git rev-parse --is-inside-work-tree >/dev/null 2>&1
    set -l dirty (command git status -s --ignore-submodules=dirty | wc -l | sed -e 's/^ *//' -e 's/ *$//' 2> /dev/null)
    set -l ref (command git symbolic-ref HEAD | sed  "s-refs/heads/--" | sed -e 's/^ *//' -e 's/ *$//' 2> /dev/null)

    if [ "$dirty" != "0" ]
      set_color -b normal
      set_color red
      echo "$dirty changed file"
      if [ "$dirty" != "1" ]
        echo "s"
      end
      echo " "
      set_color -b red
      set_color white
    else
      set_color -b cyan
      set_color white
    end

    echo " $ref "
    set_color normal
  end
end

# Show directory
function show_pwd -d "Show the current directory"
  set -l pwd (prompt_pwd)
  set -l pad ""

  if command git rev-parse --is-inside-work-tree >/dev/null 2>&1
    set pad " "
  end

  prompt.segment normal blue "[$pwd]$pad"
end

function fish_right_prompt -d "Prints right prompt"

  show_pwd
  get_git_status
end
