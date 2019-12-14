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

    # apt install kde-plasma-desktop sddm-theme-debian-breeze plasma-nm firefox krusader kompare krename lhasa zip arj unace rar unrar rpm p7zip synaptic
    # ln -s /home/debianuser/.config .config

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

    $ sudo apt install git zsh zsh-syntax-highlighting tilda yakuake rxvt-unicode
    $ sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
