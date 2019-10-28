{ fetchFromGitHub, stdenv, openssl, zlib }:
stdenv.mkDerivation rec {
  pname = "wrk2";
  version = "4.0.0-2018-03-03";
  src = fetchFromGitHub {
    owner = "giltene";
    repo = "wrk2";
    rev = "e0109df5b9de09251adb5f5848f223fbee2aa9f5";
    sha256 = "1aqdwmgdd74wq73f1zp28yqj91gd6p6nf9nbdfibl7mlklbzvak8";
  };
  buildInputs = [ openssl zlib ];
  installPhase = ''
    install -D wrk $out/bin/wrk2
  '';
  meta = {
    description =
      "A constant throughput, correct latency recording variant of wrk";
    homepage = "https://github.com/giltene/wrk2";
    license = stdenv.lib.licenses.apache2;
    maintainers = [ stdenv.lib.maintainers.xzfc ];
    platforms = [ "x86_64-linux" ];
  };
}
