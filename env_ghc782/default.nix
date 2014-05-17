let
  pkgs = import <nixpkgs> {};
  ghc = pkgs.ghc.ghc782;
  hsEnv = pkgs.haskellPackages.ghcWithPackages (hsPkgs : ([
    hsPkgs.cabal
    hsPkgs.happy
    hsPkgs.alex
    hsPkgs.cabalInstall_1_20_0_1
    ]));

in pkgs.stdenv.mkDerivation rec {
  name = "zurihac2014_ghc782";
  buildInputs = with pkgs; [
    binutils
    git
    coreutils
    which
    less
    haskellPackages.hlint
    ghc
    hsEnv
  ];
  shellHook = ''
    export NIX_ENV=1
    alias e=/usr/local/bin/emacs
    export PATH=$PATH:${builtins.getEnv "HOME"}/.cabal/bin
    export PATH=$PATH:./.cabal-sandbox/bin
  '';
  extraCmds = ''
      export NIX_ENV=1
      alias e=/usr/local/bin/emacs
      export PATH=$PATH:${builtins.getEnv "HOME"}/.cabal/bin
      export PATH=$PATH:./.cabal-sandbox/bin
      $(grep export ${hsEnv.outPath}/bin/ghc)
  '';
}
