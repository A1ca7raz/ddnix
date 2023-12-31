{ lib, ... }:
{
  name,
  system,
  nixosSystem,
  ...
}: {
  packages.${system}.${name} = (lib.nixosSystem nixosSystem).config.system.build.diskoImages;
}