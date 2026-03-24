{ self, inputs, ... }: {
  flake.nixosModules.user-bob = { config, ... }: {
    users.users.bob = {
      isNormalUser = true;
      description = "Bob";
      extraGroups = [ "wheel" "networkmanager" ];
    };

    home-manager.users.bob = {
      programs.helix.enable = true;
    };
  };
}
