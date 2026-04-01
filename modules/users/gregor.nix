{ self, inputs, ... }: {
  flake.nixosModules.user-gregor = { config, pkgs, ... }: {
    users.users.gregor = {
      isNormalUser = true;
      description = "Gregor Pogačnik";
      extraGroups = [ "wheel" "networkmanager" ];
    };

    home-manager.users.gregor = {
      home.packages = with pkgs; [
        git
      ];    
      programs.helix.enable = true;
    };
  };
}
