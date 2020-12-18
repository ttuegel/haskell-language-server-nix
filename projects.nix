{ checkMaterialization ? false }:

let
  _pkgs = import <nixpkgs> {};
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
in

{
  "ghc-8.8.3" = mk "8.8.3";
  "ghc-8.8.4" = mk "8.8.4";
  "ghc-8.10.1" = mk "8.10.1";
  "ghc-8.10.2" = mk "8.10.2";
}
