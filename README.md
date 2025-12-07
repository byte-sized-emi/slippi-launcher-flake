# slippi-launcher flake

Simple flake for the slippi-launcher. Outputs a package, overlay, and NixOS module.

For the NixOS module, simple import it and enable `programs.slippi-launcher.enable = true`. Note that slippi itself launches AppImages, which on NixOS need some configuration to be run - if you don't want to do this yourself you can just enable `programs.slippi-launcher.enableAppImageSupport = true`.
