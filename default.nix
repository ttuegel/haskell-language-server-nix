{
  ghc-versions ? []
}:

let
  projects = import ./projects.nix {};
  inherit (projects) pkgs;
  inherit (pkgs) lib;
in

# If ghc-versions is not set, then use all available versions.
# In any case, sort the list by version so that the latest version appears
# at the head of the list.
let _ghc-versions = ghc-versions; in
let
  version-greaterThan = v1: v2:
    builtins.compareVersions v1 v2 > 0;
  ghc-versions =
    builtins.sort version-greaterThan
      (if _ghc-versions != []
        then _ghc-versions
        else projects.versions
      );
  latest-ghc-version = builtins.head ghc-versions;
in
assert ghc-versions != [];

let
  exe = name: version:
    projects.${version}.haskell-language-server.components.exes.${name};
  wrapper = exe "haskell-language-server-wrapper" latest-ghc-version;
  server = version:
    pkgs.runCommand "haskell-languager-server-${version}"
      {
        inherit version;
        server = exe "haskell-language-server" version;
      }
      ''
        mkdir -p "$out/bin"
        ln -s \
          "$server/bin/haskell-language-server" \
          "$out/bin/haskell-language-server-$version"
      '';
in

pkgs.runCommand "haskell-language-server"
  {
    nativeBuildInputs = [ pkgs.makeWrapper ];
    wrapper = lib.getBin wrapper;
    wrapper_PATH = lib.makeBinPath (map server ghc-versions);
  }
  ''
    mkdir -p "$out/bin"
    makeWrapper \
      "$wrapper/bin/haskell-language-server-wrapper" \
      "$out/bin/haskell-language-server-wrapper" \
      --prefix PATH : "$wrapper_PATH"
  ''
