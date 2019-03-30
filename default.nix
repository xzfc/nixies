{ pkgs ? import <nixpkgs> {} }:
rec {
  drake-clj     = pkgs.callPackage ./pkgs/drake-clj     {};
  libstrangle   = pkgs.callPackage ./pkgs/libstrangle   {};
  pgquarrel     = pkgs.callPackage ./pkgs/pgquarrel     {};
  powder        = pkgs.callPackage ./pkgs/powder        {};
  sentencepiece = pkgs.callPackage ./pkgs/sentencepiece {};
  wrq2          = pkgs.callPackage ./pkgs/wrq2          {};
  xrandr        = pkgs.callPackage ./pkgs/xrandr        {};

  sentencepiece-python = p:
    pkgs.callPackage ./pkgs/sentencepiece/python.nix {
      inherit sentencepiece;
      inherit (p) buildPythonPackage;
    };

  # Debugging
  everything = pkgs.stdenv.mkDerivation {
    name = "xzfc-nix-everything";
    buildInputs = [
      drake-clj libstrangle pgquarrel powder sentencepiece wrq2 xrandr
      (pkgs.python37.withPackages (p:[
        (sentencepiece-python p)
      ]))
    ];
  };
}
