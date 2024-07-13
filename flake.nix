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
    sops-nix.follows = "nur/sops-nix";
  };

  outputs = inputs@{ self, ... }:
    let
      utils = import ./utils self;
    in {
      nixosModules = utils.modules // (with inputs; {
        impermanence = impermanence.nixosModules.impermanence;
        disko = disko.nixosModules.disko;
        nur = nur.nixosModule;
        sops = inputs.sops-nix.nixosModules.sops;
      });

      nixosConfigurations = utils.profiles.nixosConfigurations;

      packages.x86_64-linux = utils.profiles.diskoImages;
    };
}
