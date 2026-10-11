{ pkgs, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.systemPackages = with pkgs; [
    # Desktop apps
    # gparted

    # CLI utils
    neofetch
    tree
    wget
    git
    # fastfetch
    # htop
    unzip
    zip
    openssl

    # Sound
    mpd
    pipewire
    pamixer
    #bluez
    #bluez-tools
    #bluez-alsa

    # Battery
    tlp
    xscreensaver
    brightnessctl # light

    # Other
    home-manager
    mesa
    libglvnd
    dconf
  ];

  fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts
    noto-fonts-emoji
    twemoji-color-font
    font-awesome
    powerline-fonts
    powerline-symbols
    nerd-fonts.symbols-only
    # (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  ];
}
