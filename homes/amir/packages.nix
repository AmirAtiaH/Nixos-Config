# user packages (GUI apps, tools, etc.)

{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    pop-gtk-theme
    pop-icon-theme
    vesktop
    telegram-desktop
    dino
  ];
}