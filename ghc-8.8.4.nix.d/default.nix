{
  extras = hackage:
    {
      packages = {
        "aeson" = (((hackage.aeson)."1.5.2.0").revisions).default;
        "apply-refact" = (((hackage.apply-refact)."0.8.2.1").revisions).default;
        "brittany" = (((hackage.brittany)."0.13.1.0").revisions).default;
        "bytestring-trie" = (((hackage.bytestring-trie)."0.2.5.0").revisions).default;
        "cabal-plan" = (((hackage.cabal-plan)."0.6.2.0").revisions).default;
        "clock" = (((hackage.clock)."0.7.2").revisions).default;
        "constrained-dynamic" = (((hackage.constrained-dynamic)."0.1.0.0").revisions).default;
        "floskell" = (((hackage.floskell)."0.10.4").revisions).default;
        "fourmolu" = (((hackage.fourmolu)."0.3.0.0").revisions).default;
        "ghc-exactprint" = (((hackage.ghc-exactprint)."0.6.3.2").revisions).default;
        "ghc-trace-events" = (((hackage.ghc-trace-events)."0.1.2.1").revisions).default;
        "haskell-src-exts" = (((hackage.haskell-src-exts)."1.21.1").revisions).default;
        "heapsize" = (((hackage.heapsize)."0.3.0").revisions).default;
        "hie-bios" = (((hackage.hie-bios)."0.7.1").revisions).default;
        "hlint" = (((hackage.hlint)."3.2.3").revisions).default;
        "hoogle" = (((hackage.hoogle)."5.0.17.11").revisions).default;
        "hsimport" = (((hackage.hsimport)."0.11.0").revisions).default;
        "ilist" = (((hackage.ilist)."0.3.1.0").revisions).default;
        "implicit-hie-cradle" = (((hackage.implicit-hie-cradle)."0.3.0.2").revisions).default;
        "implicit-hie" = (((hackage.implicit-hie)."0.1.2.5").revisions).default;
        "lsp-test" = (((hackage.lsp-test)."0.11.0.6").revisions).default;
        "monad-dijkstra" = (((hackage.monad-dijkstra)."0.1.1.2").revisions).default;
        "opentelemetry" = (((hackage.opentelemetry)."0.6.1").revisions).default;
        "opentelemetry-extra" = (((hackage.opentelemetry-extra)."0.6.1").revisions).default;
        "refinery" = (((hackage.refinery)."0.3.0.0").revisions).default;
        "retrie" = (((hackage.retrie)."0.1.1.1").revisions).default;
        "semigroups" = (((hackage.semigroups)."0.18.5").revisions).default;
        "stylish-haskell" = (((hackage.stylish-haskell)."0.12.2.0").revisions).default;
        "temporary" = (((hackage.temporary)."1.2.1.1").revisions).default;
        "HsYAML-aeson" = (((hackage.HsYAML-aeson)."0.2.0.0").revisions).r2;
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
  resolver = "lts-16.25";
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