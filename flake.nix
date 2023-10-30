{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  outputs = { self, nixpkgs }:
    let
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
    in
    {
      packages = forSystems ({ pkgs, system }: import ./installers { inherit pkgs; });

      apps = forSystems ({ pkgs, system }: (pkgs.lib.mapAttrs'
        (name: value: pkgs.lib.nameValuePair (name + "-installer") ({
          type = "app";
          program = pkgs.lib.getExe value;
        })
        )
        self.packages.${system}));
    };
}
