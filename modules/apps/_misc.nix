{ pkgs, modulesPath, ... }:
{
  imports = [
    # (modulesPath + "/profiles/base.nix")
  ];

  environment.systemPackages = with pkgs; [
    curl
    openssl
    vim
    git
    htop
    dosfstools
    btrfs-progs
    rsync
  ];
}
