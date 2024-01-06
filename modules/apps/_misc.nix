{ pkgs, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/profiles/base.nix")
  ];

  environment.systemPackages = with pkgs; [
    curlFull
    openssl
    vim
    fish
    git
    htop
    tmux
    rsync
  ];
}