{

  imports = [
    ./zsh.nix
    ./modules/bundle.nix
  ];

  disabledModules = [
    ./modules/env.nix
  ];

  home = {
    username = "unreal";
    homeDirectory = "/home/unreal";
    stateVersion = "23.11"; # idk
	
	packages = with pkgs; [
		# Desktop apps
	    telegram-desktop
	    discord
	    obsidian
	    firefox
	    mpv # media player
	    ffmpeg # screen recorder 
	    # kdenlive # video editor
	    # obs-studio

		# Coding stuff

		# CLI utils
		lf
		keepassxc
		# yt-dlp # audi/vid youtube downloader
		# mediainfo
		# lazygit
		# networkmanagerapplet # gui network manager

		# Xorg stuff
		kitty
		xclip
		xorg.xbacklight
	
		# WMs and stuff
		awesome
		# zsh
		
		# GUI utils
		vlc
		feh
	    imv
	    kdePackages.dolphin
	    gromit-mpx # drawing on screen
	    dunst
		# mako
	    # dmenu
	    # screenkey

		# Screenshotting
		flameshot
	];

  };
}