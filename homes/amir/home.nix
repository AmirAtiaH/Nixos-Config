{ config, pkgs, inputs, lib, state-version, user-name, git-name, git-mail, ... }: {

  imports = [
    ./modules
    ./home-packages.nix
  ];

  home = {
    username = user-name;
    homeDirectory = "/home/${user-name}";
    stateVersion = state-version;
  };

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


  dconf.settings = {
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
  };


  gtk = {
    enable = true;
    theme = {
      name = "Pop-dark";
      package = pkgs.pop-gtk-theme;
    };
    iconTheme = {
      name = "Pop";
      package = pkgs.pop-icon-theme;
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
