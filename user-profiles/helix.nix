{ pkgs, ... }: {
  home.packages = with pkgs; [
    # clipboard
    wl-clipboard
    xclip

    # Language servers
    ## Nix
    nil

    ## Rust
    cargo
    rustc
    rust-analyzer
    rustfmt
  ];
  home.sessionVariables = {
    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
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

    languages = {
      language-server = {
        rust-analyzer = {
          config.check.command = "clippy";
        };
        gopls = {
          command = "${pkgs.gopls}/bin/gopls";
        };
        gpt = {
          command = "${pkgs.helix-gpt}/bin/helix-gpt";
          args = [
            "--handler"
            "ollama"

            "--ollamaModel"
            "codellama"

            "--ollamaEndpoint"
            "http:///Trahearne.local:11434"

            "--triggerCharacters"
            "{"
          ];
        };
        typos = {
          command = "${pkgs.typos-lsp}/bin/typos-lsp";
        };
        harper = {
          command = "${pkgs.harper}/bin/harper-ls";
          args = [ "--stdio" ];
        };
      };
      language = [
        # {
        #   name = "rust";
        #   language-servers = [ "rust-analyzer" "gpt" ];
        # }
        {
          name = "html";
          language-servers = [ "vscode-html-language-server" ];
        }
        {
          name = "nix";
          auto-format = true;
          formatter = {
            command = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt";
          };
          language-servers = [ "nil" ];
        }
        {
          name = "typst";
          auto-format = true;
          formatter = {
            command = "${pkgs.typstfmt}/bin/typstfmt";
            args = [ "--output" "-" ];
          };
          language-servers = [ "typst-lsp" "typos" "harper" ];
        }
        {
          name = "markdown";
          language-servers = [ "harper" ];
        }
      ];
    };
  };
}

