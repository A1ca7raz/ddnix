{ self, vps, ... }:
vps {
  modules = with self.nixosModules.modules; [
    test
    # virtualization.qemu
  ];

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
    # systemd.network.networks.eth0 = {
    #   address = [
    #     "74.48.100.141/26"
    #     "2607:f130:0:f3:ff:ff:9659:d04f/64"
    #   ];
    #   gateway = [
    #     "74.48.100.129"
    #     "2607:f130:0:f3::1"
    #   ];
    #   matchConfig.Name = "eth0";
    # };
  };
}