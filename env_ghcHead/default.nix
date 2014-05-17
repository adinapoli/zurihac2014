let
  pkgs = import <nixpkgs> {};
  ghc = pkgs.ghc.ghcHEAD;
  hsEnv = pkgs.haskellPackages.ghcWithPackages (hsPkgs : ([
    hsPkgs.cabal
    hsPkgs.happy
    hsPkgs.alex
    hsPkgs.cabalInstall_1_20_0_1
    ]));

in pkgs.stdenv.mkDerivation rec {
  name = "zurihac2014_ghcHEAD";
  buildInputs = with pkgs; [
    binutils
    coreutils
    which
    haskellPackages.hlint
    ghc
    hsEnv
  ];
  shellHook = ''
    export GHC_NIX_ENV=1
    export PATH=$PATH:${builtins.getEnv "HOME"}/.cabal/bin
    export PATH=$PATH:${builtins.getEnv "PWD"}/.cabal-sandbox/bin
  '';
  extraCmds = ''
      export PATH=$PATH:${builtins.getEnv "HOME"}/.cabal/bin
      export PATH=$PATH:${builtins.getEnv "PWD"}/.cabal-sandbox/bin
      $(grep export ${hsEnv.outPath}/bin/ghc)
  '';
}
