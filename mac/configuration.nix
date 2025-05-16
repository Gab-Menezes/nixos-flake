# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, pc, ... }:

{
  nixpkgs.hostPlatform = pc.system;
  nixpkgs.config.allowUnfree = true;
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc = {
    automatic = true;
    # interval = "weekly";
    options = "--delete-older-than 7d";
  };

  imports = [
    inputs.home-manager.darwinModules.default
    #../secrets/sops.nix
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; inherit pc; };
    users = {
      ${pc.user} = import ./home.nix;
    };
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    font-awesome
    icomoon-feather
  ] 
  ++
  builtins.filter 
    lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

  networking.hostName = pc.host;

  users.users.${pc.user} = {
    home = "/Users/${pc.user}";
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
  # programs.ssh.startAgent = true;

  environment.systemPackages = with pkgs; [];

  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
    # onActivation.cleanup = "zap";
  
    # extraConfig = ''
    #   cask_args appdir: "~/Applications"
    # '';
  
    casks = [
      "discord"
      "spotify"
      "bitwarden"
      "telegram"
      "wireshark"

      # pkgs.ghostty is broken so install it as a cask
      "ghostty"
    ];
  };


  system = import ./system.nix;
  services.yabai = import ../configs/mac/yabai.nix;
  services.skhd = import ../configs/mac/skhd.nix;
}
