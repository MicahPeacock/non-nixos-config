{
  description = "Home Manager configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, hyprland, caelestia-shell, nixgl, ... }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    homeConfigurations = {
      # Gaming Desktop
      jupiter = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          caelestia-shell.homeManagerModules.default
          hyprland.homeManagerModules.default
          ./hosts/jupiter.nix
        ];
        extraSpecialArgs = { inherit nixgl; };
      };

      # Work Desktop
      minerva = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./hosts/minerva.nix ];
        extraSpecialArgs = { inherit nixgl; };
      };
    };
  };
}
