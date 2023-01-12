{
  description = "louis.feuvrier.org website";

  inputs = rec {
    nixpkgs.url = "github:nixos/nixpkgs/release-22.05";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs: inputs.utils.lib.eachDefaultSystem (system: let
    pkgs = import inputs.nixpkgs { inherit system; };
    buildInputs = [
      pkgs.texlive.combined.scheme-full
      pkgs.zola
    ];

    resumeFileName = "louis_feuvrier-resume.pdf";
    resume = pkgs.stdenvNoCC.mkDerivation rec {
      inherit buildInputs;
      src = ./resume;
      name = "resume";
      buildPhase = "xelatex -output-directory=. resume.tex";
      installPhase = ''
        mkdir -p $out
        cp resume.pdf $out/${resumeFileName}
      '';
    };

    www = pkgs.stdenvNoCC.mkDerivation rec {
      inherit buildInputs;
      name = "www";
      src = ./www;

      phases = [ "unpackPhase" "buildPhase" "installPhase" ];
      buildPhase = "zola build --output-dir public";
      installPhase = ''
        cp -r public $out;
        cp ${resume}/${resumeFileName} $out/${resumeFileName};
      '';
    };
  in rec { # per-system output
    devShells.default = pkgs.mkShell { inherit buildInputs; };
    packages = rec {
      inherit resume www;
      default = www;
    };
  });
}
