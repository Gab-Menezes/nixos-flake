{
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
}