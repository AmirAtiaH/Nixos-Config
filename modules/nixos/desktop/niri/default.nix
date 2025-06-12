{ inputs, config, pkgs, lib, ... }: {


  programs.niri.enable = true;
  nixpkgs.overlays = [inputs.niri.overlays.niri];

  environment.systemPackages = with pkgs; [
    wl-clipboard
    wayland-utils
    libsecret
    xwayland-satellite
    swaybg
    mako
  ];
}