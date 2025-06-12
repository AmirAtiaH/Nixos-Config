# user packages (GUI apps, tools, etc.)

{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    telegram-desktop
    dino
  ];
}
