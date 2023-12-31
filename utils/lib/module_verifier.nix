lib:
with lib; with builtins; {
  # NixosModule
  isNixosModule = isFunction;

  # Set of modules
  isModuleSet = x:
    isAttrs x &&
    hasAttrByPath [ "__isModuleSet__" ] x &&
    x.__isModuleSet__ == true;
}