{ ... }:
{
  disko.devices = {
    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [ "defaults" "relatime" "mode=755" ];
    };
    disk.main = {
      imageSize = "1800M";
      device = "/dev/sda";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          boot = {
            size = "1M";
            type = "EF02"; # for grub MBR
            priority = 0;  # 优先级设置为最高，保证这块空间在硬盘开头
          };

          ESP = {
            label = "BOOT";
            size = "200M";
            type = "EF00";
            priority = 1;
            content = {
              type = "filesystem";
              format = "vfat";
              extraArgs = [ "-F32" ];
              mountpoint = "/boot";
              mountOptions = ["fmask=0077" "dmask=0077"];
            };
          };

          root = {
            label = "NIXOS";
            size = "100%";
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ];
              subvolumes = {
                "/NIX" = {
                  mountpoint = "/nix";
                  mountOptions = [ "compress-force=zstd" ];
                };
                "/PERSIST" = {
                  mountpoint = "/nix/persist";
                  mountOptions = [ "compress-force=zstd" ];
                };
              };
            };
          };
        };
      };
    };
  };

  # disko.enableConfig = false;

  # fileSystems."/" = {
  #   device = "tmpfs";
  #   fsType = "tmpfs";
  #   options = [ "default" "relatime" "mode=755" ];
  # };

  # fileSystems."/boot" = {
  #   device = "/dev/vda1";
  #   fsType = "vfat";
  #   options = [ "fmask=0077" "dmask=0077" ];
  # };

  # fileSystems."/nix" = {
  #   device = "/dev/vda2";
  #   fsType = "btrfs";
  #   options = [ "subvol=/NIX" "compress-force=zstd" ];
  # };

  # fileSystems."/nix/persist" = {
  #   device = "/dev/vda2";
  #   fsType = "btrfs";
  #   options = [ "subvol=/PERSIST" "compress-force=zstd" ];
  #   neededForBoot = true;
  # };
}
