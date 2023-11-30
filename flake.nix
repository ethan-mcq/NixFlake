{
  description = "samtools";
  #nixConfig.bash-prompt = "\[nix-develop\]$ ";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
  packages.aarch64-darwin.default =
    let
    system = "aarch64-darwin";
    pkgs = nixpkgs.legacyPackages.${system};
    in pkgs.stdenv.mkDerivation {
      pname = "samtools";
      version = "1.18";
      src = pkgs.fetchurl {
        url = "https://github.com/samtools/samtools/releases/download/1.18/samtools-1.18.tar.bz2";
        sha256 = "d686ffa621023ba61822a2a50b70e85d0b18e79371de5adb07828519d3fc06e1";
      };

        nativeBuildInputs = [
          pkgs.zlib
          pkgs.bzip2
          pkgs.lzma
          pkgs.perl
          pkgs.ncurses
        ];

        doCheck = false;

        installPhase = ''
          make prefix=$out install
        '';

        meta = with nixpkgs.lib; {
          description = "Tools for reading/writing/editing/indexing/viewing SAM/BAM/CRAM format";
          license = licenses.free;
          homepage = "http://www.htslib.org";
          platforms = platforms.unix;
        };
      };
    };
}

