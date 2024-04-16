{ pkgs, config, inputs, ... }:
let
  asztal-bin = "${inputs.asztal.packages.${pkgs.system}.default}/bin/asztal";
in
{
  imports = [
    # ./ags.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    plugins = with pkgs; [
      hyprscroller
    ];

    settings = {
      "$mod" = "SUPER";

      general = {
        layout = "scroller";
      };

      input = {
        kb_layout = "us";
        kb_variant = "altgr-intl";
        kb_options = "caps:escape";

        touchpad = {
          natural_scroll = true;
        };

      };

      gestures = {
        workspace_swipe = true;
      };

      exec-once = [
        "${asztal-bin} -b hypr"
      ];

      bind =
        let
          ags = "exec, ${asztal-bin} -b hypr";
        in
        [
          # Programs
          "$mod, Return, exec, blackbox"

          ## Keyboard stuff
          ", XF86AudioRaiseVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+"
          ", XF86AudioLowerVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-"
          ", XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl -c backlight set 10%+"
          ", XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl -c backlight set 10%-"

          ## ags
          "$mod, D, ${ags} -t launcher"
          ", XF86PowerOff, ${ags} -t powermenu"
          "$mod, Tab, ${ags} -t overview"
          ", Print, ${ags} -r 'recorder.screenshot()'"

          # Hyprland Navigation
          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
          "$mod, 6, workspace, 6"
          "$mod, 7, workspace, 7"

          # scroller navigation
          "$mod, H, scroller:movefocus, l"
          "$mod, J, scroller:movefocus, u"
          "$mod, K, scroller:movefocus, d"
          "$mod, L, scroller:movefocus, r"

          # Hyprland actions
          "$mod, Q, killactive"
        ];

      animation = [
        "workspaces, 1, 5, default, slidevert"
      ];
    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      window.decorations = "none";
    };
  };

  home.packages = with pkgs; [
    font-awesome
  ];
}

