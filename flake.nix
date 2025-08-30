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
        
        # Source in current directory.
        src = ./.;
        nativeBuildInputs = [ pkgs.zig_0_15 ];

        buildPhase = ''
            echo "--- Start build phase"

            zig build -Doptimize=ReleaseFast --global-cache-dir $TMPDIR/zig-cache
            
            echo "--- End build phase"
        '';

        installPhase = ''
            echo "--- Start install phase"

            mkdir -p $out/bin
            cp zig-out/bin/fileinfo $out/bin/
            
            echo "--- End install phase"
        '';
    };
  };
}
