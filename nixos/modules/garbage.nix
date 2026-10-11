{
  nix.settings.auto-optimise-store = true;
  
  # Automatic updating
  # system.autoUpgrade.enable = true;
  # system.autoUpgrade.dates = "weekly";

  # Automatic cleanup
  nix.gc = {
    automatic = true;
    dates = "weekly"; # "daily" timer for checkup
    options = "--delete-older-than 7d";
  };
}
