{ pkgs, ... }:
{
  programs = {
    bash.vteIntegration = true;
    mosh.enable = true;
  };

  environment.systemPackages = with pkgs; [
    curlFull
    openssl
    vim
  ];
}