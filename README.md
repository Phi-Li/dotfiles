# dotfiles

## XDG Base Directory

https://wiki.archlinux.org/index.php/XDG_Base_Directory

### Specification

Only `XDG_RUNTIME_DIR` is set by default through `pam_systemd`. It is up to the user to explicitly define the other variables, using absolute paths that point to existing directories.

#### User directories

- `XDG_CONFIG_HOME`

  - User-specific configurations (analogous to `/etc`)
  - Default: `$HOME/.config`

- `XDG_CACHE_HOME`

  - User-specific non-essential (cached) data (analogous to `/var/cache`)
  - Default: `$HOME/.cache`

- `XDG_DATA_HOME`

  - User-specific data files (analogous to `/usr/share`)
  - Default: `$HOME/.local/share`
  
- `XDG_RUNTIME_DIR`

#### System directories

List of directories seperated by `:` (analogous to `PATH`)

- `XDG_DATA_DIRS`

  - Default: `/usr/local/share:/usr/share`
  
- `XDG_CONFIG_DIRS`

  - Default: `/etc/xdg`

## XDG user directories

https://wiki.archlinux.org/index.php/XDG_user_directories

### Creating default directories

    $ xdg-user-dirs-update
    
### Creating custom directories

    ~/.config/user-dirs.dirs
    ---
    XDG_DESKTOP_DIR="$HOME/Desktop"
    XDG_DOCUMENTS_DIR="$HOME/Documents"
    XDG_DOWNLOAD_DIR="$HOME/Downloads"
    XDG_MUSIC_DIR="$HOME/Music"
    XDG_PICTURES_DIR="$HOME/Pictures"
    XDG_PUBLICSHARE_DIR="$HOME/Public"
    XDG_TEMPLATES_DIR="$HOME/Templates"
    XDG_VIDEOS_DIR="$HOME/Videos

<br>

    $ xdg-user-dirs-update --set DOWNLOAD ~/Internet

## [Zsh Startup/Shutdown files](https://wiki.archlinux.org/index.php/Zsh#Startup/Shutdown_files)

> __Tip:__
>    - See [A User's Guide to the Z-Shell](http://zsh.sourceforge.net/Guide/zshguide02.html) for explanation on interactive and login shells, and what to put in your startup files.
>    - You could consider [implementing a standard path](https://wiki.archlinux.org/index.php/Command-line_shell#Standardisation) for your Zsh configuration files.

> __Note:__
>    - If `$ZDOTDIR` is not set, `$HOME` is used instead.
>    - If option `RCS` is unset in any of the files, no configuration files will be read after that file.
>    - If option `GLOBAL_RCS` is unset in any of the files, no global configuration files (`/etc/zsh/*`) will be read after that file.

When starting, Zsh will read commands from the following files in this order by default:

1. `/etc/zsh/zshenv` Used for setting [environment variables](https://wiki.archlinux.org/index.php/Environment_variables) for all users; it should not contain commands that produce output or assume the shell is attached to a TTY. This file will ___always___ be read, this cannot be overridden.
2. `$ZDOTDIR/.zshenv` Used for setting user's environment variables; it should not contain commands that produce output or assume the shell is attached to a TTY. This file will ___always___ be read.
3. `/etc/zsh/zprofile` Used for executing commands at start for all users, will be read when starting as a ___login shell___. Please note that on Arch Linux, by default it contains [one line](https://projects.archlinux.org/svntogit/packages.git/tree/trunk/zprofile?h=packages/zsh) which source the `/etc/profile`.
    - `/etc/profile` This file should be sourced by all POSIX sh-compatible shells upon login: it sets up `$PATH` and other environment variables and application-specific `(/etc/profile.d/*.sh`) settings upon login.
4. `$ZDOTDIR/.zprofile` Used for executing user's commands at start, will be read when starting as a ___login shell___. Typically used to autostart graphical sessions and to set session-wide environment variables.
5. `/etc/zsh/zshrc` Used for setting interactive shell configuration and executing commands for all users, will be read when starting as an ___interactive shell___.
6. `$ZDOTDIR/.zshrc` Used for setting user's interactive shell configuration and executing commands, will be read when starting as an ___interactive shell___.
7. `/etc/zsh/zlogin` Used for executing commands for all users at ending of initial progress, will be read when starting as a ___login shell___.
8. `$ZDOTDIR/.zlogin` Used for executing user's commands at ending of initial progress, will be read when starting as a ___login shell___. Typically used to autostart command line utilities. Should not be used to autostart graphical sessions, as at this point the session might contain configuration meant only for an interactive shell.
9. `$ZDOTDIR/.zlogout` Used for executing commands for all users when a ___login shell___ __exits__.
10. `/etc/zsh/zlogout` Used for executing commands when a ___login shell___ __exits__.

See [the graphic representation](https://blog.flowblok.id.au/2013-02/shell-startup-scripts.html#implementation).

> __Note:__
>    - `$HOME/.profile` is not a part of the Zsh startup files and __is not sourced__ by Zsh unless Zsh is invoked as `sh` or `ksh` and started as a login shell. For more details about the sh and ksh compatibility modes refer to [zsh(1)](https://jlk.fjfi.cvut.cz/arch/manpages/man/zsh.1#COMPATIBILITY).
>    - The paths used in Arch's [zsh](https://www.archlinux.org/packages/?name=zsh) package are different from the default ones used in the [man pages](https://wiki.archlinux.org/index.php/Man_page) ([FS#48992](https://bugs.archlinux.org/task/48992)).

> __Warning:__ Do not remove the default [one line](https://projects.archlinux.org/svntogit/packages.git/tree/trunk/zprofile?h=packages/zsh) in `/etc/zsh/zprofile`, otherwise it will break the integrity of other packages which provide some scripts in `/etc/profile.d/`.
