{ pkgs, ... }:
{
  programs = {
    bash.vteIntegration = true;
    mosh.enable = true;
  };

  environment.systemPackages = with pkgs; [
    curlFull
    iperf
    lsof
    neofetch
    openssl
    vim
  ];
}