{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    fenix = {
      url = "github:nix-community/fenix/monthly";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, fenix, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { 
        inherit system; 
        overlays = [ fenix.overlays.default ];
      };
      libPath = with pkgs; lib.makeLibraryPath [
        "${pkgs.stdenv.cc.cc.lib}"
        "${pkgs.openssl.out}"
      ];
      clangVersion = "19";
    in 
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          (pkgs.fenix.complete.withComponents [
              "cargo"
              "clippy"
              "rust-src"
              "rustc"
              "rustfmt"
              "miri"
          ])
          pkgs.cargo-show-asm
          pkgs.cargo-expand
          pkgs.cargo-flamegraph
          pkgs.cargo-valgrind
          pkgs.cargo-fuzz

          pkgs.rust-analyzer-nightly
          pkgs.openssl
          pkgs.pkg-config

          pkgs."clang_${clangVersion}"
          pkgs."llvmPackages_${clangVersion}".bintools
          pkgs.cmake
        ];

        LD_LIBRARY_PATH = libPath;
        LIBCLANG_PATH = pkgs.lib.makeLibraryPath [ pkgs."llvmPackages_${clangVersion}".libclang.lib ];
      };
    };
}
