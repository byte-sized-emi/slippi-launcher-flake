# slippi-launcher flake

Simple flake for the slippi launcher (https://slippi.gg). Outputs a package, overlay, and NixOS module.

## Installation

### For NixOS configured with a flake:

Add the input:

```nix
inputs.slippi-launcher = {
  url = "github:byte-sized-emi/slippi-launcher-flake";
  inputs.nixpkgs.follows = "nixpkgs";
};
```

Import and enable the package:

```nix
# configuration.nix or other NixOS configuration
{ inputs, ... }:
{
  imports = [
    inputs.slippi-launcher.nixosModules.default
  ];
  
  programs.slippi-launcher = {
    enable = true;
    # enables AppImage binfmt support in NixOS.
    # Required because the launcher runs additional AppImages
    enableAppImageSupport = true;
  };
}
```
