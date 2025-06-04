{ config, pkgs, inputs, lib, ... }: {
  home.username = "amir";
  home.homeDirectory = "/home/amir";
  home.stateVersion = "25.05";

  # install user packages (GUI apps, tools, etc.)
  home.packages = with pkgs; [
    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
    gnomeExtensions.pop-shell
    gnomeExtensions.paperwm
    gnomeExtensions.emoji-copy
    pop-gtk-theme
    pop-icon-theme
    discord
    dino
    inputs.zen-browser.packages."${pkgs.system}".default
  ];
  
  # configure dotfiles (e.g., bash, git)
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch --flake /etc/nixos#pixel";
    };
  };


  programs.git = {
    enable = true;
    userName = "AmirAtiaH";
    userEmail = "amir.gppume@gmail.com";
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
      disable-user-extensions = false; # enables user extensions
      enabled-extensions = with pkgs.gnomeExtensions; [
        blur-my-shell.extensionUuid
        appindicator.extensionUuid
        #pop-shell.extensionUuid
        paperwm.extensionUuid
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