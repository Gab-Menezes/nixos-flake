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

  # Fix home manager apps not showing in spotlight (https://github.com/LnL7/nix-darwin/issues/214)
  system.activationScripts.postUserActivation.text = ''
    apps_source="$HOME/Applications/Home Manager Apps"
    moniker="Nix Trampolines"
    app_target_base="$HOME/Applications"
    app_target="$app_target_base/$moniker"
    mkdir -p "$app_target"
    ${pkgs.rsync}/bin/rsync --archive --checksum --chmod=-w --copy-unsafe-links --delete "$apps_source/" "$app_target"
  '';

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

      # pkgs.ghostty is broken so install it as a cask
      "ghostty"
    ];
  };


  system = {
    defaults = {
      CustomUserPreferences = {
        "com.mitchellh.ghostty" = {
          NSUserKeyEquivalents = {
            Copy = "^$c";
            Paste = "^$v";
          };
        };

        "com.google.Chrome" = {
          NSUserKeyEquivalents = {
            "Close Tab" = "^w";
            "Find..." = "^f";
            "New Incognito Window" = "^$n";
            "New Tab" = "^t";
            "Zoom In" = "^=";
            "Zoom Out" = "^-";
          };
        };

        "com.brave.Browser" = {
          NSUserKeyEquivalents = {
            "Close Tab" = "^w";
            "Find..." = "^f";
            "New Private Window" = "^$n";
            "New Tab" = "^t";
            "Zoom In" = "^=";
            "Zoom Out" = "^-";
            "Reopen Closed Tab" = "^$t";
            "Reload This Page" = "^r";
          };
        };
      };
      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        # ApplePressAndHoldEnabled = false;
        AppleShowAllExtensions = true;
        # KeyRepeat = 2;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        # NSAutomaticSpellingCorrectionEnabled = false;
        NSAutomaticWindowAnimationsEnabled = false;
        NSDocumentSaveNewDocumentsToCloud = false;
        # NSNavPanelExpandedStateForSaveMode = true;
        # PMPrintingExpandedStateForPrint = true;

        # TODO: Find how to create this with nix
        # NSUserKeyEquivalents = {
        #   Copy = "^c";
        #   Cut = "^x";
        #   Paste = "^v";
        #   "Paste and Match Style" = "^$v";
        #   "Select All" = "^a";
        # };
      };
      LaunchServices = {
        LSQuarantine = false;
      };
      trackpad = {
        TrackpadRightClick = true;
        # TrackpadThreeFingerDrag = true;
        # Clicking = true;
      };
      finder = {
        AppleShowAllFiles = true;
        CreateDesktop = false;
        FXDefaultSearchScope = "SCcf";
        FXEnableExtensionChangeWarning = false;
        # FXPreferredViewStyle = "Nlsv";
        QuitMenuItem = true;
        # ShowPathbar = true;
        ShowStatusBar = true;
        _FXShowPosixPathInTitle = true;
        _FXSortFoldersFirst = true;
      };
      dock = {
        autohide = true;
        expose-animation-duration = 0.15;
        show-recents = false;
        showhidden = true;
        mru-spaces = false;
        # persistent-apps = [];
        # tilesize = 30;
        # wvous-bl-corner = 1;
        # wvous-br-corner = 1;
        # wvous-tl-corner = 1;
        # wvous-tr-corner = 1;
      };
      universalaccess.reduceMotion = false;
      spaces.spans-displays = false;
    #   screencapture = {
    #     location = "/Users/${userConfig.name}/Downloads/temp";
    #     type = "png";
    #     disable-shadow = true;
    #   };
    # };
    # keyboard = {
    #   enableKeyMapping = true;
    #   # Remap §± to ~
    #   userKeyMapping = [
    #     {
    #       HIDKeyboardModifierMappingDst = 30064771125;
    #       HIDKeyboardModifierMappingSrc = 30064771172;
    #     }
    #   ];
    # };
    };
  };

  services.yabai = {
    enable = true;
    enableScriptingAddition = true;
    config = {
      layout = "bsp";
      window_placement = "second_child";
      window_gap = 3;

      mouse_follows_focus = "on";
      mouse_modifier = "super";
      mouse_action1 = "move";
      mouse_action2 = "resize";
      mouse_drop_action = "swap";
    };
    extraConfig = ''
      yabai -m rule --add app="^System Settings$" manage=off
    '';
  };
  services.skhd = {
    enable = true;
    skhdConfig = ''
      cmd - return : open -n -a Ghostty
      cmd - b : open -n -a "Brave Browser"
      cmd - e : open -n -a Ghostty --args -e yazi

      cmd + shift - left : yabai -m window --swap west
      cmd + shift - right : yabai -m window --swap east
      cmd + shift - up : yabai -m window --swap north
      cmd + shift - down : yabai -m window --swap south
      cmd - left : yabai -m window --focus west
      cmd - right : yabai -m window --focus east
      cmd - up : yabai -m window --focus north
      cmd - down : yabai -m window --focus south

      cmd + alt - right : yabai -m space --focus next
      cmd + alt - left : yabai -m space --focus prev
      cmd + alt - up : yabai -m space --toggle mission-control
      # cmd + alt - down : yabai -m space --toggle show-desktop

      cmd - f : yabai -m window --toggle zoom-fullscreen
      cmd - w : yabai -m window --close
      cmd - v : yabai -m window --toggle float

      cmd - k : yabai -m space --balance

      cmd - 1 : yabai -m space --focus 1
      cmd - 2 : yabai -m space --focus 2
      cmd - 3 : yabai -m space --focus 3
      cmd - 4 : yabai -m space --focus 4
      cmd - 5 : yabai -m space --focus 5
      cmd - 6 : yabai -m space --focus 6
      cmd - 7 : yabai -m space --focus 7
      cmd - 8 : yabai -m space --focus 8
      cmd - 9 : yabai -m space --focus 9
      shift + cmd - 1 : yabai -m window --space  1; yabai -m space --focus 1
      shift + cmd - 2 : yabai -m window --space  2; yabai -m space --focus 2
      shift + cmd - 3 : yabai -m window --space  3; yabai -m space --focus 3
      shift + cmd - 4 : yabai -m window --space  4; yabai -m space --focus 4
      shift + cmd - 5 : yabai -m window --space  5; yabai -m space --focus 5
      shift + cmd - 6 : yabai -m window --space  6; yabai -m space --focus 6
      shift + cmd - 7 : yabai -m window --space  7; yabai -m space --focus 7
      shift + cmd - 8 : yabai -m window --space  8; yabai -m space --focus 8
      shift + cmd - 9 : yabai -m window --space  9; yabai -m space --focus 9
    '';
  };

  system.stateVersion = 6;
}
