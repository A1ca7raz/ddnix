{ inputs, pkgs, config, ... }:
{
  nix = {
    nrBuildUsers = 0;

    # nix-direnv
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
    '';

    settings = {
      experimental-features = [ "nix-command" "flakes" "auto-allocate-uids" "cgroups" "repl-flake" ];
      nix-path = [
        "nixpkgs=${pkgs.path}"
        "nurpkgs=${inputs.nur}"
      ];
      auto-allocate-uids = true;
      use-cgroups = true;
      builders-use-substitutes = true;
      keep-derivations = true;
    };
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = config.system.nixos.version;
}