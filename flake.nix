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
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... } @ inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs
    {
      inherit system;
      config.allowUnfree = true;
    };
  in  {
    nixosConfigurations.pixel = nixpkgs.lib.nixosSystem { # pixel is the hostname
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        # Home Manager integration
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            extraSpecialArgs = { inherit inputs pkgs; };
            useGlobalPkgs = true;
            useUserPackages = true;
            users.amir = import ./home.nix;
          };
        }
      ];
    };
  };
}