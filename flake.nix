{
  description = "sgith.dev website";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs@{ parts, ... }:
    parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      perSystem =
        { self', pkgs, ... }:
        let
          beamPackages = pkgs.beam_minimal.packages.erlang_27;
          erlang = beamPackages.erlang;
          elixir = beamPackages.elixir_1_17;
        in
        {
          devShells.default = pkgs.mkShell {
            buildInputs = with pkgs; [
              elixir
              nodejs_20

              # dev tools
              mix2nix
              node2nix
            ];

            env = {
              ERL_AFLAGS = "+pc unicode -kernel shell_history enabled";
              ELIXIR_ERL_OPTIONS = "+sssdio 128";
            };
          };
          packages = {
            default = self'.packages.sgiath-dev;
            sgiath-dev = pkgs.callPackage ./default.nix { inherit beamPackages erlang elixir; };
          };

          apps = {
            default = self'.apps.sgiath-dev;
            auth = {
              type = "app";
              program = "${self'.packages.sgiath-dev}/bin/sgiath-dev";
            };
          };
        };
    };
}
