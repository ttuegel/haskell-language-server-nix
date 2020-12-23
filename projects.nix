{ checkMaterialization ? false }:

let
  # Get a copy of Nixpkgs for fetchgit and importJSON. Any recent version will do fine.
  _pkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-20.09.tar.gz") {};
  fetchgit = lockFile: _pkgs.fetchgit {
      inherit (_pkgs.lib.importJSON lockFile)
        url rev sha256 fetchSubmodules deepClone leaveDotGit;
  };
  sources = {
    "haskell.nix" = fetchgit ./haskell.nix.lock.json;
    "haskell-language-server" = fetchgit ./haskell-language-server.lock.json;
  };
in

let
  inherit (import sources."haskell.nix" {}) pkgs;
  inherit (pkgs) lib;
in

let
  mk = ghc: pkgs.haskell-nix.project {
    src = sources."haskell-language-server";
    projectFileName = "stack-${ghc}.yaml";
    modules = [
      # Strip the executables to reduce closure size.
      { dontStrip = false; }
      # Separate data and libraries to reduce closure size.
      # With static linking, the data is required, but the libraries are not.
      { enableSeparateDataOutput = true; }
      # Patch ghcide so that it does not capture GHC in the closure.
      { packages.ghcide.patches = [ ./ghcide-session-loader.patch ]; }
      { packages.ghc-check.patches = [ ./ghc-check-ghc-paths.patch ]; }
      { packages.brittany.patches = [ ./brittany-ghc-paths.patch ]; }
      { packages.ghc-exactprint.patches = [ ./ghc-exactprint-ghc-paths.patch ]; }
    ];
    inherit checkMaterialization;
    materialized = ./. + "/ghc-${ghc}.nix.d";
  };

  versions = [
    "8.8.3"
    "8.8.4"
    "8.10.1"
    "8.10.2"
  ];

  projects =
    lib.pipe versions
    [
      (map (name: lib.nameValuePair name (mk name)))
      lib.listToAttrs
    ];

in

projects // { inherit pkgs versions; }
