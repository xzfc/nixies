{ pkgs ? import <nixpkgs> {} }:
rec {
  biomake       = pkgs.callPackage ./pkgs/biomake       {};
  drake-clj     = pkgs.callPackage ./pkgs/drake-clj     {};
  libstrangle   = pkgs.callPackage ./pkgs/libstrangle   {};
  meritous      = pkgs.callPackage ./pkgs/meritous      {};
  pgquarrel     = pkgs.callPackage ./pkgs/pgquarrel     {};
  powder        = pkgs.callPackage ./pkgs/powder        {};
  sentencepiece = pkgs.callPackage ./pkgs/sentencepiece {};
  typometer     = pkgs.callPackage ./pkgs/typometer     {};
  wrk2          = pkgs.callPackage ./pkgs/wrk2          {};
  xrandr        = pkgs.callPackage ./pkgs/xrandr        {};

  imgbrd-grabber = pkgs.libsForQt5.callPackage ./pkgs/imgbrd-grabber {};

  sentencepiece-python = p:
    pkgs.callPackage ./pkgs/sentencepiece/python.nix {
      inherit sentencepiece;
      inherit (p) buildPythonPackage;
    };

  # Debugging
  everything = pkgs.stdenv.mkDerivation {
    name = "xzfc-nix-everything";
    buildInputs = [
      biomake drake-clj libstrangle meritous pgquarrel powder sentencepiece typometer wrk2 xrandr
      imgbrd-grabber
      (pkgs.python37.withPackages (p:[
        (sentencepiece-python p)
      ]))
    ];
  };
}
