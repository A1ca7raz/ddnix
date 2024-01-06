{ pkgs, modulesPath, ... }:
{
  imports = [
    # (modulesPath + "/profiles/base.nix")
  ];

  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    curl
    openssl
    vim
#     fish
    git
    htop
    dosfstools
    btrfs-progs
#     tmux
    rsync
  ];
}
