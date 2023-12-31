{
  description = "A1ca7raz's NixOS Image for VPS";

  inputs = {
    nur.url = "github:A1ca7raz/nurpkgs";
    nixpkgs.follows = "nur/nixpkgs";

    impermanence.url = "github:nix-community/impermanence";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, ... }:
    let
      lib = nixpkgs.lib;
      utils = import ./utils lib self;
    in {
      nixosModules = utils.modules // (with inputs; {
        impermanence = impermanence.nixosModules.impermanence;
        disko = disko.nixosModules.disko;
        nur = nur.nixosModule;
      });

      nixosConfigurations = utils.profiles.nixosConfigurations;

      packages.x86_64-linux = utils.profiles.diskoImages;
    };
}
