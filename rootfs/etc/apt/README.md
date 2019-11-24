## Post-installation
### Connect to the internet
To set up a network connection, go through the following steps:

- Ensure your __network interface__ is listed and enabled, for example with [`ip-link(8)`](https://jlk.fjfi.cvut.cz/arch/manpages/man/ip-link.8):

        # ip link

- Connect to the network. Plug in the Ethernet cable or __connect to the wireless LAN__.

    Just like other network interfaces, the wireless ones are controlled with _`ip`_ from the `iproute2` package.

    Managing a wireless connection requires a basic set of tools. Either use a __network manager__ or use __WPA supplicant__ directly.

- Configure your network connection:

    - __Static IP address__
    - Dynamic IP address: use __DHCP__.

        > Note: The installation image enables __`dhcpcd`__ (`dhcpcd@interface.service`) for __wired network devices__ on boot.

- The connection may be verified with [ping](https://en.wikipedia.org/wiki/ping):

        # ping debian.org

### Select the mirrors

    /etc/apt/sources.list
    ---
    ...

### Desktop environments

    # apt install kde-plasma-desktop sddm-theme-debian-breeze plasma-nm firefox krusader kompare krename lhasa zip arj unace rar unrar rpm p7zip synaptic
    # ln -s /home/debianuser/.config .config

### `sudo`

    # adduser foo sudo
    # adduser foo -G sudo

### Shell

    $ sudo apt install git zsh zsh-syntax-highlighting tilda yakuake rxvt-unicode
    $ sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
