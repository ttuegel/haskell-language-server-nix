{
  extras = hackage:
    {
      packages = {
        "brittany" = (((hackage.brittany)."0.13.1.0").revisions).default;
        "Cabal" = (((hackage.Cabal)."3.0.2.0").revisions).default;
        "clock" = (((hackage.clock)."0.7.2").revisions).default;
        "floskell" = (((hackage.floskell)."0.10.4").revisions).default;
        "fourmolu" = (((hackage.fourmolu)."0.3.0.0").revisions).default;
        "heapsize" = (((hackage.heapsize)."0.3.0").revisions).default;
        "implicit-hie-cradle" = (((hackage.implicit-hie-cradle)."0.3.0.2").revisions).default;
        "implicit-hie" = (((hackage.implicit-hie)."0.1.2.5").revisions).default;
        "lsp-test" = (((hackage.lsp-test)."0.11.0.6").revisions).default;
        "monad-dijkstra" = (((hackage.monad-dijkstra)."0.1.1.2").revisions).default;
        "refinery" = (((hackage.refinery)."0.3.0.0").revisions).default;
        "retrie" = (((hackage.retrie)."0.1.1.1").revisions).default;
        "stylish-haskell" = (((hackage.stylish-haskell)."0.12.2.0").revisions).default;
        "semigroups" = (((hackage.semigroups)."0.18.5").revisions).default;
        "temporary" = (((hackage.temporary)."1.2.1.1").revisions).default;
        "data-tree-print" = (((hackage.data-tree-print)."0.1.0.2").revisions).r2;
        haskell-language-server = ./haskell-language-server.nix;
        hie-compat = ./hie-compat.nix;
        ghcide = ./ghcide.nix;
        hls-plugin-api = ./hls-plugin-api.nix;
        hls-tactics-plugin = ./hls-tactics-plugin.nix;
        hls-hlint-plugin = ./hls-hlint-plugin.nix;
        hls-explicit-imports-plugin = ./hls-explicit-imports-plugin.nix;
        hls-retrie-plugin = ./hls-retrie-plugin.nix;
        };
      };
  resolver = "nightly-2020-12-09";
  modules = [
    ({ lib, ... }:
      {
        packages = {
          "haskell-language-server" = {
            flags = { "pedantic" = lib.mkOverride 900 true; };
            };
          "retrie" = {
            flags = { "BuildExecutable" = lib.mkOverride 900 false; };
            };
          };
        })
    {
      packages = {
        "$everything" = { package = { ghcOptions = "-haddock"; }; };
        };
      }
    ];
  }