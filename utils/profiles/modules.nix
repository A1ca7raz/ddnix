{ lib, self, path, inputs, tools, ... }:
{
  modules
}:
with tools;
let
  module_list = getModuleList modules;
in
  filterNixosModules module_list
