{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { 
        inherit system; 
      };
      r = pkgs.rWrapper.override{ packages = [ 
          pkgs.rPackages.ggplot2
          pkgs.rPackages.dplyr
          pkgs.rPackages.xts
          pkgs.rPackages.rmarkdown
          pkgs.rPackages.knitr
          pkgs.rPackages.tibble
          pkgs.rPackages.printr
          pkgs.rPackages.tidyverse
          pkgs.rPackages.tidymodels
          pkgs.rPackages.kknn
          pkgs.rPackages.mlbench
          pkgs.rPackages.GGally
          pkgs.rPackages.glmnet
          pkgs.rPackages.car
        ]; 
      };
    in 
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          r
          pkgs.texlive.combined.scheme-full
          pkgs.pandoc
        ];
      };
    };
}