{ pkgs, ... }:
{
  users.mutableUsers = false;
  users.users.root = {
    shell = pkgs.fish;
    hashedPassword = "$6$99.u/DR1lrbQxXCa$lhyklXdawo0s7Y5wg1C7BlIJ0VqSZI9xesuPmazkqRTUpf8Fnh2rrOode9AIwKnfiT3lrQx3bVGw.rvIpbuPz0";
  };

  security.sudo.wheelNeedsPassword = false;
}