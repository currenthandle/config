function __complete_ce
    # Check if we have any argument given during completion
    if set -q argv[1]
        # Construct path from given input and look for directories
        set -l target_dir ~/Dev/ezkl-work/$argv[1]*
    else
        # Default directory for initial completion
        set -l target_dir ~/Dev/ezkl-work/*
    end

    # Loop through the constructed path
    for file in $target_dir
        if test -d $file
            # Provide relative path as completion
            echo $file | string replace --regex "^~/Dev/ezkl-work/" ""
        end
    end
end

complete -c ce -a '(__complete_ce)'

