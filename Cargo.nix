# This file was @generated by cargo2nix 0.11.0.
# It is not intended to be manually edited.

args@{
  release ? true,
  rootFeatures ? [
    "hello/default"
  ],
  rustPackages,
  buildRustPackages,
  hostPlatform,
  hostPlatformCpu ? null,
  hostPlatformFeatures ? [],
  target ? null,
  codegenOpts ? null,
  profileOpts ? null,
  rustcLinkFlags ? null,
  rustcBuildFlags ? null,
  mkRustCrate,
  rustLib,
  lib,
  workspaceSrc,
}:
let
  workspaceSrc = if args.workspaceSrc == null then ./. else args.workspaceSrc;
in let
  inherit (rustLib) fetchCratesIo fetchCrateLocal fetchCrateGit fetchCrateAlternativeRegistry expandFeatures decideProfile genDrvsByProfile;
  profilesByName = {
  };
  rootFeatures' = expandFeatures rootFeatures;
  overridableMkRustCrate = f:
    let
      drvs = genDrvsByProfile profilesByName ({ profile, profileName }: mkRustCrate ({ inherit release profile hostPlatformCpu hostPlatformFeatures target profileOpts codegenOpts rustcLinkFlags rustcBuildFlags; } // (f profileName)));
    in { compileMode ? null, profileName ? decideProfile compileMode release }:
      let drv = drvs.${profileName}; in if compileMode == null then drv else drv.override { inherit compileMode; };
in
{
  cargo2nixVersion = "0.11.0";
  workspace = {
    hello = rustPackages.unknown.hello."0.1.0";
  };
  "registry+https://github.com/rust-lang/crates.io-index".cc."1.0.73" = overridableMkRustCrate (profileName: rec {
    name = "cc";
    version = "1.0.73";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "2fff2a6927b3bb87f9595d67196a70493f627687a71d87a0d692242c33f58c11"; };
  });
  
  "unknown".hello."0.1.0" = overridableMkRustCrate (profileName: rec {
    name = "hello";
    version = "0.1.0";
    registry = "unknown";
    src = fetchCrateLocal workspaceSrc;
    dependencies = {
      secp256k1_zkp = rustPackages."registry+https://github.com/rust-lang/crates.io-index".secp256k1-zkp."0.6.0" { inherit profileName; };
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".secp256k1."0.22.1" = overridableMkRustCrate (profileName: rec {
    name = "secp256k1";
    version = "0.22.1";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "26947345339603ae8395f68e2f3d85a6b0a8ddfe6315818e80b8504415099db0"; };
    features = builtins.concatLists [
      [ "default" ]
      [ "std" ]
    ];
    dependencies = {
      secp256k1_sys = rustPackages."registry+https://github.com/rust-lang/crates.io-index".secp256k1-sys."0.5.2" { inherit profileName; };
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".secp256k1-sys."0.5.2" = overridableMkRustCrate (profileName: rec {
    name = "secp256k1-sys";
    version = "0.5.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "152e20a0fd0519390fc43ab404663af8a0b794273d2a91d60ad4a39f13ffe110"; };
    features = builtins.concatLists [
      [ "default" ]
      [ "std" ]
    ];
    buildDependencies = {
      cc = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".cc."1.0.73" { profileName = "__noProfile"; };
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".secp256k1-zkp."0.6.0" = overridableMkRustCrate (profileName: rec {
    name = "secp256k1-zkp";
    version = "0.6.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "c724fda6aae465ed9a39320202bc6164e0adb3cdf9bc16d5af4be7eebaba75e5"; };
    features = builtins.concatLists [
      [ "default" ]
      [ "std" ]
    ];
    dependencies = {
      secp256k1 = rustPackages."registry+https://github.com/rust-lang/crates.io-index".secp256k1."0.22.1" { inherit profileName; };
      secp256k1_zkp_sys = rustPackages."registry+https://github.com/rust-lang/crates.io-index".secp256k1-zkp-sys."0.6.0" { inherit profileName; };
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".secp256k1-zkp-sys."0.6.0" = overridableMkRustCrate (profileName: rec {
    name = "secp256k1-zkp-sys";
    version = "0.6.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "e6f880412a627e79d3ce17355150ea1e0e76570efb7f0f70df51504cbe2582e3"; };
    features = builtins.concatLists [
      [ "std" ]
    ];
    dependencies = {
      secp256k1_sys = rustPackages."registry+https://github.com/rust-lang/crates.io-index".secp256k1-sys."0.5.2" { inherit profileName; };
    };
    buildDependencies = {
      cc = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".cc."1.0.73" { profileName = "__noProfile"; };
    };
  });
  
}
