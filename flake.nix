{
  description = "A flake for building Mailsync";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs;
  };

  outputs = { self, nixpkgs }:
  let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    system = "x86_64-linux";
  in {

    packages.${system}.mailsync = pkgs.haskellPackages.mkDerivation {
      pname = "mailsync";
      version = "0.1.0.1";
      src = ./.;
      isLibrary = false;
      isExecutable = true;
      enableSeparateDataOutput = true;
      executableHaskellDepends = with pkgs.haskellPackages; [
        base directory fdo-notify Glob process
      ];
      license = nixpkgs.lib.licenses.gpl3Plus;
      mainProgram = "mailsync";
    };

    devShell.${system} = pkgs.mkShell {
      buildInputs = with pkgs; [
        ghc
        cabal-install
        cabal2nix
        zlib
        haskellPackages.haskell-language-server
      ];
    };

  };
}
