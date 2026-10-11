{ pkgs, ... }: {
  programs.zsh.enable = true;

  users = {
    defaultUserShell = pkgs.zsh;

    users.unreal = {
      isNormalUser = true;
      description = "unreal";
      extraGroups = [ "networkmanager" "wheel" "input" "libvirtd" "docker" ];
      packages = with pkgs; [];
    };
  };
}
