{ config, pkgs, state-version, host-name, user-name, user-info, inputs, ... }:

{
  imports =
    [
      ./hardware.nix
      ./packages.nix

      ../../modules/nixos/user.nix
      ../../modules/nixos/audio.nix
      ../../modules/nixos/bluetooth.nix
      ../../modules/nixos/boot-loader.nix
      ../../modules/nixos/fish.nix
      ../../modules/nixos/gaming.nix
     # ../../modules/nixos/desktop/gnome.nix
      ../../modules/nixos/desktop/niri/default.nix
      ../../modules/nixos/stylix.nix
      ../../modules/nixos/kernel.nix
      ../../modules/nixos/localization.nix
      ../../modules/nixos/networking.nix
      ../../modules/nixos/nvidia.nix
      ../../modules/nixos/time-zone.nix
    ];
  

  system.stateVersion = state-version;
  nix.settings.experimental-features = ["nix-command" "flakes"];
}
