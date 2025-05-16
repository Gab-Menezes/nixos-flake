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
    rsync
    jetbrains.datagrip
    s5cmd
    flyctl
    awscli2
    yq
    infisical

    fluxcd
    kubectl
    kubelogin-oidc
    kubectl-tree
    kubectl-neat
    kubectl-ktop
    kubectl-view-secret
    kubectl-view-allocations
    kubectl-evict-pod
    kubecolor
    kubernetes-helm

    # python314

    nil
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/ghostty/config".source = ../configs/mac/ghostty/config;
    ".config/ghostty/themes/Custom".source = ../configs/mac/ghostty/theme;
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
    shellAliases = {
      k = "kubecolor";
      kn = "k neat get --";
      ls = "eza";
      ll = "eza -alBhog";
      grep = "rg";
      h = "history";
      find = "fd";
      cdsw = "cd ~/dev/nixos-flake";
      csw = "code ~/dev/nixos-flake";
      sw = "darwin-rebuild switch --flake ~/dev/nixos-flake && skhd -r && sudo yabai --load-sa";
      rcargo = "nix run nixpkgs#cargo --";
    };
    sessionVariables = {
      MY_TAILSCALE_HOST="gabriel-macbook-pro";
    };
    initExtra = import ../configs/zshrc.nix;
  };

  programs.vscode = {
    enable = true;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        vscode-icons-team.vscode-icons
        usernamehw.errorlens
        vadimcn.vscode-lldb
        fill-labs.dependi
        mkhl.direnv
        tamasfe.even-better-toml
        mhutchie.git-graph
        oderwat.indent-rainbow
        jnoortheen.nix-ide
        rust-lang.rust-analyzer
        gruntfuggly.todo-tree
        zhuangtongfa.material-theme
        eamodio.gitlens
        #ms-python.python
        #ms-python.debugpy
        # github.copilot
        # dbaeumer.vscode-eslint

        ms-vscode-remote.remote-ssh
        ms-vscode-remote.remote-ssh-edit
        golang.go
        #ms-vscode.remote-explorer
      ];
      userSettings = {
        "workbench.colorTheme" = "One Dark Pro Darker";
        "workbench.iconTheme" = "vscode-icons";
        "files.autoSave" = "afterDelay";
    
        "rust-analyzer.inlayHints.parameterHints.enable" = false;
        "rust-analyzer.inlayHints.chainingHints.enable" = false;
        "rust-analyzer.inlayHints.typeHints.enable" = false;
        "rust-analyzer.debug.engine" = "vadimcn.vscode-lldb";
    
        "git.confirmSync" = false;
        "nix.enableLanguageServer" = true;
        "window.zoomLevel" = 2;
      };
      keybindings = import ../configs/mac/vscode-keybindings.nix;
    };
  };
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
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # bitwarden
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # dark reader
      { id = "ponfpcnoihfmfllpaingbgckeeldkhle"; } # enhance for youtube
      { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # sponsorblock
    ];
  };

  # programs.ghostty = {
  #   enable = true;
  #   settings = import ../configs/ghostty/ghostty.nix;
  #   themes = import ../configs/ghostty/themes.nix;
  # };
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
