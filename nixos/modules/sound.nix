{
  hardware.pulseaudio.enable = false;
  sound.enable = true;

  # rtkit is optional but recommended
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    jack.enable = true;
    
    # Bluetooth Configuration
    bluetooth = {
      enable = true;  # Enables PipeWire's Bluetooth audio support
      a2dp.defaultCodec = "aptx";  # Or "ldac", if needed
    };
  };
}
