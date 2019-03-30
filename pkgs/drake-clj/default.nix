{ fetchurl, jre, makeWrapper, stdenv }:

stdenv.mkDerivation rec {
  name = "drake-clj-${version}";
  version = "1.0.3";

  src = fetchurl {
    url = "https://github.com/Factual/drake/releases/download/${version}/drake.jar";
    sha256 = "1bqnadjgi8h78aq2gwjcqcfg2pp0lkkywps2aw1g7dh0m44v3if9";
  };

  phases = [ "installPhase" ];

  buildInputs = [ jre makeWrapper ];

  installPhase = ''
    mkdir -p $out/libexec/drake
    cp $src $out/libexec/drake/drake.jar
    mkdir -p $out/bin
    makeWrapper ${jre}/bin/java $out/bin/drake --add-flags "-jar $out/libexec/drake/drake.jar"
  '';

  meta = with stdenv.lib; {
    description = ''Data workflow tool, like a "Make for data"'';
    homepage = https://github.com/Factual/drake;
    license = licenses.epl10;
    maintainers = [ maintainers.xzfc ];
    platforms = platforms.all;
  };
}
