{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/gabriel/.config/sops/age/keys.txt";
    secrets = {
      "github/github" = {
        owner = config.users.users.gabriel.name;
        group = config.users.users.gabriel.group;
        path = "/home/gabriel/.ssh/github";
        mode = "0600";
      };
      "github/github.pub" = {
        owner = config.users.users.gabriel.name;
        group = config.users.users.gabriel.group;
        path = "/home/gabriel/.ssh/github.pub";
        mode = "0644";
      };
    };
  };
}
