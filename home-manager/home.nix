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
    stateVersion = "25.05";
	
    packages = with pkgs; [
      # Desktop apps
      # telegram-desktop
      # discord
      # obsidian
      wireshark
      firefox
      # mpv # media player
      # ffmpeg # screen recorder 
      # kdenlive # video editor
      # obs-studio
      networkmanagerapplet # gui network manager

      # CLI utils
      lf
      acpi
      neovim
      kitty # gpu acceleration
      picom
      # yt-dlp # audi/vid youtube downloader
      mediainfo
      # lazygit
       
      # Keychain
      # gcr
      # keepassxc 

      # Code Langs
      # python313
      nodejs_24
      go

      # Code Things
      vscode
      devenv
      direnv
      gnumake
      docker

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
      seahorse
      # screenkey
      
      # Screenshotting
      flameshot

    ];
  };
}
