## Post-installation
### Connect to the internet
To set up a network connection, go through the following steps:

- Ensure your __network interface__ is listed and enabled, for example with [`ip-link(8)`](https://jlk.fjfi.cvut.cz/arch/manpages/man/ip-link.8):

        # ip link
        # ip link set eth0 up

- Connect to the network. Plug in the Ethernet cable or __connect to the wireless LAN__.

    Just like other network interfaces, the wireless ones are controlled with _`ip`_ from the `iproute2` package.

    Managing a wireless connection requires a basic set of tools. Either use a __network manager__ or use __WPA supplicant__ directly.

- Configure your network connection:

    - __Static IP address__
    
        A static IP address can be configured with most standard network managers and also [dhcpcd](https://wiki.archlinux.org/index.php/Dhcpcd).

        To manually configure a static IP address, add an IP address as described in #IP addresses, set up your routing table and [configure your DNS servers](https://wiki.archlinux.org/index.php/Domain_name_resolution).

    - Dynamic IP address: use __DHCP__.

        > Note: The installation image enables __`dhcpcd`__ (`dhcpcd@interface.service`) for __wired network devices__ on boot.

- The connection may be verified with [ping](https://en.wikipedia.org/wiki/ping):

        # ping debian.org

### Time

    # timedatectl list-timezones
    # timedatectl set-timezone Asia/Shanghai
    # timedatectl set-local-rtc 0
    # hwclock --systohc

### Select the mirrors

    /etc/apt/sources.list
    ---
    ...

### Desktop environments

__KDE:__

<https://wiki.debian.org/KDE#Installation>

    # apt install kde-plasma-desktop sddm-theme-debian-breeze plasma-nm firefox krusader kompare krename lhasa zip arj unace rar unrar rpm p7zip synaptic
    # ln -s /home/debianuser/.config .config

__Xfce:__

<https://docs.xfce.org/#core_modules>

- [Application Finder (`xfce4-appfinder`)](https://docs.xfce.org/xfce/xfce4-appfinder/start) – Application to quickly run applications and commands
- [Configuration Storage System (`xfconf`)](https://docs.xfce.org/xfce/xfconf/start) – D-Bus-based configuration storage system
- [Desktop Manager (`xfdesktop`)](https://docs.xfce.org/xfce/xfdesktop/start) – Configure the desktop background image, icons, launchers and folders
- [Helper Applications (`exo`)](https://docs.xfce.org/xfce/exo/start) – Manage preferred applications and edit .desktop files
- [File Manager (`thunar`)](https://docs.xfce.org/xfce/thunar/start) – The fast and easy to use file manager for the Xfce Desktop
- [Panel (`xfce4-panel`)](https://docs.xfce.org/xfce/xfce4-panel/start) – Application launchers, window buttons, applications menu, workspace switcher and more
- [Power Manager (`xfce4-power-manager`)](https://docs.xfce.org/xfce/xfce4-power-manager/start) – Manage power sources and power consumption of devices
- [Session Manager (`xfce4-session`)](https://docs.xfce.org/xfce/xfce4-session/start) – Save the state of your desktop and restore it on the next startup
- [Settings Manager (`xfce4-settings`)](https://docs.xfce.org/xfce/xfce4-settings/start) – The Settings daemon which persists many Xfce settings
- [Window Manager (`xfwm4`)](https://docs.xfce.org/xfce/xfwm4/start) – Handles the placement of windows on the screen

<br>

    # apt install lightdm arctica-greeter arctica-greeter-guest-session arctica-greeter-remote-logon arctica-greeter-theme-debian light-locker lightdm-remote-session-freerdp2 lightdm-remote-session-x2go lightdm-settings
    # apt install xfce4-appfinder
    # apt install xfconf
    # apt install xfdesktop4
    # apt install exo-utils
    # apt install thunar thunar-archive-plugin xarchiver thunar-gtkhash thunar-media-tags-plugin thunar-vcs-plugin thunar-volman
    # apt install xfce4-panel xfce4-appmenu-plugin xfec4-clipman xfce4-clipman-plugin xfce4-cpufreq-plugin xfce4-cpugraph-plugin xfce4-datetime-plugin xfce4-diskperf-plugin xfce4-fsguard-plugin xfce4-genmon-plugin xfce4-indicator-plugin xfce4-mount-plugin xfce4-netload-plugin xfce4-places-plugin xfce4-power-manager-data xfce4-pulseaudio-plugin xfce4-screenshooter xfce4-sensors-plugin xfce4-statusnotifier-plugin xfce4-systemload-plugin xfce4-verve-plugi xfce4-whiskermenu-pluginn
    # apt install xfce4-power-manager
    # apt install xfce4-session
    # apt install xfce4-settings
    # apt install xfwm4 xfwm4-theme-breeze shiki-colors-xfwm-theme
    # apt install mousepad ristretto xfce4-notifyd xfce4-taskmanager xfce4-terminal xfce4-screensaver

<https://github.com/search?q=xfce&type=Repositories&s=stars&o=desc>

    # apt install breeze-cursor-theme breeze-gtk-theme breeze-icon-theme xfwm4-theme-breeze
    # apt install arc-theme elementary-xfce-icon-theme shiki-colors-xfwm-theme numix-gtk-theme numix-icon-theme numix-icon-theme-circle materia-gtk-theme

### `sudo`

    # sudo -lU user
    # usermod -aG sudo username
    # gpasswd -a user group
    # # Tip: The adduser script allows carrying out the jobs of useradd, chfn and passwd interactively.
    # adduser foo sudo
    # adduser foo -G sudo
    # members sudo
    # EDITOR=vim visudo

### Shell

    $ sudo apt install git zsh zsh-syntax-highlighting zsh-theme-powerlevel9k tilda yakuake rxvt-unicode
    $ sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

### [Fonts](https://wiki.archlinux.org/index.php/Fonts)

<https://github.com/topics/font?o=desc&s=stars>

To install fonts system-wide (available for all users), move the folder to the `/usr/share/fonts` directory. The files need to be readable by every user, use [chmod](https://wiki.archlinux.org/index.php/Chmod) to set the correct permissions (i.e. at least `0444` for files and `0555` for directories). To install fonts for only a single user, use `~/.local/share/fonts/` (`~/.fonts/` is now deprecated).

For Xserver to load fonts directly (as opposed to the use of a _font server_) the directory for your newly added font must be added with a FontPath entry. This entry is located in the _Files_ section [of your Xorg configuration file](https://wiki.archlinux.org/index.php/Xorg#Configuration) (e.g. `/etc/X11/xorg.conf` or `/etc/xorg.conf`). See [#Older applications](https://wiki.archlinux.org/index.php/Fonts#Older_applications) for more detail.

Then update the fontconfig font cache: (usually unnecessary as software using the fontconfig library does this)

    $ fc-cache

### Input methods

- [libpinyin/libpinyin: Library to deal with pinyin.](https://github.com/libpinyin/libpinyin)

- [sunpinyin/sunpinyin: A statistical language model based Chinese input method](https://github.com/sunpinyin/sunpinyin)

- [rime/librime: Rime Input Method Engine, the core library](https://github.com/rime/librime)

- [google/mozc: Mozc - a Japanese Input Method Editor designed for multi-platform](https://github.com/google/mozc)

<br>

    $ sudo apt install fcitx fcitx-config-gtk2 fcitx-module-cloudpinyin fcitx-sunpinyin fcitx-mozc
