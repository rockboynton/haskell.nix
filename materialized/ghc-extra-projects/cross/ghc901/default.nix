{
  pkgs = hackage:
    {
      packages = {
        "binary".revision = (((hackage."binary")."0.8.8.0").revisions).default;
        "ghc-prim".revision = (((hackage."ghc-prim")."0.7.0").revisions).default;
        "exceptions".revision = (((hackage."exceptions")."0.10.4").revisions).default;
        "array".revision = (((hackage."array")."0.5.4.0").revisions).default;
        "template-haskell".revision = (((hackage."template-haskell")."2.17.0.0").revisions).default;
        "network".revision = (((hackage."network")."2.8.0.1").revisions).default;
        "pretty".revision = (((hackage."pretty")."1.1.3.6").revisions).default;
        "process".revision = (((hackage."process")."1.6.11.0").revisions).default;
        "base".revision = (((hackage."base")."4.15.0.0").revisions).default;
        "rts".revision = (((hackage."rts")."1.0").revisions).default;
        "mtl".revision = (((hackage."mtl")."2.2.2").revisions).default;
        "time".revision = (((hackage."time")."1.9.3").revisions).default;
        "unix".revision = (((hackage."unix")."2.7.2.2").revisions).default;
        "containers".revision = (((hackage."containers")."0.6.4.1").revisions).default;
        "directory".revision = (((hackage."directory")."1.3.6.2").revisions).default;
        "ghc-boot-th".revision = (((hackage."ghc-boot-th")."9.0.1").revisions).default;
        "ghc-bignum".revision = (((hackage."ghc-bignum")."1.0").revisions).default;
        "filepath".revision = (((hackage."filepath")."1.4.2.1").revisions).default;
        "deepseq".revision = (((hackage."deepseq")."1.4.5.0").revisions).default;
        "transformers".revision = (((hackage."transformers")."0.5.6.2").revisions).default;
        "terminfo".revision = (((hackage."terminfo")."0.4.1.4").revisions).default;
        "ghc-heap".revision = (((hackage."ghc-heap")."9.0.1").revisions).default;
        "stm".revision = (((hackage."stm")."2.5.0.0").revisions).default;
        };
      compiler = {
        version = "9.0.1";
        nix-name = "ghc901";
        packages = {
          "ghc-prim" = "0.7.0";
          "exceptions" = "0.10.4";
          "array" = "0.5.4.0";
          "template-haskell" = "2.17.0.0";
          "pretty" = "1.1.3.6";
          "base" = "4.15.0.0";
          "rts" = "1.0";
          "mtl" = "2.2.2";
          "time" = "1.9.3";
          "containers" = "0.6.4.1";
          "ghc-boot-th" = "9.0.1";
          "ghc-bignum" = "1.0";
          "filepath" = "1.4.2.1";
          "deepseq" = "1.4.5.0";
          "transformers" = "0.5.6.2";
          "ghc-heap" = "9.0.1";
          "stm" = "2.5.0.0";
          };
        };
      };
  extras = hackage:
    {
      packages = {
        bytestring = ./.plan.nix/bytestring.nix;
        iserv = ./.plan.nix/iserv.nix;
        ghci = ./.plan.nix/ghci.nix;
        remote-iserv = ./.plan.nix/remote-iserv.nix;
        ghc-boot = ./.plan.nix/ghc-boot.nix;
        ghc = ./.plan.nix/ghc.nix;
        libiserv = ./.plan.nix/libiserv.nix;
        hpc = ./.plan.nix/hpc.nix;
        iserv-proxy = ./.plan.nix/iserv-proxy.nix;
        };
      };
  modules = [
    ({ lib, ... }:
      {
        packages = {
          "bytestring" = {
            flags = { "integer-simple" = lib.mkOverride 900 false; };
            };
          "iserv" = { flags = {}; };
          "ghci" = { flags = { "ghci" = lib.mkOverride 900 true; }; };
          "remote-iserv" = { flags = {}; };
          "ghc-boot" = { flags = {}; };
          "ghc" = {
            flags = {
              "dynamic-system-linker" = lib.mkOverride 900 true;
              "ghci" = lib.mkOverride 900 true;
              "stage3" = lib.mkOverride 900 false;
              "stage2" = lib.mkOverride 900 false;
              "terminfo" = lib.mkOverride 900 true;
              "stage1" = lib.mkOverride 900 false;
              };
            };
          "libiserv" = { flags = { "network" = lib.mkOverride 900 true; }; };
          "hpc" = { flags = {}; };
          "iserv-proxy" = { flags = {}; };
          };
        })
    ];
  }