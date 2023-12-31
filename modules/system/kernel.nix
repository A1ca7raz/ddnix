{ pkgs, ... }:
{
  boot = {
    tmp.useTmpfs = true;

    kernelParams = [
      "panic=1" "boot.panic_on_fail"              # Troubleshooting
      "sysrq_always_enabled=1"                    # SysRQ

      # 关闭内核的操作审计功能
      "audit=0"
      # 不要根据 PCIe 地址生成网卡名（例如 enp1s0，对 VPS 没用），而是直接根据顺序生成（例如 eth0）
      "net.ifnames=0"
    ];
    
    kernelPackages = pkgs.linuxPackages_xanmod_stable;

    # 开启 ZSTD 压缩和基于 systemd 的第一阶段启动
    initrd = {
      compressor = "zstd";
      compressorArgs = ["-19" "-T0"];
      systemd.enable = true;
    };
  };
}