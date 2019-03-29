{ stdenv, fetchurl, SDL }:
stdenv.mkDerivation rec {
  name = "powder-${version}";
  version = "118";
  src = fetchurl {
    url = "http://www.zincland.com/powder/release/powder${version}_src.tar.gz";
    sha256 = "1mzk338sz7g77k09pw6cb47lg60si76x2mrm83r1zpf7f8wjz0af";
  };
  buildInputs = [ SDL ];
  patchPhase = ''
    patchShebangs .
  '';
  buildPhase = ''
    CXXFLAGS="-O3 -std=gnu++98" ./buildall.sh --use-home-dir
  '';
  installPhase = ''
    mkdir -p $out/bin $out/share/doc/powder
    cp powder $out/bin
    cp README.TXT LICENSE.TXT CREDITS.TXT $out/share/doc/powder
  '';
  meta = with stdenv.lib; {
    description = "A graphical roguelike game";
    homepage = http://www.zincland.com/powder/index.php;
    license = licenses.unfreeRedistributable; # Creative Commons Sampling Plus
    maintainers = [ maintainers.xzfc ];
    platforms = platforms.linux;
  };
}
