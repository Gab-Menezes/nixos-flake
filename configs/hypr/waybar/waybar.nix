############################################################################################################
##   ______  __      __  _______   ________  _______    ______   __    __   ______   __    __  ________   ##
##  /      \|  \    /  \|       \ |        \|       \  /      \ |  \  |  \ /      \ |  \  /  \|        \  ##
## |  $$$$$$\\$$\  /  $$| $$$$$$$\| $$$$$$$$| $$$$$$$\|  $$$$$$\| $$\ | $$|  $$$$$$\| $$ /  $$| $$$$$$$$  ##
## | $$   \$$ \$$\/  $$ | $$__/ $$| $$__    | $$__| $$| $$___\$$| $$$\| $$| $$__| $$| $$/  $$ | $$__      ##
## | $$        \$$  $$  | $$    $$| $$  \   | $$    $$ \$$    \ | $$$$\ $$| $$    $$| $$  $$  | $$  \     ##
## | $$   __    \$$$$   | $$$$$$$\| $$$$$   | $$$$$$$\ _\$$$$$$\| $$\$$ $$| $$$$$$$$| $$$$$\  | $$$$$     ##
## | $$__/  \   | $$    | $$__/ $$| $$_____ | $$  | $$|  \__| $$| $$ \$$$$| $$  | $$| $$ \$$\ | $$_____   ##
##  \$$    $$   | $$    | $$    $$| $$     \| $$  | $$ \$$    $$| $$  \$$$| $$  | $$| $$  \$$\| $$     \  ##
##   \$$$$$$     \$$     \$$$$$$$  \$$$$$$$$ \$$   \$$  \$$$$$$  \$$   \$$ \$$   \$$ \$$   \$$ \$$$$$$$$  ##
##                                                                                                        ##
## Waybar Config                                                                                          ##
## Created by Cybersnake                                                                                  ##
############################################################################################################

{
  "layer" = "top";
  "position" = "top";
  "mode" = "dock";
  "exclusive" = true;
  "passthrough" = false;
  "gtk-layer-shell" = true;
  "height" = 0;
  "modules-left" = [
    "hyprland/workspaces"
    "backlight"
    "bluetooth"
    "network"
  ];
  "fixed-center" = true;
  "modules-center" = [
    "memory"
    # "custom/updates"
    "clock"
    # "custom/notifications"
    "disk"
  ];
  "modules-right" = [
    "tray"
    "custom/player"
    "pulseaudio"
    "pulseaudio#microphone"
    "battery"
    "custom/reboot"
    "custom/shutdown"
  ];
  "hyprland/window" = {
    "format" = "{}";
  };
  "hyprland/workspaces" = {
    "sort-by-name" = true;
    "format" = "{id}";
    "show-special" = true;
    "persistent-workspaces" = {
      "*" = 0;
    };
  };
  "tray" = {
    "icon-size" = 12;
    "spacing" = 2;
  };
  "clock" = {
    "interval" = 60;
    # "format" = " { =%A; %B %d [%H =%M]}";
    "format" = " {:%A; %B %d [%H:%M]}";
    "tooltip-format" = "<tt><small>{calendar}</small></tt>";
    "calendar" = {
      "mode" = "year";
      "mode-mon-col" = 3;
      "format" = {
        "months" = "<span color='#e6e1cf'><b>{}</b></span>";
        "days" = "<span color='#cad3f5'><b>{}</b></span>";
        "weekdays" = "<span color='#ff3333'><b>{}</b></span>";
        "today" = "<span color='#f5a97f'><b><u>{}</u></b></span>";
      };
    };
  };
  "backlight" = {
    "device" = "intel_backlight";
    "format" = "{icon} {percent}%";
    "format-icons" = [
      ""
      ""
      ""
    ];
  };
  "battery" = {
    "interval" = 1;
    "states" = {
      "good" = 100;
      "warning" = 30;
      "critical" = 20;
    };
    "format" = "{icon} {capacity}%";
    "format-charging" = " {capacity}%";
    "format-plugged" = " {capacity}%";
    "format-icons" = [
      ""
      ""
      ""
      ""
      ""
      ""
      ""
      ""
      ""
      ""
      ""
    ];
  };
  "pulseaudio" = {
    "format" = "{icon} {volume}%";
    "tooltip" = false;
    "format-muted" = " Muted";
    "on-click" = "wpctl set-mute @DEFAULT_SINK@ toggle";
    "on-scroll-up" = "wpctl set-volume @DEFAULT_SINK@ 10%+";
    "on-scroll-down" = "wpctl set-volume @DEFAULT_SINK@ 10%-";
    "format-icons" = {
      "headphone" = "";
      "hands-free" = "";
      "headset" = "";
      "phone" = "";
      "portable" = "";
      "car" = "";
      "default" = [
        ""
        ""
        ""
      ];
    };
  };
  "pulseaudio#microphone" = {
    "format" = "{format_source}";
    "format-source" = " {volume}%";
    "format-source-muted" = " Muted";
    "on-click" = "wpctl set-mute @DEFAULT_SOURCE@ toggle";
    "on-scroll-up" = "wpctl set-volume @DEFAULT_SOURCE@ 5%+ --limit 1.15";
    "on-scroll-down" = "wpctl set-volume @DEFAULT_SOURCE@ 5%-";
  };
  "network" = {
    "format-disconnected" = "Disconnected";
    "format-wifi" = " {essid}";
    "format-ethernet" = " {ipaddr}/{cidr}";
    "tooltip-format" = " {signalStrength}";
    "on-click" = "wifimenu";
  };
  "bluetooth" = {
    "format" = " {status}";
    "format-disabled" = " {status}";
    "format-connected" = " {num_connections}";
    "tooltip-format" = "{device_alias}";
    "format-connected-battery" = " {device_alias} {device_battery_percentage}%";
    "tooltip-format-enumerate-connected" = "{device_alias}";
    "on-click" = "btblock";
  };
  "memory" = {
    "interval" = 60;
    "format" = " {used}G";
    "tooltip-format" = "{used} / {total} G";
  };
  "disk" = {
    "interval" = 6000;
    "format" = " {percentage_used}%";
    "tooltip-format" = "{used} used out of {total} on {path} ";
  };
  # "custom/updates" = {
  #   "format" = "{}";
  #   "tooltip" = false;
  #   "interval" = 1200;
  #   "exec" = "$HOME/.config/waybar/bin/updatecheck";
  #   "return-type" = "json";
  #   "exec-if" = "exit 0";
  #   "signal" = 8;
  # };
  # "custom/notifications" = {
  #   "format" = "{}";
  #   "exec" = "$HOME/.config/waybar/bin/not-dnd -j";
  #   "on-click" = "$HOME/.config/waybar/bin/not-dnd";
  #   "return-type" = "json";
  #   "interval" = "once";
  #   "signal" = 2;
  # };
  "custom/player" = {
    "format" = "󰎆 {}";
    "interval" = 5;
    "exec" = "$HOME/.config/waybar/bin/playerinfo";
    "max-length" = 40;
    "tooltip" = true;
  };

  "custom/shutdown" = {
      "format" = "";
      "tooltip" = false;
      "on-click" = "shutdown now";
  };
  "custom/reboot" = {
      "format" = "󰜉";
      "tooltip" = false;
      "on-click" = "reboot";
  };
}