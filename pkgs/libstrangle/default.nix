{ fetchFromGitLab, makeWrapper, multiStdenv, stdenv }:
multiStdenv.mkDerivation rec {
  pname = "libstrangle";
  version = "0.0.4";
  src = fetchFromGitLab {
    owner = "torkel104";
    repo = "libstrangle";
    rev = "0.0.4";
    sha256 = "052r1z8rpzmjrcskj2bfqa1iwnq6j72li04pq4qf1wqm1p47qn9d";
  };
  buildInputs = [ makeWrapper ];
  patchPhase = ''
    sed -i s/ldconfig/true/ makefile
  '';
  installPhase = ''
    install -m 0755 -D -T src/strangle.sh $out/bin/strangle

    # Upstream uses /etc/ld.so.conf.d, we use LD_LIBRARY_PATH with Rpath token expansion instead.
    install -m 0755 -D -T build/libstrangle32.so $out/lib/i686/libstrangle.so
    install -m 0755 -D -T build/libstrangle64.so $out/lib/x86_64/libstrangle.so
    wrapProgram $out/bin/strangle --prefix LD_LIBRARY_PATH : "$out/lib/\$PLATFORM"
  '';
  meta = {
    description = "Frame rate limiter for Linux/OpenGL";
    homepage = "https://gitlab.com/torkel104/libstrangle";
    license = stdenv.lib.licenses.gpl3;
    maintainers = [ stdenv.lib.maintainers.xzfc ];
    platforms = [ "x86_64-linux" ];
  };
}
