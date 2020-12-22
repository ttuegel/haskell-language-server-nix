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
      # This fixes a performance issue, probably
      # https://gitlab.haskell.org/ghc/ghc/issues/15524
      { packages.ghcide.configureFlags = [ "--enable-executable-dynamic" ]; }
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
in

lib.pipe versions
  [
    (map (name: lib.nameValuePair name (mk name)))
    lib.listToAttrs
  ]

