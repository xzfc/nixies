{ stdenv, pkgconfig, fetchurl, libX11, xorgproto, libXrandr, libXrender,
  fetchFromGitLab, autoconf, automake }:

let xorg-macros = stdenv.mkDerivation {
  name = "xorg-util-macros";
  builder = ./builder.sh;
  preConfigure = "./autogen.sh";
  src = fetchFromGitLab {
    group = "xorg";
    owner = "util";
    repo = "macros";
    domain = "gitlab.freedesktop.org";
    rev = "334c9750017426a12b5018ec27201758c1b83a7f";
    sha256 = "1vlnlqhvayw9vhpfyks49q158zzbgzahf5axpnn6fap7k9gq237r";
  };
  buildInputs = [ autoconf automake ];
}; in

stdenv.mkDerivation {
  name = "xrandr-1.5.0-git";
  builder = ./builder.sh;
  preConfigure = "./autogen.sh";
  src = fetchFromGitLab {
    group = "xorg";
    owner = "app";
    repo = "xrandr";
    domain = "gitlab.freedesktop.org";
    rev = "3316ccaca35dc5fc6b6e3b5826e222cd648eb9c9";
    sha256 = "1r8rn29va6z4pxgkq4bfjj4bfvr14cswyy1sa7dxj17sz48180zq";
  };
  hardeningDisable = [ "bindnow" "relro" ];
  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ libX11 xorgproto libXrandr libXrender autoconf automake xorg-macros ];
  meta.platforms = stdenv.lib.platforms.unix;
}
