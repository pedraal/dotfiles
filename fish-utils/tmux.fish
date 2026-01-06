function tmux_home
    set SESSION_NAME "__home__"

    set BORDERS_INSTALLED false
    set SKETCHYBAR_INSTALLED false

    if command -v borders >/dev/null
        set BORDERS_INSTALLED true
    end
    if command -v sketchybar >/dev/null
        set SKETCHYBAR_INSTALLED true
    end

    set RICEABLE false
    if test $BORDERS_INSTALLED = true; or test $SKETCHYBAR_INSTALLED = true
        set RICEABLE true
    end

    if tmux has-session -t "$SESSION_NAME" 2>/dev/null
        echo "Attaching to existing session '$SESSION_NAME'..."
        tmux attach-session -t "$SESSION_NAME"
    else
        echo "Creating new session '$SESSION_NAME'..."

        set original_dir $PWD
        cd ~

        tmux new-session -s "$SESSION_NAME" -n config -d
        tmux new-window -t "$SESSION_NAME" -n git
        if test $RICEABLE = true
            tmux new-window -t "$SESSION_NAME" -n rice
        end
        tmux new-window -t "$SESSION_NAME" -n exec

        if test $RICEABLE = true
            tmux select-window -t "$SESSION_NAME":3
            if test $BORDERS_INSTALLED = true
                tmux send-keys "borders" C-m
            end
            # if test $SKETCHYBAR_INSTALLED = true
            #     tmux split-window -h -t "$SESSION_NAME":3
            #     tmux send-keys "sketchybar" C-m
            # end
        end

        tmux select-window -t "$SESSION_NAME":2
        tmux send-keys "cd ~/dotfiles && lazygit" C-m

        tmux select-window -t "$SESSION_NAME":1
        tmux send-keys "cd ~/dotfiles && nvim" C-m

        cd $original_dir
        tmux attach-session -t "$SESSION_NAME"
    end
end

function tmux_session
    set SESSION_NAME (basename $PWD | tr '.' '_')

    if tmux has-session -t "=$SESSION_NAME" 2>/dev/null
        tmux attach-session -t "$SESSION_NAME"
    else
        if test -d ".git"
            tmux new-session -s "$SESSION_NAME" -n code \; \
                new-window -n exec \; \
                new-window -n git \; \
                select-window -t 3 \; \
                send-keys "lazygit" C-m \; \
                select-window -t 1 \; \
                send-keys "nvim" C-m
        else
            tmux new-session -s "$SESSION_NAME" -n code \; \
                new-window -n exec \; \
                select-window -t 1 \; \
                send-keys "nvim" C-m
        end
    end
end

function tmux_workspace
    if test (count $argv) -eq 0
        echo "Error: Please provide a directory relative to ~/workspace"
        return 1
    end

    set target_dir ~/workspace/$argv[1]

    if not test -d $target_dir
        echo "Error: Directory '$target_dir' does not exist"
        return 1
    end

    set original_dir $PWD
    cd $target_dir
    tmux_session
    cd $original_dir
end

function fn_complete_tmux_workspace
    # Direct children of ~/workspace
    for dir in ~/workspace/*
        if test -d $dir
            basename $dir
        end
    end

    # Children of ~/workspace/crisp
    if test -d ~/workspace/crisp
        for dir in ~/workspace/crisp/*
            if test -d $dir
                echo "crisp/"(basename $dir)
            end
        end
    end

    # Children of ~/workspace/playground
    if test -d ~/workspace/playground
        for dir in ~/workspace/playground/*
            if test -d $dir
                echo "playground/"(basename $dir)
            end
        end
    end

    # Children of ~/workspace/go
    if test -d ~/workspace/go
        for dir in ~/workspace/go/*
            if test -d $dir
                echo "go/"(basename $dir)
            end
        end
    end

    # Children of ~/workspace/gleam
    if test -d ~/workspace/gleam
        for dir in ~/workspace/gleam/*
            if test -d $dir
                echo "gleam/"(basename $dir)
            end
        end
    end
end

alias th tmux_home
alias ts tmux_session
alias tw tmux_workspace
alias ta 'tmux a'

complete -c tw -f -a "(fn_complete_tmux_workspace)"
