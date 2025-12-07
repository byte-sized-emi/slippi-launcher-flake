{
  pkgs,
  version ? "v2.11.10",
  hash ? "sha256-OrWd0jVqe6CzNbVRNlm2alt2NZ8uBYeHiASaB74ouW4=",
}:
let
  versionNoPrefix = pkgs.lib.strings.removePrefix "v" version;
in
pkgs.appimageTools.wrapType2 {
  # or wrapType1
  inherit version;
  pname = "slippi-launcher";
  src = pkgs.fetchurl {
    inherit hash;
    url = "https://github.com/project-slippi/slippi-launcher/releases/download/${version}/Slippi-Launcher-${versionNoPrefix}-x86_64.AppImage";
  };
  meta = {
    description = "Slippi Launcher for online super smash bros melee";
    license = pkgs.lib.licenses.gpl3Only;
    homepage = "https://git.byte-sized.fyi/emilia/slippi-launcher-flake";
    platforms = pkgs.lib.platforms.linux;
  };
  passthru.overrideVersion = { version, hash }: import ./package.nix { inherit pkgs version hash; };
}
