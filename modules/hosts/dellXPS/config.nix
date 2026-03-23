{ self, inputs, ... }: {
  flake.nixosModules.dellXPS-config = { pkgs, lib, ... }: {
    imports = [
      inputs.home-manager.nixosModules.home-manager
      self.nixosModules.dellXPS-hardware
      self.nixosModules.user-anon
    ];
  
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
      
    boot.loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        fontSize = 32;
        gfxmodeEfi = "1920x1080";
      };
      efi.canTouchEfiVariables = true;      
    };

    boot.kernelPackages = pkgs.linuxPackages_latest;
    networking.hostName = "dellXPS";
    
    networking.networkmanager.enable = true;

    time.timeZone = "Europe/Ljubljana";

    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "sl_SI.UTF-8";
      LC_IDENTIFICATION = "sl_SI.UTF-8";
      LC_MEASUREMENT = "sl_SI.UTF-8";
      LC_MONETARY = "sl_SI.UTF-8";
      LC_NAME = "sl_SI.UTF-8";
      LC_NUMERIC = "sl_SI.UTF-8";
      LC_PAPER = "sl_SI.UTF-8";
      LC_TELEPHONE = "sl_SI.UTF-8";
      LC_TIME = "sl_SI.UTF-8";
    };

    services.displayManager.gdm = {
      enable = true;
      wayland = true;
    };
    services.desktopManager.gnome.enable = true;

    console.keyMap = "slovene";
    services.printing.enable = true;

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    services.openssh.enable = true;

    services.tailscale.enable = true;

    environment.systemPackages = with pkgs; [
      firefox
      helix    
      codex
      tree
    ];

    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    nixpkgs.config.allowUnfree = true;

    home-manager.sharedModules = [
      ({ lib, ... }: {
        home.stateVersion = lib.mkDefault "25.11";
      })
    ];
    system.stateVersion = "25.11";
  };
}

