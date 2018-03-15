# General kitty
complete -c kitty -f
complete -c kitty -s h -l help -d 'Show help'

# Kitty options
complete -c kitty -l class -d 'Set the class part of the WM_CLASS property' -n 'not __kitty_is_message'
complete -c kitty -l title -d 'Set the window title' -n 'not __kitty_is_message'
complete -c kitty -l config -d 'Specify a path to the configuration file(s) to use' -n 'not __kitty_is_message'
complete -c kitty -s o -l override -d 'Override individual configuration option' -xa "(__kitty_config)" -n 'not __kitty_is_message'
complete -c kitty -s c -l cmd -d 'Run python code in the kitty context' -f -n 'not __kitty_is_message'
complete -c kitty -s d -l directory -d 'Change to specified directory when launching' -n 'not __kitty_is_message'
complete -c kitty -l detach -d 'Detach from the controlling terminal, if any' -n 'not __kitty_is_message'
complete -c kitty -l window-layout -d 'The window layout to use on startup' -n 'not __kitty_is_message' -xa 'tall grid vertical stack horizontal'
complete -c kitty -l session -d 'Path to a file containing the startup session' -rn 'not __kitty_is_message'
complete -c kitty -s 1 -l single-instance -d 'If specified only a single instance of kitty will run' -n 'not __kitty_is_message'
complete -c kitty -l instance-group -d 'Create window within instance group' -xn 'not __kitty_is_message; and __fish_contains_opt -s 1 single-instance'

# Kitty message options
complete -c kitty -n '__kitty_is_message' -d 'Ensure allow_remote_control yes is set' -xa "
  close-tab\t'Close the specified tab(s)'
  close-window\t'Close the specified window(s)'
  focus-window\t'Focus the specified window'
  focus-tab\t'Focus the specified tab'
  get-text\t'Get text from the specified window'
  ls\t'List all tabs/windows'
  new-window\t'Open new window'
  send-text\t'Send arbitrary text to specified windows'
  set-tab-title\t'Set the tab title'
  set-window-title\t'Set the window title'
"
complete -c kitty -s m -l match -d 'The tab to match. Match specifications are of the form: field:regexp' -xn '__kitty_is_message; and __kitty_is_cmd new-window'

function __kitty_config
  cat $HOME/.config/kitty/kitty.conf | grep -P "^[^#]" | grep -P "^(?!map)" | awk '{print $1}'
end

function __kitty_is_message
  test (commandline | grep "@")
end

function __kitty_is_cmd
  test (commandline | grep "$argv[1]")
end
