{
  services.xserver = {
    enable = true;
    windowManager.awesome.enable = true;
    # windowManager.herbstluftwm.enable = true;

    displayManager.lightdm = {
      greeters.gtk.enable = true;
      enable = true;
    };

    xkb.layout = "us, ru";
    xkb.variant = "";
    xkbOptions = "grp:alt_shift_toggle";

    # videoDrivers = [ "nvidia" ];
    # deviceSection = ''Option "TearFree" "True"'';
  };
  services.libinput = {
      enable = true;
      mouse.accelProfile = "flat";
      touchpad.accelProfile = "flat";
  };
}
