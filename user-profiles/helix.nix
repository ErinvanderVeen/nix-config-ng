{ pkgs, ... }: {
  home.packages = with pkgs; [
    # clipboard
    wl-clipboard
    xclip

    # Language servers
    ## Nix
    nil
    zk

    ## Rust
    cargo
    rustc
    rust-analyzer
    rustfmt
  ];
  home.sessionVariables = {
    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
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
        zk = {
          command = "${pkgs.zk}/bin/zk";
          args = [ "lsp" ];
        };
        gpt = {
          command = "${pkgs.unstable.helix-gpt}/bin/helix-gpt";
          args = [ "--handler" "copilot" ];
        };
      };
      language = [
        {
          name = "rust";
          language-servers = [ "rust-analyzer" "gpt" ];
        }
        {
          name = "nix";
          auto-format = true;
          formatter = {
            command = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt";
          };
        }
        {
          name = "markdown";
          roots = [ ".zk" ];
          language-servers = [ "zk" ];
        }
      ];
    };
  };
}
