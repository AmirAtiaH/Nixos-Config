{ pkgs, ... }: {
  # x11
  services.xserver.enable = true;
  
  
  # gnome
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = (with pkgs; [
    epiphany
    gedit
    gnome-music
    gnome-terminal
    totem
  ]);
}