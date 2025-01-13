{ pkgs, ... }:
{
  home.sessionVariables = {
    EDITOR = "hx";
  };

  programs.helix = {
    enable = true;
    settings = {
      theme = "base16_terminal";
      editor = {
        end-of-line-diagnostics = "hint";
        inline-diagnostics = {
          cursor-line = "hint";
        };
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
          tab = ":buffer-next";
          S-tab = ":buffer-previous";
          space = {
            g = [
              ":new"
              ":insert-output lazygit"
              ":buffer-close!"
              ":redraw"
            ];
          };
        };
      };
    };

    # Some language servers and formatters should be available even when not in
    # a devShell. These are added here to Helix's path.
    extraPackages = with pkgs; [
      # clipboard
      wl-clipboard

      # Language servers
      harper # Spell checking
      markdown-oxide # Note taking / markdown / personal wiki
      nil # Nix
      nixfmt-rfc-style # Official nix fmt
      helix-gpt
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
        harper = {
          command = "harper-ls";
        };
        gpt = {
          command = "helix-gpt";
          args = [
            "--handler"
            "ollama"
            "--ollamaModel"
            "codellama"
            "--fetchTimeout"
            "300000"
            "--actionTimeout"
            "300000"
            "--completionTimeout"
            "300000"
            "--ollamaTimeout"
            "300000"
            "--triggerCharacters"
            ""
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
          name = "go";
          language-servers = [
            # "gpt"
            "gopls"
            "golangci-lint-lsp"
          ];
        }
        {
          name = "markdown";
          language-servers = [
            "markdown-oxide"
            "harper"
          ];
        }
      ];
    };
  };
}
