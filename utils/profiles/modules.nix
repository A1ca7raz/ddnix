{ lib, self, path, inputs, ... }:
{
  modules,
  users,
  targetUser
}:
with lib; with builtins;
let
  localUsers =
    if targetUser == "root"
    then attrNames users
    else unique (attrNames users ++ [ targetUser ]);

  moduleAttrs = classifyModules modules localUsers;

  nixosModules = moduleAttrs.nixosModules;

  specificUserModules = foldlAttrs
    (acc: name: value:
      let
        _moduleAttrs = classifyModules (attrByPath [ "modules" ] [] value) [name];
        _nixosModules_user = _moduleAttrs.nixosModules;
      in {
        modules = acc.modules ++ _nixosModules_user;
      }
    ) { modules = []; } users;
in {
  modules = nixosModules ++ specificUserModules.modules;
}
  
