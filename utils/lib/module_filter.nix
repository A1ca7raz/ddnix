lib:
with lib; with builtins;
let
  inherit (import ./module_verifier.nix lib)
    isNixosModule
    isModuleSet;
in {

  getModuleList = list:
    let
      _parser = item:
        if isFunction item
        then item
        else if isModuleSet item
        then _recur item
        else null;
      _recur = mapAttrsToList (name: _parser);
    in
      flatten (concatMap
        (item:
          if isFunction item
          then [ item ]
          else if isModuleSet item
          then [(_recur item)]
          else []
        ) list
      );

  # modules without 'user' arg (nixosModule)
  filterNixosModules = concatMap (x: if isNixosModule x then [x] else []);
}