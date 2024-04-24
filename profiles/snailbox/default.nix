{ self, vps, ... }:
vps {
  modules = with self.nixosModules.modules; [];

  extraConfig = { ... }: {
    boot.loader = {
      efi = {
        # canTouchEfiVariables = true;
        efiSysMountPoint = "/boot"; # ← use the same mount point here.
      };
      grub = {
        efiSupport = true;
        efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
        device = "nodev";
      };
    };
    systemd.network.networks.eth0 = {
      address = [
        "10.254.0.10/24"
      ];
      matchConfig.Name = "eth0";
    };
  };
}
