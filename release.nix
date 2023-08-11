{ mkDerivation, base, directory, fdo-notify, Glob, lib, process }:
mkDerivation {
  pname = "mailsync";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  enableSeparateDataOutput = true;
  executableHaskellDepends = [
    base directory fdo-notify Glob process
  ];
  license = lib.licenses.gpl3Plus;
  mainProgram = "mailsync";
}
