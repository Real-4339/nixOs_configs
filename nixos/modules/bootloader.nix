{
  boot.loader.systemd-boot.enable = true;  
  boot.loader.efi.canTouchEfiVariables = true; 
  # boot.initrd.kernelModules = [ "amdgpu" ]; 
  # boot.initrd.kernelModules = [ "vboxvideo" ];
  boot.kernelParams = [ "psmouse.synaptics_intertouch=0" ]; 
}
