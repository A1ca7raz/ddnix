{ lib, path, tools, ... }@args:
with lib; with tools; let
  tpl_path = /${path}/profiles/__templates;
  tpl_list = _getListFromDir "nix" tpl_path;

  blank_tpl = {
    system = "x86_64-linux";
    modules = [];
    extraConfig = {};
  };

  _mkTplWrapper = tpl_content: ctx:
    let
      trivial = recursiveUpdate blank_tpl tpl_content;  # 生成完整模板
      ctx_full = recursiveUpdate trivial ctx;
    in { # merge模块
      inherit (ctx_full) system;
      modules = unique (trivial.modules ++ ctx_full.modules ++ [ trivial.extraConfig ctx_full.extraConfig ]);
      "__isWrappedTpl__" = true;
    };
  
  mkTplWrapper = tpl:
    let
      name = removeNix tpl;
      tpl_content = import /${tpl_path}/${tpl} args;  # 模板正文
    in {
      ${name} = _mkTplWrapper tpl_content;
    };
in {
  blankTemplate = _mkTplWrapper blank_tpl;
  templates = fold (x: y: (mkTplWrapper x) // y) {} tpl_list;
}