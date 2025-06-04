{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];
  
  
  # temp
  nix.settings.experimental-features = ["nix-command" "flakes"];
    
    
  # bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  # kernel
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_14;

  # network manager
  networking.networkmanager.enable = true;

  networking.hostName = "pixel"; # Define your hostname.
  
  
  # time zone
  time.timeZone = "Africa/Cairo";


  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  
  # users
  users.users.amir = {
    isNormalUser = true;
    description = "AmirAtia";
    extraGroups = [ "networkmanager" "wheel" ];
  };
  
  
  nixpkgs.config.allowUnfree = true;
      

  # flatpak
  services.flatpak.enable = true;


  # x11
  services.xserver.enable = true;
  
      
  # nvidia driver
  services.xserver.videoDrivers = ["nvidia"];
  
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    forceFullCompositionPipeline = true;  # fix screen tearing
    modesetting.enable = true;
    powerManagement.enable = true;
    nvidiaSettings = true;
    open = false;
  };



  # gaming
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;


  # apps
  environment.systemPackages = with pkgs; [
    mangohud
    wineWow64Packages.stagingFull
    nodejs_24
    zig_0_13

    python313

    dotnet-sdk
    postgresql
    dbeaver-bin

    tinywl
    kitty

    git
    gh
    curl
    gcc15
    jetbrains-mono
    vlc
    micro
    vscode
    protonup-qt
    neovim
    neovim-qt
    home-manager
  ];

  
  # postgre
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "testdb" ];
    ensureUsers = [
      {
        name = "amir";
      }
    ];
    authentication = pkgs.lib.mkOverride 10 ''
      # TYPE  DATABASE        USER            METHOD
      local   all             all             trust
      host    all             all   127.0.0.1/32    trust
      host    all             all   ::1/128        trust
      #local testdb amir peer
    '';

  };
  
  
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
  
  
  # Enable CUPS to print documents.
  services.printing.enable = true;


  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  

  system.stateVersion = "25.05";
}