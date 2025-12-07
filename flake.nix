{
  description = "A flake for setting up slippi / the slippi launcher on Nix(OS)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    {
      packages.x86_64-linux.default = import ./package.nix {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
      };
      overlays.default = final: prev: {
        slippi-launcher = self.packages.x86_64-linux.default;
      };
      nixosModules.default =
        {
          lib,
          config,
          pkgs,
          ...
        }:
        let
          cfg = config.programs.slippi-launcher;
        in
        {
          options.programs.slippi-launcher = {
            enable = lib.mkEnableOption "Enable Slippi Launcher";
            package = lib.mkOption {
              default = self.packages.x86_64-linux.default;
              type = lib.types.package;
              example = ''
                pkgs.slippi-launcher.overrideVersion
                  {
                    version = "v2.11.10";
                    hash = "sha256-...";
                  }
              '';
            };
            enableAppImageSupport = lib.mkEnableOption "Configure AppImage execution as required for slippi";
          };
          config = lib.mkIf cfg.enable {
            nixpkgs.overlays = [ self.overlays.default ];
            environment.systemPackages = [ cfg.package ];
            programs.appimage = lib.mkIf cfg.enableAppImageSupport {
              enable = true;
              binfmt = true;
              package = pkgs.appimage-run.override {
                extraPkgs =
                  pkgs: with pkgs; [
                    curl
                  ];
              };
            };
          };
        };
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;
    };
}
