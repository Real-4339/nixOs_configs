{ pkgs, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.systemPackages = with pkgs; [
    # Desktop apps
    gparted

    # CLI utils
    neofetch
    tree
    wget
    git
    fastfetch
    htop
    unzip
    zip
    openssl

    # Sound
    mpd
    pipewire
    pipewire-pulse
    pipewire-bluetooth
    # pulseaudio
    # pavucontrol
    pamixer
    bluez
    bluez-tools
    bluez-alsa

    # Packages for virtual surround sound (will require configuration)
    # pulseaudio-modules-bt 
    # paprefs

    # CPU amd

    # GPU nvidia 
    # nvidia-vulkan-icd
    # nvidia-opencl-icd
    # glaxnimate

    # Battery
    tlp
    xscreensaver
    brightnessctl # light
    # hypridle
	
    # Login Manager
    xsecurelock

    # Other
    home-manager
    # papirus-nord

  ];

  fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts
    noto-fonts-emoji
    twemoji-color-font
    font-awesome
    powerline-fonts
    powerline-symbols
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  ];
}