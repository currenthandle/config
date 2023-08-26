# if status is-interactive
#     # Commands to run in interactive sessions can go here
#     fish_vi_key_bindings
# end
# fish_vi_key_bindings

# export PATH="$PATH:/Users/casey/.foundry/bin:$PATH:/Users/casey/.cargo/bin"

# # pnpm
# set -gx PNPM_HOME "/Users/casey/Library/pnpm"
# set -gx PATH "$PNPM_HOME" $PATH
# # pnpm end
# set -x PATH "/usr/local/opt/ruby@2.7/bin" $PATH

# if test -x (command -v rbenv)
#     eval (rbenv init - | source)
# end

# set -gx PATH /usr/local/opt/llvm/bin $PATH


# if status is-interactive
#     # Commands to run in interactive sessions can go here
#     fish_vi_key_bindings
# end

fish_vi_key_bindings

# Add paths to PATH
set -U fish_user_paths /Users/casey/.foundry/bin $fish_user_paths
set -U fish_user_paths /Users/casey/.cargo/bin $fish_user_paths
set -U fish_user_paths /Users/casey/.local/bin $fish_user_paths set -U fish_user_paths /usr/local/opt/llvm/bin $fish_user_paths

set -gx PATH /usr/local/mysql-shell/bin $PATH



# pnpm
set -gx PNPM_HOME "/Users/casey/Library/pnpm"
set -U fish_user_paths $PNPM_HOME $fish_user_paths

# ruby
set -U fish_user_paths /usr/local/opt/ruby@2.7/bin $fish_user_paths

if test -x (command -v rbenv)
    eval (rbenv init - | source)
end

# llvm
set -U fish_user_paths /usr/local/opt/llvm/bin $fish_user_paths

# prompt
# function fish_prompt
#     echo -n (prompt_pwd) '> '
# end

# function fish_prompt
#     # Determine the Git branch
#     set -l git_branch
#     if command git rev-parse --is-inside-work-tree >/dev/null 2>&1
#         set git_branch (git symbolic-ref --short HEAD 2>/dev/null)
#     end
#
#     # Construct the prompt
#     echo -n (prompt_pwd)
#
#     # If in a Git repo, display the branch name
#     if test -n "$git_branch"
#         echo -n " ($git_branch)"
#     end
#
#     echo -n '> '
# end

function fish_prompt
    # Determine the Git branch or short commit hash
    set -l git_info
    if command git rev-parse --is-inside-work-tree >/dev/null 2>&1
        # Get branch name or fall back to the short commit hash if in detached HEAD
        set git_info (git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)

        # Determine whether we're in detached HEAD state
        if git symbolic-ref --short HEAD >/dev/null 2>&1
            set git_info (set_color green)$git_info(set_color normal)
        else
            set git_info (set_color red)$git_info(set_color normal)
        end
    end

    # Construct the prompt
    echo -n (prompt_pwd)

    # If in a Git repo, display the branch name or short commit hash
    if test -n "$git_info"
        echo -n " ($git_info)"
    end

    echo -n '> '
end

function ce
    if set -q argv[1]
        cd ~/Dev/ezkl-work/$argv[1]
    else
        cd ~/Dev/ezkl-work
    end
end


# alias
alias vim "nvim"
alias vi "nvim"
# alias ce "cd ~/Dev/ezkl-work"
alias vfc "vi ~/.config/fish/config.fish"
alias vvc "vi ~/.config/nvim/init.lua"
alias vtc "vi ~/.tmux.conf"
alias ls "ls -1tr"

alias sfc "source ~/.config/fish/config.fish"

alias cat "ccat"

# Git Aliases
alias g "git"
alias gco "git checkout"
alias gcb "git checkout -b"
alias gb "git branch"
alias gaa "git add ."
alias gcm "git commit -m"
alias gst "git status"

alias t "tmux"
alias tks "tmux kill-server"

function ghis
    if not set -q argv[1]
        echo "Please provide a search term."
        return 1
    end

    history search --contains $argv[1]
end

function cf
    cat $argv | pbcopy
end

function pf
    pbpaste > $argv
end

# function cd
#     # If no arguments are provided, just switch to the home directory.
#     if not set -q argv[1]
#         builtin cd
#         return
#     end
#
#     set -l dir $argv[1]
#
#     # If the argument consists solely of dots...
#     if string match -qr '^\.\+$' -- $dir
#         # Count the number of dots minus one
#         set -l num_dots (string length -q -- $dir)
#         set -l num_up_dirs (math "$num_dots - 1")
#
#         # Construct the path
#         set -l path_string ""
#         for i in (seq $num_up_dirs)
#             set path_string "$path_string../"
#         end
#
#         # Change to the path
#         builtin cd $path_string
#     else
#         # If not solely dots, just pass the argument to the original cd command
#         builtin cd $argv
#     end
# end
