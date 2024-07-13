{ lib, ... }:
{
  networking.firewall.enable = false;
  networking.useDHCP = false;

  # 使用 systemd-networkd 管理网络
  systemd.network.enable = true;
  services.resolved.enable = false;

  networking.hosts = {
    "127.0.0.1" = [ "localhost" ];
    "::1" = [ "localhost" ];
  };

  networking.nameservers = [ "8.8.8.8" "8.8.4.4" ];

  system.activationScripts = {
    symlinkNetworkd.text = ''
      ln -sfn /nix/persist/etc/systemd/network/eth0.network /etc/systemd/network/eth0.network
    '';

    symlinkNetworkd.deps = lib.mkAfter [ "etc" ];
  };
}