{ self, templates, ... }:
templates.vps {
  modules = with self.nixosModules.modules; [
    virtualization.qemu
  ];

  extraConfig = { ... }: {
  };
}
