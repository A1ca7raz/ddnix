{ self, ... }:
{
  system = "x86_64-linux";

  modules = with self.nixosModules.modules; [
    apps
    config
    services
    system
  ];
}