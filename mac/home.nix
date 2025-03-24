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

    nil
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/ghostty/bloom.glsl".source = ../configs/ghostty/bloom.glsl;
    ".config/ghostty/config".source = ../configs/ghostty/mac/config;
    ".config/ghostty/themes/Custom".source = ../configs/ghostty/mac/theme;
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
      keybindings = [
        {
            key = "ctrl+shift+p";
            command = "workbench.action.showCommands";
        }
        {
            key = "shift+cmd+p";
            command = "-workbench.action.showCommands";
        }
        {
            key = "ctrl+p";
            command = "workbench.action.quickOpen";
        }
        {
            key = "cmd+p";
            command = "-workbench.action.quickOpen";
        }
        {
            key = "ctrl+f";
            command = "actions.find";
            when = "editorFocus || editorIsOpen";
        }
        {
            key = "cmd+f";
            command = "-actions.find";
            when = "editorFocus || editorIsOpen";
        }
        {
            key = "ctrl+h";
            command = "editor.action.startFindReplaceAction";
            when = "editorFocus || editorIsOpen";
        }
        {
            key = "alt+cmd+f";
            command = "-editor.action.startFindReplaceAction";
            when = "editorFocus || editorIsOpen";
        }
        {
            key = "ctrl+a";
            command = "editor.action.selectAll";
        }
        {
            key = "cmd+a";
            command = "-editor.action.selectAll";
        }
        {
            key = "ctrl+c";
            command = "editor.action.clipboardCopyAction";
        }
        {
            key = "cmd+c";
            command = "-editor.action.clipboardCopyAction";
        }
        {
            key = "ctrl+x";
            command = "editor.action.clipboardCutAction";
        }
        {
            key = "cmd+x";
            command = "-editor.action.clipboardCutAction";
        }
        {
            key = "ctrl+.";
            command = "editor.action.quickFix";
            when = "editorHasCodeActionsProvider && textInputFocus && !editorReadonly";
        }
        {
            key = "cmd+.";
            command = "-editor.action.quickFix";
            when = "editorHasCodeActionsProvider && textInputFocus && !editorReadonly";
        }
        {
            key = "ctrl+=";
            command = "workbench.action.zoomIn";
        }
        {
            key = "cmd+=";
            command = "-workbench.action.zoomIn";
        }
        {
            key = "ctrl+-";
            command = "workbench.action.zoomOut";
        }
        {
            key = "cmd+-";
            command = "-workbench.action.zoomOut";
        }
        {
            key = "ctrl+w";
            command = "-workbench.action.switchWindow";
        }
        {
            key = "ctrl+j";
            command = "workbench.action.togglePanel";
        }
        {
            key = "cmd+j";
            command = "-workbench.action.togglePanel";
        }
        {
            key = "ctrl+w";
            command = "workbench.action.closeActiveEditor";
        }
        {
            key = "cmd+w";
            command = "-workbench.action.closeActiveEditor";
        }
        {
            key = "ctrl+k ctrl+c";
            command = "editor.action.addCommentLine";
            when = "editorTextFocus && !editorReadonly";
        }
        {
            key = "cmd+k cmd+c";
            command = "-editor.action.addCommentLine";
            when = "editorTextFocus && !editorReadonly";
        }
        {
            key = "ctrl+k ctrl+u";
            command = "editor.action.removeCommentLine";
            when = "editorTextFocus && !editorReadonly";
        }
        {
            key = "cmd+k cmd+u";
            command = "-editor.action.removeCommentLine";
            when = "editorTextFocus && !editorReadonly";
        }
        {
            key = "ctrl+,";
            command = "workbench.action.openSettings";
        }
        {
            key = "cmd+,";
            command = "-workbench.action.openSettings";
        }
        {
            key = "ctrl+s";
            command = "workbench.action.files.save";
        }
        {
            key = "cmd+s";
            command = "-workbench.action.files.save";
        }
        {
            key = "ctrl+v";
            command = "editor.action.clipboardPasteAction";
        }
        {
            key = "cmd+v";
            command = "-editor.action.clipboardPasteAction";
        }
        {
            key = "ctrl+z";
            command = "undo";
        }
        {
            key = "cmd+z";
            command = "-undo";
        }
      ];
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
