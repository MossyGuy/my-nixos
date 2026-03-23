{ self, inputs, ...}: {
  flake.nixosConfigurations.dellXPS = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.dellXPS-config
    ];
  };
}

