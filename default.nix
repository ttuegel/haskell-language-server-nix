{}:

let
  projects = import ./projects.nix {};
  get = name: projects.${name}.haskell-language-server.components.exes.haskell-language-server;
in

{
  ghc-8_8_3 = get "8.8.3";
  ghc-8_8_4 = get "8.8.4";
  ghc-8_10_1 = get "8.10.1";
  ghc-8_10_2 = get "8.10.2";
}
