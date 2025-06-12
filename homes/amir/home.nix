{ pkgs, inputs, lib, config, state-version, user-name, git-name, git-mail, ... }: {

  imports = [
    ./packages.nix
    ../../modules/home/niri.nix
  ];





  /*options = {
    hm = {
      modules = lib.mkOption {
        default = [ ];
        type = with lib.types; listOf raw;
        description = "Modules to be included by home manager";
      };
      stateVersion = lib.mkOption {
        default = "23.11";
        type = lib.types.str;
        description = "State Version of home-manager. DON'T CHANGE UNLESS NESSESAIRY!";
      };
    };
  };*/






  home = {
    username = user-name;
    homeDirectory = "/home/${user-name}";
    stateVersion = state-version;
  };



  nixpkgs.config.allowUnfree = true;

  /*home.packages = with pkgs; [
    vesktop
    telegram-desktop
    dino
  ];*/




  # configure dotfiles (e.g., fish, git)
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    shellAliases = {
      nix-switch = "sudo nixos-rebuild switch --flake /etc/nixos#pixel";
      nix-update = ''
        sudo nix flake update /etc/nixos
        sudo nixos-rebuild switch --flake /etc/nixos#pixel
      '';
      nix-delete-all = "sudo nix-collect-garbage -d";
      nix-delete = ''
        sudo nix-env --delete-generations +4
        sudo nix-collect-garbage -d
      '';
      nix-git = ''
        cd /etc/nixos
        sudo git add .
        sudo git commit -m "justme"
        sudo git push -u origin master
        cd -
      '';
    };
  };


  programs.git = {
    enable = true;
    userName = git-name;
    userEmail = git-mail;
  };


  /*dconf.settings = {
    "org/gnome/desktop/input-sources" = {
      sources = [
        (lib.hm.gvariant.mkTuple ["xkb" "us"])
        (lib.hm.gvariant.mkTuple ["xkb" "ara"])
      ];
      current = 0;
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Pop-dark";
      icon-theme = "Pop";
      cursor-theme = "Pop";
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
    };
    
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        blur-my-shell.extensionUuid
        appindicator.extensionUuid
        emoji-copy.extensionUuid
      ];
    };
  };*/


  gtk = {
    enable = true;
    theme = {
      name = "adwaita-dark";
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "adwaita-dark";
  };


  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/http" = "zen-browser.desktop";
    "x-scheme-handler/https" = "zen-browser.desktop";
  };


  # let Home Manager manage itself (required)
  programs.home-manager.enable = true;
}
