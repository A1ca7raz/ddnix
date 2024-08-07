{ ... }:
{
  disko.devices = {
    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [ "defaults" "relatime" "mode=755" ];
    };
    disk.main = {
      imageSize = "1800M";
      device = "/dev/vda";
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
            label = "PERSIST";
            size = "100%";
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ];
              subvolumes = {
                "/NIX" = {
                  mountpoint = "/nix";
                  mountOptions = [ "compress=zstd:3" ];
                };
                "/PERSIST" = {
                  mountpoint = "/nix/persist";
                  mountOptions = [ "compress=zstd:3" ];
                };
                "/SWAP" = {
                  mountpoint = "/swap";
                  mountOptions = [];
                };
              };
            };
          };
        };
      };
    };
  };
}
