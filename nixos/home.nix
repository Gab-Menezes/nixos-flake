{ config, pkgs, inputs, ... }:

{
  nixpkgs.overlays = [inputs.fenix.overlays.default];
  nixpkgs.config.allowUnfree = true;

  dconf.settings = {
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
      num-workspaces = 1;
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
    };
    "org/gnome/shell/keybindings" = {
      show-screenshot-ui = [
        "<Shift><Super>s"
      ];
    };
    "org/gnome/mutter" = {
      edge-tiling = true;
    };
    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "default";
      speed = -0.80;
    };

    "org/gnome/desktop/session" = {
      idle-delay = 0;
      # idle-delay = "uint32 0";
    };
    "org/gnome/settings-daemon/plugins/color" = {
      night-light-schedule-automatic = false;
    };
    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
    };
  };

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "gabriel";
  home.homeDirectory = "/home/gabriel";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    wget
    keychain
    age
    sops

    jq
    lf
    bottom
    ripgrep
    bat
    vim
    file
    patchelf
    lm_sensors
    pkgs.linuxPackages_latest.perf
    ida-free
    ghidra
    lsp-plugins

    discord
    spotify
    bitwarden-desktop
    rustdesk

    nil
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    ".config/easyeffects/input/pro-x.json".source = ../configs/pro-x.json;


    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "vim";
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/gabriel/etc/profile.d/hm-session-vars.sh
  #

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;
    historyControl = [ "ignoredups" "erasedups" ];
    shellAliases = {
      ls = "eza";
      ll = "eza -alBhog";
      grep = "rg";
      h = "history";
      find = "fd";
      cdsw = "cd ~/dev/nixos-flake";
      csw = "code ~/dev/nixos-flake";
      sw = "sudo nixos-rebuild switch --flake ~/dev/nixos-flake#nixos";
      rcargo = "nix run nixpkgs#cargo -- ";
      preperf = "echo 65536 | sudo tee /proc/sys/kernel/perf_event_max_sample_rate && echo -1 | sudo tee /proc/sys/kernel/perf_event_paranoid && echo 0 | sudo tee /proc/sys/kernel/kptr_restrict";
    };
    #bashrcExtra = import ./configs/bashrc.nix;
  };

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
      ls = "eza";
      ll = "eza -alBhog";
      grep = "rg";
      h = "history";
      find = "fd";
      cdsw = "cd ~/dev/nixos-flake";
      csw = "code ~/dev/nixos-flake";
      sw = "sudo nixos-rebuild switch --flake ~/dev/nixos-flake#nixos";
      rcargo = "nix run nixpkgs#cargo -- ";
      preperf = "echo 65536 | sudo tee /proc/sys/kernel/perf_event_max_sample_rate && echo -1 | sudo tee /proc/sys/kernel/perf_event_paranoid && echo 0 | sudo tee /proc/sys/kernel/kptr_restrict";
    };
    initExtra = import ../configs/zshrc.nix;
  };

  programs.vscode = {
    enable = true;
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
      rust-lang.rust-analyzer-nightly
      gruntfuggly.todo-tree
      zhuangtongfa.material-theme
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
  programs.alacritty = {
    enable = true;
  };

  services.easyeffects = {
    enable = true;
  };

  nix.registry.self.flake = inputs.self;
}
