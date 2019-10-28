{ cmake, fetchFromGitHub, lib, mkDerivation, nodePackages, openssl, qscintilla
, qtdeclarative, qtmultimedia, qttools }:

mkDerivation rec {
  pname = "imgbrd-grabber";
  version = "7.1.1";

  src = fetchFromGitHub {
    owner = "Bionus";
    repo = "imgbrd-grabber";
    rev = "v${version}";
    sha256 = "00hv9l18rhx4wyjmdb2y6dx89wbq5ga4vb1r1p0xxqpc26724m13";
  };

  nativeBuildInputs = [ cmake ];

  preConfigure = ''
    # 
    sed -i 's/npm install/true/' CMakeLists.txt
    sed -i 's/npm run build/tsc -p tsconfig.json/' CMakeLists.txt

    # https://github.com/Bionus/imgbrd-grabber/wiki/Compilation#google-breakpad
    sed -i 's/USE_BREAKPAD 1/USE_BREAKPAD 0/' gui/CMakeLists.txt
  '';

  buildInputs = [
    qtdeclarative
    qtmultimedia
    qttools
    qscintilla
    openssl

    nodePackages.typescript
  ];

  meta = {
    description =
      "Very customizable imageboard/booru downloader with powerful filenaming features.";
    homepage = "https://github.com/Bionus/imgbrd-grabber";
    license = lib.licenses.asl20;
    maintainers = [ lib.maintainers.xzfc ];
    platforms = lib.platforms.all;
  };
}
