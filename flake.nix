{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    }; 
  };

  outputs = { self, nixpkgs, nixos-wsl, ... }@inputs: 
  let
    system = "x86_64-linux";
    # pkgs = nixpkgs.legacyPackages.${system};
  in
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            nixos-wsl.nixosModules.default
            ./configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };
      };

      # devShells.${system}.default = with pkgs; mkShell { 
      #   packages = [ nil ];
      # };
    };
}

