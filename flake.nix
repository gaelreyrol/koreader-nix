{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  outputs = { self, nixpkgs }: let
    forSystems = function:
      nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
      ]
      (system: function {
        inherit system;
        pkgs = import nixpkgs {
          inherit system;
        };
      });
  in {
    packages = forSystems ({ pkgs, system }: {
      default = pkgs.callPackage ./default.nix { };
    });

    apps = forSystems ({ pkgs, system }: {
      default = {
        type = "app";
        program = "${self.packages.${system}.default}/koreader-installer";
      };
    });
  };
}
