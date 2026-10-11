{
  # services.gvfs.enable = true; # Mount, trash, and other functionalities
  # services.tumbler.enable = true; # Thumbnail support for images
  # services.gnome-keyring = {
  #   enable = true;
  #   # Явно указываем компоненты, чтобы избежать конфликтов с твоим SSH-агентом
  #   components = [ "pkcs11" "secrets" ];
  #   # По умолчанию startWhenNeeded = true; что хорошо.
  #   # Демон будет запускаться, когда приложение запросит его D-Bus сервис.
  # };
}
