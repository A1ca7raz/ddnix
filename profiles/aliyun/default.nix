{ self, vps, ... }:
vps {
  modules = with self.nixosModules.modules; [
    virtualization.qemu
  ];

  extraConfig = { ... }: {
  };
}
