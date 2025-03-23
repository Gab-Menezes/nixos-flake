{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, nix-darwin, ... }@inputs: 
  let
    nixosPc = {
      host = "nixos";
      user = "gabriel";
      system = "x86_64-linux";
    };

    macPc = {
      host = "mac";
      user = "krea";
      system = "aarch64-darwin";
    };
  in
    {
      nixosConfigurations = {
        ${nixosPc.host} = nixpkgs.lib.nixosSystem {
          specialArgs = { 
            system = nixosPc.system;
            pc = nixosPc;
            inherit inputs;
          };
          modules = [ ./nixos/configuration.nix ];
        };
      };
      darwinConfigurations = {
        ${macPc.host} = nix-darwin.lib.darwinSystem {
          system = macPc.system;
          specialArgs = { 
            system = macPc.system; 
            pc = macPc;
            inherit inputs;
          };
          modules = [ ./mac/configuration.nix ];
        };
      };

      templates = {
        rust = {
          description = "Rust shell dev environment";
          path = ./templates/rust;
        };
        r = {
          description = "R shell dev environment";
          path = ./templates/r;
        };
        java = {
          description = "Java shell dev environment";
          path = ./templates/java;
        };
      };
    };
}