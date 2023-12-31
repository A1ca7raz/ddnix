lib:
let
  inherit (import ./fold.nix lib)
    foldFileIfExists
    foldDirIfExists;
  inherit (import ./nix.nix lib)
    isNix;
in {
  importsFiles = dir: foldFileIfExists dir []
    (x: y:
      if isNix x
      then [ /${dir}/${x} ] ++ y
      else y
    );

  importsDirs = dir: foldDirIfExists dir [] (x: y: [ /${dir}/${x} ] ++ y);
}