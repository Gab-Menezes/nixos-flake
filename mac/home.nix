{ config, pkgs, inputs, pc, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home.username = pc.user;
  home.homeDirectory = "/Users/${pc.user}";
  home.shell.enableZshIntegration = true;
  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    wget
    age
    sops
    cacert

    jq
    bottom
    btop
    ripgrep
    vim
    unzip

    discord
    spotify

    nil
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/ghostty/bloom.glsl".source = ../configs/ghostty/bloom.glsl;
  };

  home.sessionVariables = {
    EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    history = {
      append = true;
      extended = true;
      ignoreDups = true;
      share = true;
      save = 30000;
      size = 30000;
    };
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
    };
    #shellAliases = {
    #  ls = "eza";
    #  ll = "eza -alBhog";
    #  grep = "rg";
    #  h = "history";
    #  find = "fd";
    #  cdsw = "cd ~/dev/nixos-flake";
    #  csw = "code ~/dev/nixos-flake";
    #  sw = "sudo nixos-rebuild switch --flake ~/dev/nixos-flake#nixos";
    #  bw = "sudo nixos-rebuild boot --flake ~/dev/nixos-flake#nixos";
    #  rcargo = "nix run nixpkgs#cargo -- ";
    #  preperf = "echo 65536 | sudo tee /proc/sys/kernel/perf_event_max_sample_rate && echo -1 | sudo tee /proc/sys/kernel/perf_event_paranoid && echo 0 | sudo tee /proc/sys/kernel/kptr_restrict";
    #};
    initExtra = import ../configs/zshrc.nix;
  };

  #programs.vscode = {
  #  enable = true;
  #  extensions = with pkgs.vscode-extensions; [
  #    vscode-icons-team.vscode-icons
  #    usernamehw.errorlens
  #    vadimcn.vscode-lldb
  #    fill-labs.dependi
  #    mkhl.direnv
  #    tamasfe.even-better-toml
  #    mhutchie.git-graph
  #    oderwat.indent-rainbow
  #    jnoortheen.nix-ide
  #    rust-lang.rust-analyzer
  #    gruntfuggly.todo-tree
  #    zhuangtongfa.material-theme
  #    # github.copilot
  #  ];
  #  userSettings = {
  #    "workbench.colorTheme" = "One Dark Pro Darker";
  #    "workbench.iconTheme" = "vscode-icons";
  #    "files.autoSave" = "afterDelay";
  #
  #    "rust-analyzer.inlayHints.parameterHints.enable" = false;
  #    "rust-analyzer.inlayHints.chainingHints.enable" = false;
  #    "rust-analyzer.inlayHints.typeHints.enable" = false;
  #    "rust-analyzer.debug.engine" = "vadimcn.vscode-lldb";
  #
  #    "git.confirmSync" = false;
  #    "nix.enableLanguageServer" = true;
  #    "window.zoomLevel" = 2;
  #  };
  #  # package = pkgs.vscode-fhs;
  #  # mutableExtensionsDir = true;
  #};
  programs.git = {
    enable = true;
    userEmail = "gaha204@hotmail.com";
    userName = "Gabriel";
  };
  programs.fastfetch = {
    enable = true;
    settings = import ../configs/fastfetch.nix;
  };
  programs.htop = {
    enable = true;
    settings = import ../configs/htop.nix;
  };
  programs.eza = {
    enable = true;
    git = true;
  };
  programs.fd = {
    enable = true;
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.nix-index = {
    enable = true;
  };
  # programs.chromium = {
  #   enable = true;
  #   package = pkgs.brave;
  #   extensions = [
  #     { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
  #     { id = "nngceckbapebfimnlniiiahkandclblb"; } # bitwarden
  #     { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # dark reader
  #     { id = "ponfpcnoihfmfllpaingbgckeeldkhle"; } # enhance for youtube
  #     { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # sponsorblock
  #   ];
  # };
  programs.ghostty = {
    enable = true;
    settings = import ../configs/ghostty/ghostty.nix;
    themes = import ../configs/ghostty/themes.nix;
  };
  # programs.keychain = {
  #   enable = true;
  #   keys = [
  #     "github"
  #   ];
  # };
  programs.yazi = {
    enable = true;
  };

  nix.registry.self.flake = inputs.self;
}
