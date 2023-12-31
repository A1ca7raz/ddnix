{ self, vps, ... }:
vps {
  modules = with self.nixosModules.modules; [
    test
    virtualization.qemu
  ];
}
