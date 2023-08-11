{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    ghc
    cabal-install
    cabal2nix
    zlib
    haskellPackages.haskell-language-server
  ];
}
