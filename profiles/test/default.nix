{ self, vps, ... }:
vps {
  modules = [ self.nixosModules.modules.test ];
}