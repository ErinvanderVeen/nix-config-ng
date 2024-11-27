{ pkgs, ... }:
{
  home.sessionVariables = {
    EDITOR = "hx";
  };

  programs.helix = {
    enable = true;
    settings = {
      editor = {
        line-number = "relative";
        cursorline = true;
        bufferline = "always";
        color-modes = true;
        cursor-shape = {
          insert = "bar";
        };
        whitespace = {
          render = {
            space = "all";
            tab = "all";
            newline = "none";
          };
        };
        indent-guides = {
          render = true;
        };
        soft-wrap = {
          enable = true;
        };
      };
      keys = {
        normal = {
          "tab" = ":buffer-next";
          "S-tab" = ":buffer-previous";
        };
      };
    };

    # Some language servers and formatters should be available even when not in
    # a devShell. These are added here to Helix's path.
    extraPackages = with pkgs; [
      # clipboard
      wl-clipboard

      # Language servers
      nil # Nix
      nixfmt-rfc-style # Official nix fmt
      marksman # Note taking / markdown / personal wiki
    ];

    languages = {
      language-server = {
        rust-analyzer = {
          config.check.command = "clippy";
        };
        nil = {
          config.nil.formatting.command = [
            "nixfmt"
          ];
        };
      };
      language = [
        {
          name = "nix";
          auto-format = true;
        }
        {
          name = "typst";
          auto-format = true;
          language-servers = [
            "tinymist"
            "harper"
          ];
        }
        {
          name = "markdown";
          language-servers = [
            "marksman"
            "harper"
          ];
        }
      ];
    };
  };
}
