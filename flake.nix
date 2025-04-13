{
  description = "A bare-bones Nix flake development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      forEachSystem = nixpkgs.lib.genAttrs [
        "aarch64-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
    in
    {
      # Define the development shell environment
      devShells = forEachSystem (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              elmPackages.elm-review
              elmPackages.lamdera
              nodejs_23
              elmPackages.elm-language-server
              elmPackages.elm-format
            ];
            shellHook = ''
              npm install
            '';
          };
        }
      );
    };
}
