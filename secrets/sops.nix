{ config, lib, pkgs, inputs, pc, ... }:
let
  inherit (pkgs) stdenv;
in
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  # a = stdenv.isLinux;

  sops = {
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/${pc.user}/.config/sops/age/keys.txt";
    secrets = {
      "github/github" = {
        owner = config.users.users.${pc.user}.name;
        group = config.users.users.${pc.user}.group;
        path = "/home/${pc.user}/.ssh/github";
        mode = "0600";
      };
      "github/github.pub" = {
        owner = config.users.users.${pc.user}.name;
        group = config.users.users.${pc.user}.group;
        path = "/home/${pc.user}/.ssh/github.pub";
        mode = "0644";
      };
    };
  };
}
