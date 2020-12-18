{}:

let
  projects = import ./projects.nix {};
  get = name: projects.${name}.haskell-language-server.components.exes.haskell-language-server;
in

{
  ghc-8_8_3 = get "ghc-8.8.3";
  ghc-8_8_4 = get "ghc-8.8.4";
  ghc-8_10_1 = get "ghc-8.10.1";
  ghc-8_10_2 = get "ghc-8.10.2";
}
