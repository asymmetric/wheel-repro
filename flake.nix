{
  description = "wheel-repro";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    poetry2nix = {
      url = "github:nix-community/poetry2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, poetry2nix }:
    let
      name = "wheel-repro";
      system = "x86_64-linux";

      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      packages.${system} = {
        default = pkgs.poetry2nix.mkPoetryApplication {
          projectDir = ./.;
          python = pkgs.python39;
          overrides = pkgs.poetry2nix.overrides.withDefaults (
            final: prev: {
              panel = prev.panel.override { preferWheel = true; };
            }
          );
        };
      };
    };
}
