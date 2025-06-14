
{ inputs, config, pkgs, lib, ... }: {

  programs.niri.enable = true;
  nixpkgs.overlays = [inputs.niri.overlays.niri];
  programs.niri.package = pkgs.niri-stable;

  environment.systemPackages = with pkgs; [
    wl-clipboard
    wayland-utils
    libsecret
    xwayland-satellite
    swaybg
    mako
  ];
}
