let nixpkgs-src = builtins.fetchGit
    {
        url = "git@github.com:nixos/nixpkgs-channels";
        ref = "nixos-20.03";
        rev = "6a00eba02a38cd0f71367adc42857395a36ab4cd";
    };
    this-haskell-nix = import ./default.nix {};
    ghc-overlay = self: super:
    {
        evalPackages = super.evalPackages // {
            haskell-nix = super.evalPackages.haskell-nix // {
                compiler = super.evalPackages.haskell-nix.compiler // {
                    ghc883 = super.evalPackages.haskell-nix.compiler.ghc883.overrideAttrs (a:
                    {
                        postUnpack = ''
                            echo "some trivial change"
                        '';
                    });
                };
            };
        };
        haskell-nix = super.haskell-nix // {
            compiler = super.haskell-nix.compiler // {
                ghc883 = super.haskell-nix.compiler.ghc883.overrideAttrs (a:
                {
                    postUnpack = ''
                        echo "some trivial change"
                    '';
                });
            };
        };
    };
    nixpkgsWithoutGhcOverride = import nixpkgs-src
    {
        overlays = this-haskell-nix.overlays;
    };
    nixpkgsWithGhcOverride = import nixpkgs-src
    {
        overlays = this-haskell-nix.overlays ++ [ghc-overlay];
    };
    shellWithoutGhcOverride = nixpkgsWithoutGhcOverride.haskell-nix.snapshots."lts-16.3".shellFor
    {
        packages = _ : [];
        tools =
        {
            cabal = "3.2.0.0";
        };
    };
    shellWithGhcOverride = nixpkgsWithGhcOverride.haskell-nix.snapshots."lts-16.3".shellFor
    {
        packages = _ : [];
        tools =
        {
            cabal = "3.2.0.0";
        };
    };
in {
    inherit nixpkgsWithoutGhcOverride;
    inherit nixpkgsWithGhcOverride;
    inherit shellWithoutGhcOverride;
    inherit shellWithGhcOverride;
}
