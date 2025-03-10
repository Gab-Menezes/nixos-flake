{
  "$mod" = "SUPER";
  "$terminal" = "ghostty";
  "$menu" = "rofi -show drun";
  "$window" = "rofi -show window";
  "$browser" = "brave";
  "$file_manager" = "$terminal -e yazi";

  general = {
      gaps_in = 5;
      gaps_out = "5,10,10,10";

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

      sensitivity = -0.7;
  };

  cursor = {
    default_monitor = "DP-5";
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
    "$mod, Q, exec, $window"
    "$mod, E, exec, $file_manager"

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
}