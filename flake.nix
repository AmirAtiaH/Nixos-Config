{
  description = "My NixOS Configuration";

  inputs = {
    # stable branch
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    
    # zen Browser
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # stylix
    stylix = {
      url = "github:nix-community/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, stylix, ... } @ inputs:
  let


    system = "x86_64-linux";
    hosts = [
      {
        user-name = "amir";
        user-info = "AmirAtia";
        host-name = "pixel";
        state-version = "25.05";
        git-name = "AmirAtiaH";
        git-mail = "amir.gppume@gmail.com";
      }
    ];
    makeSystem = { user-name, user-info, host-name, state-version, git-name, git-mail }: nixpkgs.lib.nixosSystem {
      system = system;
      specialArgs = {
        inherit inputs user-name user-info host-name state-version;
      };
      modules = [
        ./hosts/${host-name}/default.nix
        stylix.nixosModules.stylix
      ];
    };


  in {


    nixosConfigurations = nixpkgs.lib.foldl' (configs: host:
      configs // {
        "${host.host-name}" = makeSystem {
          inherit (host) user-name user-info host-name state-version git-name git-mail;
        };
      }) {} hosts;

    homeConfigurations = nixpkgs.lib.foldl' (configs: host:
      configs // {
        "${host.user-name}" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          extraSpecialArgs = {
            inherit inputs;
            inherit (host) user-name host-name state-version git-name git-mail;
          };
          modules = [
            ./homes/${host.user-name}/home.nix
          ];
        };
      }) {} hosts;

      
  };
}
