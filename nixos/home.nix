{ config, pkgs, inputs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.cudaSupport = true;

  # dconf.settings = {
  #   "org/gnome/desktop/wm/preferences" = {
  #     button-layout = "appmenu:minimize,maximize,close";
  #     num-workspaces = 2;
  #   };
  #   "org/gnome/desktop/interface" = {
  #     color-scheme = "prefer-dark";
  #     enable-hot-corners = false;
  #   };
  #   "org/gnome/shell/keybindings" = {
  #     show-screenshot-ui = [
  #       "<Shift><Super>s"
  #     ];
  #   };
  #   "org/gnome/mutter" = {
  #     edge-tiling = true;
  #   };
  #   "org/gnome/desktop/peripherals/mouse" = {
  #     accel-profile = "default";
  #     speed = -0.80;
  #   };

  #   "org/gnome/desktop/session" = {
  #     idle-delay = 0;
  #     # idle-delay = "uint32 0";
  #   };
  #   "org/gnome/settings-daemon/plugins/color" = {
  #     night-light-schedule-automatic = false;
  #   };
  #   "org/gnome/settings-daemon/plugins/power" = {
  #     sleep-inactive-ac-type = "nothing";
  #   };
  # };

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "gabriel";
  home.homeDirectory = "/home/gabriel";
  home.shell.enableZshIntegration = true;

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
    age
    sops
    cacert

    jq
    bottom
    ripgrep
    vim
    file
    patchelf
    lm_sensors
    pkgs.linuxPackages_latest.perf
    ida-free
    lsp-plugins
    unzip

    discord
    spotify
    rustdesk

    nil

    font-awesome
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    ".config/easyeffects/input/pro-x.json".source = ../configs/pro-x.json;
    ".config/ghostty/bloom.glsl".source = ../configs/ghostty/bloom.glsl;


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
      bw = "sudo nixos-rebuild boot --flake ~/dev/nixos-flake#nixos";
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
      bw = "sudo nixos-rebuild boot --flake ~/dev/nixos-flake#nixos";
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
      rust-lang.rust-analyzer
      gruntfuggly.todo-tree
      zhuangtongfa.material-theme
      # github.copilot
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
    # package = pkgs.vscode-fhs;
    # mutableExtensionsDir = true;
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
  programs.ghostty = {
    enable = true;
    settings = import ../configs/ghostty/ghostty.nix;
    themes = import ../configs/ghostty/themes.nix;
  };
  programs.keychain = {
    enable = true;
    keys = [
      "github"
    ];
  };
  programs.yazi = {
    enable = true;
  };

  #environment.sessionVariables.NIXOS_OZONE_WL = "1";
  programs.wofi = {
    enable = true;
  };
  programs.waybar = {
    enable = true;
  };
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      "$terminal" = "ghostty";
      "$menu" = "wofi --show drun";
      "$browser" = "brave";
      "$file_manager" = "yazi";

      general = {
          gaps_in = 5;
          gaps_out = 10;

          border_size = 2;

          # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
          "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";

          # Set to true enable resizing windows by clicking and dragging on borders and gaps
          resize_on_border = true;

          # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
          allow_tearing = false;

          layout = "dwindle";
      };

      decoration = {
          rounding = 10;
          rounding_power = 2;

          # Change transparency of focused and unfocused windows
          active_opacity = 1.0;
          inactive_opacity = 1.0;

          shadow = {
              enabled = true;
              range = 8;
              render_power = 2;
              color = "rgba(1a1a1aee)";
          };

          # https://wiki.hyprland.org/Configuring/Variables/#blur
          blur = {
              enabled = true;
              size = 8;
              passes = 1;

              vibrancy = 0.1696;
          };
      };

      animations = {
          enabled = true;

          bezier = [
            "easeOutQuint,0.23,1,0.32,1"
            "easeInOutCubic,0.65,0.05,0.36,1"
            "linear,0,0,1,1"
            "almostLinear,0.5,0.5,0.75,1.0"
            "quick,0.15,0,0.1,1"
          ];

          animation = [
            "global, 0"

            "border, 1, 4, easeOutQuint"

            # "global, 1, 10, default"
            # "border, 1, 5.39, easeOutQuint"
            # "windows, 1, 4.79, easeOutQuint"
            # "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
            # "windowsOut, 1, 1.49, linear, popin 87%"
            # "fadeIn, 1, 1.73, almostLinear"
            # "fadeOut, 1, 1.46, almostLinear"
            # "fade, 1, 3.03, quick"
            # "layers, 1, 3.81, easeOutQuint"
            # "layersIn, 1, 4, easeOutQuint, fade"
            # "layersOut, 1, 1.5, linear, fade"
            # "fadeLayersIn, 1, 1.79, almostLinear"
            # "fadeLayersOut, 1, 1.39, almostLinear"
            # "workspaces, 1, 1.94, almostLinear, fade"
            # "workspacesIn, 1, 1.21, almostLinear, fade"
            # "workspacesOut, 1, 1.94, almostLinear, fade"
          ];
      };

      dwindle = {
          pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = true; # You probably want this
      };
      master = {
        new_status = "master";
      };

      input = {
          kb_layout = "us";
          # kb_variant =
          # kb_model =
          # kb_options =
          # kb_rules =

          follow_mouse = 2;

          sensitivity = -0.5;
      };

      exec-once = [
        "[workspace 2 silent] $terminal"
        "[workspace 2 silent] $browser"
        "waybar"
      ];

      monitor = [
        "HDMI-A-2, preferred, 0x0, 1, transform, 1"
        "DP-5, 2560x1440@144, 1080x540, 1"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bind = [
        "$mod, RETURN, exec, $terminal"
        "$mod, B, exec, $browser"
        "$mod, SPACE, exec, $menu"
        "$mod, E, exec, $terminal -e $file_manager"

        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, right, movewindow, r"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
        
        "$mod, W, killactive"
        "$mod, V, togglefloating"
        "$mod, S, togglespecialworkspace"
        "$mod, F, fullscreen"

        "$mod, Tab, cyclenext,"
      ] ++ (
          builtins.concatLists (builtins.genList (i:
              let ws = i + 1;
              in [
                "$mod, code:1${toString i}, workspace, ${toString ws}"
                "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            )
            9)
        );

      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];
    };
  };

  services.easyeffects = {
    enable = true;
  };

  nix.registry.self.flake = inputs.self;
}
