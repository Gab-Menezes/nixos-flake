{
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

  # Fix home manager apps not showing in spotlight (https://github.com/LnL7/nix-darwin/issues/214)
  # activationScripts.postUserActivation.text = ''
  #     apps_source="$HOME/Applications/Home Manager Apps"
  #     moniker="Nix Trampolines"
  #     app_target_base="$HOME/Applications"
  #     app_target="$app_target_base/$moniker"
  #     mkdir -p "$app_target"
  #     ${pkgs.rsync}/bin/rsync --archive --checksum --chmod=-w --copy-unsafe-links --delete "$apps_source/" "$app_target"
  # '';

  stateVersion = 6;
}