{ pkgs, ... }: {

  imports = [
    ./modules/bundle.nix
  ];

  #disabledModules = [
  #  ./modules/env.nix
  #];

  nixpkgs.config.allowUnfree = true;

  home = {
    username = "unreal";
    homeDirectory = "/home/unreal";
    stateVersion = "24.05";
	
    packages = with pkgs; [
      # Desktop apps
      # telegram-desktop
      # discord
      # obsidian
      firefox
      # mpv # media player
      # ffmpeg # screen recorder 
      # kdenlive # video editor
      # obs-studio

      # CLI utils
      lf
      acpi
      neovim
      kitty # gpu acceleration
      picom
      keepassxc
      # yt-dlp # audi/vid youtube downloader
      mediainfo
      # lazygit
      networkmanagerapplet # gui network manager

      # Code Langs

      # Xorg stuff
      xclip
      xorg.xbacklight
      xorg.xmodmap
      xkb-switch

      # WMs and stuff
      awesome
	 		
      # GUI utils
      ncdu
      vlc
      feh # Opening image in cli
      # imv
      xfce.thunar
      xfce.thunar-volman
      xfce.tumbler
      gromit-mpx # drawing on screen
      dunst # X11
      # mako # Wayland
      dmenu      
      # screenkey
      
      # Screenshotting
      flameshot

    ];
  };
}
