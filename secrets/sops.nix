{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/nixos/.config/sops/age/keys.txt";
    secrets = {
      "github/github" = {
        owner = config.users.users.nixos.name;
        group = config.users.users.nixos.group;
        path = "/home/nixos/.ssh/github";
        mode = "0600";
      };
      "github/github.pub" = {
        owner = config.users.users.nixos.name;
        group = config.users.users.nixos.group;
        path = "/home/nixos/.ssh/github.pub";
        mode = "0644";
      };
    };
  };
}
