{ lib, ... }:
{
  name,
  system,
  nixosSystem,
  ...
}: {
  diskoImages.${name} = (lib.nixosSystem nixosSystem).config.system.build.diskoImages;
}