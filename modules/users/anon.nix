{ self, inputs, ... }: {
  flake.nixosModules.user-anon = { config, ... }: {
    users.users.anon = {
      isNormalUser = true;
      description = "Anonymous";
      extraGroups = [ "wheel" "networkmanager" ];
    };

    home-manager.users.anon = {
      home.stateVersion = "25.11";
      programs.helix.enable = true;
    };
  };
}
