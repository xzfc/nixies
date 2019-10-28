{ fetchFromGitHub, fetchzip, jdk11, libX11, makeWrapper, stdenv }:
stdenv.mkDerivation rec {
  pname = "typometer";
  version = "1.0.1";

  src = fetchzip {
    url =
      "https://github.com/pavelfatin/typometer/releases/download/v${version}/typometer-${version}-bin.zip";
    sha256 = "1v7gjp2gyjda6z41lflrg0mkan347d32ixhhn1yvjqg24b7vxqgy";
  };

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin $out/share/java
    cp typometer-${version}.jar $out/share/java
    makeWrapper ${jdk11}/bin/java $out/bin/typometer \
      --add-flags "-jar $out/share/java/typometer-${version}.jar" \
      --prefix LD_LIBRARY_PATH : ${libX11}/lib
  '';

  meta = {
    description = "Text/code editor typing latency analyzer";
    homepage = "https://github.com/pavelfatin/typometer";
    license = stdenv.lib.licenses.asl20;
    maintainers = [ stdenv.lib.maintainers.xzfc ];
    platforms = stdenv.lib.platforms.all;
  };
}
