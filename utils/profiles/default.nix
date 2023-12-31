{ lib, self, path, inputs, tools, ... }@args:
with lib; with tools; let
  # module处理器
  module_parser = import ./modules.nix args;

  # 获取profile列表
  profile_path = /${path}/profiles;
  profile_list = remove "__templates" (_getListFromDir "directory" profile_path);

  # 处理模板
  inherit (import ./templates.nix args) templates blankTemplate; # 后处理模板集
  passthruTpl = profile:
    let
      wrapped = profile (templates // args);
    in
      if (hasAttrByPath [ "__isWrappedTpl__" ] wrapped)
      then wrapped
      else blankTemplate wrapped;

  # 处理profile钩子: 生成colmena和nixos config两种配置
  # hook: args: profile:
  attrsHooks = importsFiles ./attrhooks;
  mergeLoaderHooks = profile:
    let
      hooks = forEach attrsHooks (x: (import x) args profile);
    in
      zipAttrsWith (name: vals: fold (x: y: recursiveUpdate x y) {} vals) hooks;

  # 生成nixossystem
  mkSystem = name: {
    system,
    modules ? {},
    ...
  }: {
    inherit system;
    specialArgs = { inherit self path inputs tools; };
    modules = [
      # Default Modules
      self.nixosModules.impermanence
      self.nixosModules.disko
      self.nixosModules.nur
      /${profile_path}/${name}/hardware-configuration.nix
      /${profile_path}/${name}/disks.nix
    ] ++ (module_parser { inherit modules; });
  };

  _profiles = fold
    (x: y:
      [(
        mergeLoaderHooks (
          (z: rec {
            name = x;
            inherit (z) system;
            nixosSystem = mkSystem x z;
            modules = nixosSystem.modules;
          })
          (passthruTpl (import /${profile_path}/${x}))
        )
      )] ++ y
    ) [] profile_list;
in
  foldAttrs (n: a: n // a) {} _profiles