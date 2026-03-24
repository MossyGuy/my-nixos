{ self, inputs, ... }: {
  flake.nixosModules.user-anon = { config, pkgs, ... }: {
    users.users.anon = {
      isNormalUser = true;
      description = "Anonymous";
      extraGroups = [ "wheel" "networkmanager" ];
    };

    home-manager.users.anon = {
      home.packages = with pkgs; [
        fastfetch
      ];    
      programs.helix = {
        enable = true;
        defaultEditor = true;
        
        settings = {
          theme = "mytheme";
          editor = {
            mouse = true;
            line-number = "relative";
            cursor-shape = {
              normal = "block";
              insert = "bar";
              select = "block";
            };
            auto-save = {
              after-delay.timeout = 0;
            };
          };
        };

        themes.mytheme = {
          inherits = "github_dark_tritanopia";
          "ui.background" = {};
          "ui.selection" = { bg = "#2b3028"; };
          "ui.selection.primary" = { bg = "#2b3028"; };
        };
        extraPackages = with pkgs; [
          gopls
          delve
          rust-analyzer
          jdt-language-server
          omnisharp-roslyn
          netcoredbg
          nil
          nixd
          ruff
          pyright
        ];
      };
    };
  };
}
