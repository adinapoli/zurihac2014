let
  pkgs = import <nixpkgs> {};
  ghc = pkgs.ghc.ghc782;
  hsEnv = pkgs.haskellPackages.ghcWithPackages (hsPkgs : ([
    hsPkgs.cabal
    hsPkgs.happy_1_19_3
    hsPkgs.alex_3_1_3
    hsPkgs.cabalInstall_1_20_0_1
    ]));

in pkgs.stdenv.mkDerivation rec {
  name = "zurihac2014_ghc782";
  buildInputs = with pkgs; [
    binutils
    git
    autoconf
    ack
    libtool
    automake
    coreutils
    which
    less
    perl
    python
    haskellPackages.hlint
    ghc
    hsEnv
  ];
  shellHook = ''
    export NIX_ENV=1
    alias e=/usr/local/bin/emacs
    alias vi=/usr/local/bin/vim
    alias ghci-dev="./inplace/bin/ghc-stage2 --interactive"
    alias ghc-dev=./inplace/bin/ghc-stage2
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
