{
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
    yabai -m rule --add app="^Finder$" manage=off
  '';
}