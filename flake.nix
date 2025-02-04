{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-wsl, ... }@inputs: 
  let
    system = "x86_64-linux";
  in
    {
      nixosConfigurations = {
        wsl = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            nixos-wsl.nixosModules.default
            ./wsl/configuration.nix
          ];
        };
        nixos = nixpkgs.lib.nixosSystem {
          specialArgs = { 
            inherit system; 
            inherit inputs;
          };
          modules = [ ./nixos/configuration.nix ];
        };
      };

      templates = {
        rust = {
          description = "Rust shell dev environment";
          path = ./templates/rust;
        };
      };
    };
}