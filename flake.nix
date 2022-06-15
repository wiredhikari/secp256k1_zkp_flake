{
  description = "secp256k1_zkp minimal project";

  inputs = {
    flake-utils.follows = "cargo2nix/flake-utils";
    nixpkgs.follows = "cargo2nix/nixpkgs";
    cargo2nix.url = "github:cargo2nix/cargo2nix/release-0.11.0";
  };

  outputs = { self, nixpkgs, flake-utils, cargo2nix, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ cargo2nix.overlay ];
        };

        rustPkgs = pkgs.rustBuilder.makePackageSet {
          rustChannel = "1.61.0";
          packageFun = import ./Cargo.nix;

          packageOverrides = pkgs: pkgs.rustBuilder.overrides.all ++ [
            (pkgs.rustBuilder.rustLib.makeOverride {
              name = "secp256k1-zkp-sys";
              overrideAttrs = drv: {
                propagatedBuildInputs = drv.propagatedBuildInputs or [ ] ++ [
                  pkgs.secp256k1
                ];
              };
            })
          ];
        };
        workspaceShell = rustPkgs.workspaceShell { };
      in
      rec {
        inherit rustPkgs;
        packages = builtins.mapAttrs (name: value: value { }) rustPkgs.workspace;
        defaultPackage = packages.hello.bin;
        devShell = workspaceShell;
      });
}
