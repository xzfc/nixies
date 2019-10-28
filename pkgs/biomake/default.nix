{ stdenv, fetchFromGitHub, swiProlog, which, makeWrapper, perl }:
stdenv.mkDerivation rec {
  pname = "biomake";
  version = "0.1.5";

  src = fetchFromGitHub {
    owner = "evoldoers";
    repo = "biomake";
    rev = "v${version}";
    sha256 = "0i3bk08m75q7ma12ibawk7jjr5ljb90jmmja92psf83j0552mnk6";
  };

  buildInputs = [ makeWrapper ]
    ++ stdenv.lib.optionals doCheck [ which swiProlog perl ];

  dontBuild = true;

  # Tests are flaky, they fail *sometimes* inside nix-build. TODO: investigate.
  doCheck = false;

  patchPhase = "patchShebangs .";

  installPhase = ''
    mkdir -p $out/bin
    make prefix=$out install
    wrapProgram $out/bin/biomake --prefix PATH : "${swiProlog}/bin"
  '';

  checkPhase = "./bin/biomake test";

  meta = {
    description =
      "GNU-Make-like utility for managing builds and complex workflows";
    homepage = "https://github.com/evoldoers/biomake";
    license = stdenv.lib.licenses.bsd3;
    maintainers = [ stdenv.lib.maintainers.xzfc ];
    platforms = stdenv.lib.platforms.all;
  };
}
