{ ... }:
{
  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories = [ "/var/cache" "/var/lib" "/var/log" ];
  };

  fileSystems."/nix/persist".neededForBoot = true;
}