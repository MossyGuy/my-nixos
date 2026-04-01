{ self, inputs, ... }: {
  flake.nixosModules.user-anon = { config, pkgs, ... }: {
      users.users.anon = {
        isNormalUser = true;
        description = "Anonymous";
        extraGroups = [
          "wheel"
          "networkmanager"
        ];
      };

      home-manager.users.anon = {
        imports = [
          inputs.zen-browser.homeModules.beta
          inputs.niri.homeModules.niri
          inputs.stylix.homeModules.stylix
        ];

        stylix = {
          enable = true;
          base16Scheme = {
            base00 = "0f0f0f";  # bg
            base05 = "f4dec0";  # fg
    
            base01 = "1e1f1e";  # gray1
            base02 = "272a28";  # gray2
            base03 = "6c756f";  # gray5 (for comments)
            base04 = "888e7b";  # gray6
            base06 = "b6b69a";  # gray8
            base07 = "e3d6c9";  # gray10
    
            base08 = "f16e65";  # red
            base09 = "ef934d";  # orange
            base0A = "efbf71";  # yellow
            base0B = "7ec97e";  # green
            base0C = "7ec9a3";  # cyan
            base0D = "71b4d6";  # blue
            base0E = "e28dcb";  # magenta
            base0F = "ef968f";  # lred (using as base0F)
          };
        };
          
        home.packages = with pkgs; [
          librewolf
          alacritty
          kitty
          fastfetch
          inputs.hytale-launcher.packages.${pkgs.system}.default
        ];

        programs.kitty.enable = true;

        programs.niri = {
          enable = true;
          package = pkgs.niri;
        };

        programs.zen-browser.enable = true;

        programs.helix = {
          enable = true;
          defaultEditor = true;

          settings = {
            #theme = "mytheme";
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
            "ui.background" = { };
            "ui.selection" = {
              bg = "#2b3028";
            };
            "ui.selection.primary" = {
              bg = "#2b3028";
            };
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
