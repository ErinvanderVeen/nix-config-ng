{ pkgs, config, ... }:
{
  programs.niri = {
    settings = {
      screenshot-path = "${./wallpaper.png}";

      input = {
        keyboard = {
          xkb = {
            layout = "us ";
            variant = "altgr-intl";
            options = "caps:escape";
          };
        };
      };

      outputs = {
        "DP-2" = {
          scale = 2.0;
        };
        "eDP-1" = {
          scale = 2.0;
        };
      };

      spawn-at-startup = [
        { command = [ "${pkgs.swaynotificationcenter}/bin/swaync" ]; }
        { command = [ "${pkgs.waybar}/bin/waybar" ]; }
      ];

      binds = {
        # Navigation
        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;

        "Mod+H".action.focus-column-left = [ ];
        "Mod+J".action.focus-window-or-workspace-down = [ ];
        "Mod+K".action.focus-window-or-workspace-up = [ ];
        "Mod+L".action.focus-column-right = [ ];

        "Mod+Ctrl+H".action.move-column-to-monitor-left = [ ];
        "Mod+Ctrl+J".action.move-column-to-monitor-down = [ ];
        "Mod+Ctrl+K".action.move-column-to-monitor-up = [ ];
        "Mod+Ctrl+L".action.move-column-to-monitor-right = [ ];

        "Mod+Shift+H".action.move-column-left = [ ];
        "Mod+Shift+J".action.move-column-to-workspace-down = [ ];
        "Mod+Shift+K".action.move-column-to-workspace-up = [ ];
        "Mod+Shift+L".action.move-column-right = [ ];

        "Alt+Shift+H".action.consume-or-expel-window-left = [ ];
        "Alt+Shift+J".action.move-window-down-or-to-workspace-down = [ ];
        "Alt+Shift+K".action.move-window-up-or-to-workspace-up = [ ];
        "Alt+Shift+L".action.consume-or-expel-window-right = [ ];

        # Niri actions
        "Mod+Equal".action.set-column-width = "+10%";
        "Mod+Minus".action.set-column-width = "-10%";
        "Mod+Shift+E".action.quit = [ ];
        "Mod+Shift+Q".action.close-window = [ ];
        "Mod+F".action.maximize-column = [ ];

        "Print".action.screenshot = [ ];
        "Ctrl+Print".action.screenshot-screen = [ ];
        "Alt+Print".action.screenshot-window = [ ];

        # Spawns
        ## Keyboard functionality
        "XF86AudioRaiseVolume".action.spawn = [ "${pkgs.wireplumber}/bin/wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+" ];
        "XF86AudioLowerVolume".action.spawn = [ "${pkgs.wireplumber}/bin/wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-" ];
        "XF86MonBrightnessUp".action.spawn = [ "${pkgs.brightnessctl}/bin/brightnessctl" "-c" "backlight" "set" "10%+" ];
        "XF86MonBrightnessDown".action.spawn = [ "${pkgs.brightnessctl}/bin/brightnessctl" "-c" "backlight" "set" "10%-" ];

        ## Programs
        "Mod+D".action.spawn = "${pkgs.nwg-drawer}/bin/nwg-drawer";
        "Mod+Return".action.spawn = "alacritty";
      };
    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      window.decorations = "none";
    };
  };

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = ./waybar.css;
    settings =
      {
        mainBar = {
          layer = "top";
          position = "top";
          height = 32;
          margin-top = 4;
          margin-left = 4;
          margin-right = 4;

          modules-left = [ "wlr/taskbar" ];
          modules-center = [ "clock" ];
          modules-right = [ "cpu" "memory" "battery" "network" "pulseaudio/slider" "tray" ];

          "wlr/taskbar" = {
            format = "{icon}";
            tooltip-format = "{title} | {app_id}";
            on-click = "activate";
            on-click-middle = "close";
            on-click-right = "fullscreen";
          };
          tray = {
            icon-size = 21;
            spacing = 10;
          };
          clock = {
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            format = "{:%e %B %H:%M}";
          };
          cpu = {
            format = "{usage}% ";
            tooltip = false;
          };
          memory = {
            format = "{}% ";
          };
          temperature = {
            thermal-zone = 2;
            hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
            critical-threshold = 80;
            format-critical = "{temperatureC}°C {icon}";
            format = "{temperatureC}°C {icon}";
            format-icons = [ "" "" "" ];
          };
          backlight = {
            device = "acpi_video1";
            format = "{percent}% {icon}";
            format-icons = [ "" "" "" "" "" "" "" "" "" ];
          };
          battery = {
            states = {
              good = 95;
              warning = 30;
              critical = 15;
            };
            format = "{capacity}% {icon}";
            format-charging = "{capacity}% ";
            format-plugged = "{capacity}% ";
            format-alt = "{time} {icon}";
            format-good = "";
            format-full = "";
            format-icons = [ "" "" "" "" "" ];
          };
          "pulseaudio/slider" = {
            min = 0;
            max = 100;
            orientation = "horizontal";
          };
        };
      };
  };

  home.packages = with pkgs; [
    font-awesome
  ];
}

