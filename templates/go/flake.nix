{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let
        system = "aarch64-darwin";
        pkgs = import nixpkgs {
          inherit system;
        };
    in
    {
      devShells.${system}.default = with pkgs; mkShell {
        packages = [
          go
          gopls
          gotools
          go-tools
        ];
      };
    };
}