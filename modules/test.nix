{ ... }:
{
  systemd.network.networks.eth0 = {
    DHCP = "yes";
    matchConfig.Name = "eth0";
  };

  users.users.root.password = "asd";
}