{
  description = "File Info Nix flake.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: 
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in 
  {
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        zig_0_15
        lldb
      ];

      shellHook = ''
      echo "Entering shell..."
      '';
    };
    
    # Building package - nix build
    packages.${system}.default = pkgs.stdenv.mkDerivation {
        pname = "filesz";
        version = "0.0.1";
        src = ./.;
        nativeBuildInputs = [ pkgs.zig_0_15 ];

        buildPhase = ''
            zig build -Doptimize=ReleaseFast --global-cache-dir $TMPDIR/zig-cache
        '';

        installPhase = ''
            mkdir -p $out/bin
            cp zig-out/bin/filesz $out/bin/
        '';
    };
  };
}
