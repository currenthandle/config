# ============================================================
# ENVIRONMENT VARIABLE LOADING
# ============================================================

# Load .env file if it exists
# This loads environment variables from a .env file into the current Fish shell session.
# Ensure that the .env file is not tracked by Git (add it to .gitignore).
if test -f .env
    # Read all non-comment lines with valid `key=value` pairs
    set -l env_vars (cat .env | grep -v '^#' | grep '=' | xargs)
    
    # Loop through each key=value pair and set it as a global variable
    for var in $env_vars
        set -gx (string split "=" $var)[1] (string split "=" $var)[2]
    end
end

# ============================================================
# ENVIRONMENT VARIABLES (MANUAL)
# ============================================================

# Set URLs and API keys for external services.
set -gx ARCHON_SERVER_URL "https://archon-v0.ezkl.xyz"

# ============================================================
# GENERAL SETTINGS
# ============================================================

# Enable Vi mode for Fish shell (allows Vi-style key bindings in the terminal)
fish_vi_key_bindings

# ============================================================
# PATH CONFIGURATION
# ============================================================

# Universal Path Settings
# Add commonly used directories to the universal path variable ($fish_user_paths).
set -U fish_user_paths /opt/homebrew/bin \
                       /Users/casey/.foundry/bin \
                       /Users/casey/.cargo/bin \
                       /Users/casey/.local/bin \
                       /Users/casey/Library/pnpm \
                       /usr/local/opt/ruby@2.7/bin \
                       /path/to/stripe/binary

# Project-specific Paths
# Add directories for EZKL and Archon projects
fish_add_path /Users/casey/.ezkl /Users/casey/.archon

# Android Development Paths
# Set the Android SDK home directory and add related tools to the PATH.
set -gx ANDROID_HOME ~/Library/Android/sdk
fish_add_path $ANDROID_HOME/platform-tools \
              $ANDROID_HOME/tools \
              $ANDROID_HOME/tools/bin \
              $ANDROID_HOME/emulator

# Node.js Package Manager (pnpm)
# Add pnpm's installation directory to the PATH.
set -gx PNPM_HOME "/Users/casey/Library/pnpm"
fish_add_path $PNPM_HOME

# Bun (JavaScript runtime)
# Add Bun's installation directory to the PATH.
set --export BUN_INSTALL "$HOME/.bun"
fish_add_path $BUN_INSTALL/bin

# Conda (Python environment management)
# Initialize Conda if available.
if test -f /opt/miniconda3/bin/conda
    eval /opt/miniconda3/bin/conda "shell.fish" "hook" $argv | source
else if test -f "/opt/miniconda3/etc/fish/conf.d/conda.fish"
    source "/opt/miniconda3/etc/fish/conf.d/conda.fish"
else
    fish_add_path /opt/miniconda3/bin
end

# ============================================================
# COMPILER CONFIGURATION
# ============================================================

# Compiler Paths
# Set the default C and C++ compilers to LLVM's Clang (installed via Homebrew).
set -gx CC /opt/homebrew/opt/llvm/bin/clang
set -gx CXX /opt/homebrew/opt/llvm/bin/clang++

# Environment Variables for Compilation
# Set linker flags (LDFLAGS), C preprocessor flags (CPPFLAGS), and specify the linker binary (LD).
set -gx LDFLAGS "-L/opt/homebrew/opt/llvm/lib"
set -gx CPPFLAGS "-I/opt/homebrew/opt/llvm/include"
set -gx LD /opt/homebrew/opt/llvm/bin/lld

# Add PostgreSQL's pkg-config path and preserve existing entries in $PKG_CONFIG_PATH.
set -gx PKG_CONFIG_PATH "/opt/homebrew/opt/libpq/lib/pkgconfig:$PKG_CONFIG_PATH"

# Add LLVM executables to PATH for easy access to LLVM tools like Clang and LLD.
fish_add_path /opt/homebrew/opt/llvm/bin

# ============================================================
# PYTHON CONFIGURATION
# ============================================================

# Pyenv Initialization
# Ensure pyenv and its virtualenv plugin are initialized.
set -gx PYENV_ROOT $HOME/.pyenv
fish_add_path $PYENV_ROOT/shims
status --is-interactive; and source (pyenv init -|psub)
status --is-interactive; and source (pyenv virtualenv-init -|psub)

# Custom Function: `pip`
# Use the pip command from an active virtual environment or fallback to pyenv's Python.
function pip
    if set -q VIRTUAL_ENV
        $VIRTUAL_ENV/bin/python -m pip $argv
    else
        eval (pyenv which python) -m pip $argv
    end
end

# ============================================================
# CUSTOM FUNCTIONS
# ============================================================

# Custom Prompt Function
# Define a custom Fish shell prompt that includes the current Git branch (if applicable).
function fish_prompt
    set -l git_info
    if command git rev-parse --is-inside-work-tree >/dev/null 2>&1
        set git_info (git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
        set git_info (set_color green)$git_info(set_color normal)
    end
    echo -n (prompt_pwd) (test -n "$git_info"; and echo -n " ($git_info)")'> '
end

# Custom Function: `ce`
# Quickly change to a project directory under ~/Dev/ezkl-work.
function ce
    cd ~/Dev/ezkl-work/(commandline -p)
end

# Custom Function: `cap`
# Display the contents of multiple files, with a comment-like prefix.
function cap
    for file in $argv
        echo "// $file"
        echo ""
        cat $file
        echo ""
    end
end

# ============================================================
# ALIASES
# ============================================================

# General Aliases
alias vim="nvim"           # Use Neovim instead of Vim
alias vi="nvim"            # Alias `vi` to Neovim
alias vfc="vi ~/.config/fish/config.fish"  # Open Fish shell config
alias vvc="vi ~/.config/nvim/init.lua"    # Open Neovim config
alias ls="lsd -1tr"        # List files in a tree view (requires `lsd` installed)

# Git Aliases
alias g="git"              # Short alias for Git
alias gco="git checkout"   # Checkout a Git branch
alias gcb="git checkout -b" # Create and switch to a new Git branch
alias gb="git branch"      # Show Git branches
alias gst="git status"     # Show Git status
alias gp="git push"        # Push changes to Git
alias gcm="git commit -m"  # Commit with a message
alias gaa="git add ."      # Add all changes to Git
alias gpom="git push origin main"  # Push to `main` branch on origin
alias gpos="git push origin staging" # Push to `staging` branch on origin
alias gpum="git push upstream main" # Push to `main` branch on upstream
alias gpus="git push upstream staging" # Push to `staging` branch on upstream

# Utility Aliases
alias sfc="source ~/.config/fish/config.fish" # Reload Fish config
alias cs 'find ~/.local/state/nvim/swap -name "*.swp" -delete' # Clean Neovim swap files
alias pbc="pbcopy"         # Copy to clipboard (macOS)
alias pbp="pbpaste"        # Paste from clipboard (macOS)
alias t="tmux"             # Start tmux
alias tks="tmux kill-server" # Kill all tmux sessions
alias cat="ccat"           # Use colorized cat

# ============================================================
# SHORTCUT VARIABLES
# ============================================================

# Define frequently used paths as variables for convenience.
set -xg vc ~/.config/nvim    # Neovim config directory
set -xg fc ~/.config/fish    # Fish config directory
set -xg ew ~/Dev/ezkl-work   # EZKL work directory

# ============================================================
# NOTES & MISC
# ============================================================

# Rust Configuration Notes
# Ensure necessary linker flags are added to Rust's `.cargo/config.toml`.
# Uncomment and set these in `.cargo/config.toml`:
# [target.x86_64-apple-darwin]
# rustflags = ["-C", "link-arg=-fuse-ld=lld"]
# [target.aarch64-apple-darwin]
# rustflags = ["-C", "link-arg=-fuse-ld=/opt/homebrew/opt/llvm/bin/ld64.lld"]

