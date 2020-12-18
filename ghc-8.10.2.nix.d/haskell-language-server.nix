{ system
  , compiler
  , flags
  , pkgs
  , hsPkgs
  , pkgconfPkgs
  , errorHandler
  , config
  , ... }:
  {
    flags = { agpl = true; pedantic = false; };
    package = {
      specVersion = "2.2";
      identifier = { name = "haskell-language-server"; version = "0.7.0.0"; };
      license = "Apache-2.0";
      copyright = "Alan Zimmerman";
      maintainer = "alan.zimm@gmail.com";
      author = "Alan Zimmerman";
      homepage = "https://github.com/haskell/haskell-language-server#readme";
      url = "";
      synopsis = "LSP server for GHC";
      description = "Please see the README on GitHub at <https://github.com/haskell/haskell-language-server#readme>";
      buildType = "Simple";
      isLocal = true;
      detailLevel = "FullDetails";
      licenseFiles = [ "LICENSE" ];
      dataDir = "";
      dataFiles = [];
      extraSrcFiles = [
        "README.md"
        "ChangeLog.md"
        "include/ghc-api-version.h"
        ];
      extraTmpFiles = [];
      extraDocFiles = [];
      };
    components = {
      "library" = {
        depends = [
          (hsPkgs."base" or (errorHandler.buildDepError "base"))
          (hsPkgs."directory" or (errorHandler.buildDepError "directory"))
          (hsPkgs."extra" or (errorHandler.buildDepError "extra"))
          (hsPkgs."filepath" or (errorHandler.buildDepError "filepath"))
          (hsPkgs."text" or (errorHandler.buildDepError "text"))
          (hsPkgs."containers" or (errorHandler.buildDepError "containers"))
          (hsPkgs."data-default" or (errorHandler.buildDepError "data-default"))
          (hsPkgs."ghc" or (errorHandler.buildDepError "ghc"))
          (hsPkgs."ghcide" or (errorHandler.buildDepError "ghcide"))
          (hsPkgs."gitrev" or (errorHandler.buildDepError "gitrev"))
          (hsPkgs."haskell-lsp" or (errorHandler.buildDepError "haskell-lsp"))
          (hsPkgs."hls-plugin-api" or (errorHandler.buildDepError "hls-plugin-api"))
          (hsPkgs."hslogger" or (errorHandler.buildDepError "hslogger"))
          (hsPkgs."optparse-applicative" or (errorHandler.buildDepError "optparse-applicative"))
          (hsPkgs."optparse-simple" or (errorHandler.buildDepError "optparse-simple"))
          (hsPkgs."process" or (errorHandler.buildDepError "process"))
          (hsPkgs."shake" or (errorHandler.buildDepError "shake"))
          (hsPkgs."unordered-containers" or (errorHandler.buildDepError "unordered-containers"))
          ];
        buildable = true;
        modules = [
          "Paths_haskell_language_server"
          "Ide/Arguments"
          "Ide/Main"
          "Ide/Version"
          ];
        hsSourceDirs = [ "src" ];
        };
      exes = {
        "haskell-language-server" = {
          depends = [
            (hsPkgs."base" or (errorHandler.buildDepError "base"))
            (hsPkgs."directory" or (errorHandler.buildDepError "directory"))
            (hsPkgs."extra" or (errorHandler.buildDepError "extra"))
            (hsPkgs."filepath" or (errorHandler.buildDepError "filepath"))
            (hsPkgs."text" or (errorHandler.buildDepError "text"))
            (hsPkgs."aeson" or (errorHandler.buildDepError "aeson"))
            (hsPkgs."binary" or (errorHandler.buildDepError "binary"))
            (hsPkgs."bytestring" or (errorHandler.buildDepError "bytestring"))
            (hsPkgs."containers" or (errorHandler.buildDepError "containers"))
            (hsPkgs."deepseq" or (errorHandler.buildDepError "deepseq"))
            (hsPkgs."floskell" or (errorHandler.buildDepError "floskell"))
            (hsPkgs."fourmolu" or (errorHandler.buildDepError "fourmolu"))
            (hsPkgs."ghc" or (errorHandler.buildDepError "ghc"))
            (hsPkgs."ghc-boot-th" or (errorHandler.buildDepError "ghc-boot-th"))
            (hsPkgs."ghcide" or (errorHandler.buildDepError "ghcide"))
            (hsPkgs."hashable" or (errorHandler.buildDepError "hashable"))
            (hsPkgs."haskell-language-server" or (errorHandler.buildDepError "haskell-language-server"))
            (hsPkgs."haskell-lsp" or (errorHandler.buildDepError "haskell-lsp"))
            (hsPkgs."hls-hlint-plugin" or (errorHandler.buildDepError "hls-hlint-plugin"))
            (hsPkgs."hls-plugin-api" or (errorHandler.buildDepError "hls-plugin-api"))
            (hsPkgs."hls-tactics-plugin" or (errorHandler.buildDepError "hls-tactics-plugin"))
            (hsPkgs."hls-explicit-imports-plugin" or (errorHandler.buildDepError "hls-explicit-imports-plugin"))
            (hsPkgs."hls-retrie-plugin" or (errorHandler.buildDepError "hls-retrie-plugin"))
            (hsPkgs."lens" or (errorHandler.buildDepError "lens"))
            (hsPkgs."ormolu" or (errorHandler.buildDepError "ormolu"))
            (hsPkgs."regex-tdfa" or (errorHandler.buildDepError "regex-tdfa"))
            (hsPkgs."hslogger" or (errorHandler.buildDepError "hslogger"))
            (hsPkgs."optparse-applicative" or (errorHandler.buildDepError "optparse-applicative"))
            (hsPkgs."mtl" or (errorHandler.buildDepError "mtl"))
            (hsPkgs."safe-exceptions" or (errorHandler.buildDepError "safe-exceptions"))
            (hsPkgs."shake" or (errorHandler.buildDepError "shake"))
            (hsPkgs."stylish-haskell" or (errorHandler.buildDepError "stylish-haskell"))
            (hsPkgs."temporary" or (errorHandler.buildDepError "temporary"))
            (hsPkgs."time" or (errorHandler.buildDepError "time"))
            (hsPkgs."transformers" or (errorHandler.buildDepError "transformers"))
            (hsPkgs."unordered-containers" or (errorHandler.buildDepError "unordered-containers"))
            ] ++ (pkgs.lib).optional (flags.agpl) (hsPkgs."brittany" or (errorHandler.buildDepError "brittany"));
          buildable = true;
          modules = [
            "Ide/Plugin/Eval"
            "Ide/Plugin/Example"
            "Ide/Plugin/Example2"
            "Ide/Plugin/Floskell"
            "Ide/Plugin/Fourmolu"
            "Ide/Plugin/ModuleName"
            "Ide/Plugin/Ormolu"
            "Ide/Plugin/Pragmas"
            "Ide/Plugin/StylishHaskell"
            ] ++ (pkgs.lib).optional (flags.agpl) "Ide/Plugin/Brittany";
          hsSourceDirs = [ "exe" "plugins/default/src" ];
          includeDirs = [ "include" ];
          mainPath = (([
            "Main.hs"
            ] ++ (pkgs.lib).optional (flags.agpl) "") ++ (pkgs.lib).optional (flags.pedantic) "") ++ (pkgs.lib).optional (flags.agpl) "";
          };
        "haskell-language-server-wrapper" = {
          depends = [
            (hsPkgs."base" or (errorHandler.buildDepError "base"))
            (hsPkgs."directory" or (errorHandler.buildDepError "directory"))
            (hsPkgs."extra" or (errorHandler.buildDepError "extra"))
            (hsPkgs."filepath" or (errorHandler.buildDepError "filepath"))
            (hsPkgs."text" or (errorHandler.buildDepError "text"))
            (hsPkgs."ghc" or (errorHandler.buildDepError "ghc"))
            (hsPkgs."ghc-paths" or (errorHandler.buildDepError "ghc-paths"))
            (hsPkgs."ghcide" or (errorHandler.buildDepError "ghcide"))
            (hsPkgs."gitrev" or (errorHandler.buildDepError "gitrev"))
            (hsPkgs."haskell-language-server" or (errorHandler.buildDepError "haskell-language-server"))
            (hsPkgs."hie-bios" or (errorHandler.buildDepError "hie-bios"))
            (hsPkgs."optparse-applicative" or (errorHandler.buildDepError "optparse-applicative"))
            (hsPkgs."optparse-simple" or (errorHandler.buildDepError "optparse-simple"))
            (hsPkgs."process" or (errorHandler.buildDepError "process"))
            ];
          buildable = true;
          modules = [ "Paths_haskell_language_server" ];
          hsSourceDirs = [ "exe" ];
          mainPath = ([
            "Wrapper.hs"
            ] ++ (pkgs.lib).optional (flags.agpl) "") ++ (pkgs.lib).optional (flags.pedantic) "";
          };
        };
      tests = {
        "func-test" = {
          depends = [
            (hsPkgs."base" or (errorHandler.buildDepError "base"))
            (hsPkgs."directory" or (errorHandler.buildDepError "directory"))
            (hsPkgs."extra" or (errorHandler.buildDepError "extra"))
            (hsPkgs."filepath" or (errorHandler.buildDepError "filepath"))
            (hsPkgs."text" or (errorHandler.buildDepError "text"))
            (hsPkgs."aeson" or (errorHandler.buildDepError "aeson"))
            (hsPkgs."blaze-markup" or (errorHandler.buildDepError "blaze-markup"))
            (hsPkgs."containers" or (errorHandler.buildDepError "containers"))
            (hsPkgs."data-default" or (errorHandler.buildDepError "data-default"))
            (hsPkgs."haskell-lsp" or (errorHandler.buildDepError "haskell-lsp"))
            (hsPkgs."hie-bios" or (errorHandler.buildDepError "hie-bios"))
            (hsPkgs."hls-plugin-api" or (errorHandler.buildDepError "hls-plugin-api"))
            (hsPkgs."hslogger" or (errorHandler.buildDepError "hslogger"))
            (hsPkgs."hspec" or (errorHandler.buildDepError "hspec"))
            (hsPkgs."hspec-core" or (errorHandler.buildDepError "hspec-core"))
            (hsPkgs."lens" or (errorHandler.buildDepError "lens"))
            (hsPkgs."lsp-test" or (errorHandler.buildDepError "lsp-test"))
            (hsPkgs."stm" or (errorHandler.buildDepError "stm"))
            (hsPkgs."tasty-expected-failure" or (errorHandler.buildDepError "tasty-expected-failure"))
            (hsPkgs."tasty-hunit" or (errorHandler.buildDepError "tasty-hunit"))
            (hsPkgs."temporary" or (errorHandler.buildDepError "temporary"))
            (hsPkgs."transformers" or (errorHandler.buildDepError "transformers"))
            (hsPkgs."unordered-containers" or (errorHandler.buildDepError "unordered-containers"))
            (hsPkgs."yaml" or (errorHandler.buildDepError "yaml"))
            (hsPkgs."bytestring" or (errorHandler.buildDepError "bytestring"))
            (hsPkgs."tasty" or (errorHandler.buildDepError "tasty"))
            (hsPkgs."tasty-ant-xml" or (errorHandler.buildDepError "tasty-ant-xml"))
            (hsPkgs."tasty-golden" or (errorHandler.buildDepError "tasty-golden"))
            (hsPkgs."tasty-rerun" or (errorHandler.buildDepError "tasty-rerun"))
            ];
          build-tools = [
            (hsPkgs.buildPackages.haskell-language-server or (pkgs.buildPackages.haskell-language-server or (errorHandler.buildToolDepError "haskell-language-server")))
            (hsPkgs.buildPackages.ghcide or (pkgs.buildPackages.ghcide or (errorHandler.buildToolDepError "ghcide")))
            ];
          buildable = true;
          modules = [
            "Test/Hls/Util"
            "Command"
            "Completion"
            "Deferred"
            "Definition"
            "Diagnostic"
            "Eval"
            "Format"
            "FunctionalBadProject"
            "FunctionalCodeAction"
            "FunctionalLiquid"
            "HieBios"
            "Highlight"
            "ModuleName"
            "Progress"
            "Reference"
            "Rename"
            "Symbol"
            "TypeDefinition"
            "Tactic"
            "Ide/Plugin/Tactic/TestTypes"
            ];
          hsSourceDirs = [
            "test/utils"
            "test/functional"
            "plugins/tactics/src"
            ];
          mainPath = [ "Main.hs" ];
          };
        "wrapper-test" = {
          depends = [
            (hsPkgs."base" or (errorHandler.buildDepError "base"))
            (hsPkgs."directory" or (errorHandler.buildDepError "directory"))
            (hsPkgs."extra" or (errorHandler.buildDepError "extra"))
            (hsPkgs."filepath" or (errorHandler.buildDepError "filepath"))
            (hsPkgs."text" or (errorHandler.buildDepError "text"))
            (hsPkgs."aeson" or (errorHandler.buildDepError "aeson"))
            (hsPkgs."blaze-markup" or (errorHandler.buildDepError "blaze-markup"))
            (hsPkgs."containers" or (errorHandler.buildDepError "containers"))
            (hsPkgs."data-default" or (errorHandler.buildDepError "data-default"))
            (hsPkgs."haskell-lsp" or (errorHandler.buildDepError "haskell-lsp"))
            (hsPkgs."hie-bios" or (errorHandler.buildDepError "hie-bios"))
            (hsPkgs."hls-plugin-api" or (errorHandler.buildDepError "hls-plugin-api"))
            (hsPkgs."hslogger" or (errorHandler.buildDepError "hslogger"))
            (hsPkgs."hspec" or (errorHandler.buildDepError "hspec"))
            (hsPkgs."hspec-core" or (errorHandler.buildDepError "hspec-core"))
            (hsPkgs."lens" or (errorHandler.buildDepError "lens"))
            (hsPkgs."lsp-test" or (errorHandler.buildDepError "lsp-test"))
            (hsPkgs."stm" or (errorHandler.buildDepError "stm"))
            (hsPkgs."tasty-expected-failure" or (errorHandler.buildDepError "tasty-expected-failure"))
            (hsPkgs."tasty-hunit" or (errorHandler.buildDepError "tasty-hunit"))
            (hsPkgs."temporary" or (errorHandler.buildDepError "temporary"))
            (hsPkgs."transformers" or (errorHandler.buildDepError "transformers"))
            (hsPkgs."unordered-containers" or (errorHandler.buildDepError "unordered-containers"))
            (hsPkgs."yaml" or (errorHandler.buildDepError "yaml"))
            (hsPkgs."base" or (errorHandler.buildDepError "base"))
            (hsPkgs."process" or (errorHandler.buildDepError "process"))
            (hsPkgs."tasty" or (errorHandler.buildDepError "tasty"))
            (hsPkgs."tasty-ant-xml" or (errorHandler.buildDepError "tasty-ant-xml"))
            (hsPkgs."tasty-rerun" or (errorHandler.buildDepError "tasty-rerun"))
            ];
          build-tools = [
            (hsPkgs.buildPackages.haskell-language-server or (pkgs.buildPackages.haskell-language-server or (errorHandler.buildToolDepError "haskell-language-server")))
            ];
          buildable = true;
          modules = [ "Test/Hls/Util" ];
          hsSourceDirs = [ "test/utils" "test/wrapper" ];
          mainPath = [ "Main.hs" ];
          };
        };
      };
    } // rec {
    src = (pkgs.lib).mkDefault ./.;
    }