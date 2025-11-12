function fn_go_to_workspace
  if test "$argv[1]" = ""
    cd ~/workspace
  else
    cd ~/workspace/$argv[1]
  end
end

function fn_go_to_playground
  if test "$argv[1]" = ""
    cd ~/workspace/playground
  else
    cd ~/workspace/playground/$argv[1]
  end
end


function fn_complete_go_to_workspace
  for dir in ~/workspace/*
    if test -d $dir
      basename $dir
    end
  end
end

function fn_complete_go_to_playground
  for dir in ~/workspace/playground/*
    if test -d $dir
      basename $dir
    end
  end
end

alias gtw=fn_go_to_workspace
complete -c gtw -f -a "(fn_complete_go_to_workspace)"

alias gtp=fn_go_to_playground
complete -c gtp -f -a "(fn_complete_go_to_playground)"
