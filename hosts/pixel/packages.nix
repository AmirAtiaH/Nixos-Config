# system-packages.nix

{ pkgs, inputs, ... }:
{
  imports = [
    ../../modules/nixos/services/postgresql.nix
  ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    flatpak
    cups

    mangohud
    protonup-qt
    wineWow64Packages.stagingFull

    git
    gh
    curl
    gcc15
    clang-tools

    nodejs_24
    zig_0_13
    python313

    helix
    vscode
    zed-editor

    dotnet-sdk
    dotnet-runtime
    dotnet-aspnetcore
    dotnet-ef
    omnisharp-roslyn

    postgresql
    dbeaver-bin

    kitty
    eww
    fuzzel
    yazi
    mpv
    home-manager

    # Custom inputs (e.g., zen-browser)
    inputs.zen-browser.packages.${pkgs.system}.default
    vesktop
  ];
}
