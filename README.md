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
