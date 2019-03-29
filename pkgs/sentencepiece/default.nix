{ fetchFromGitHub, stdenv, cmake, pkgconfig }:
stdenv.mkDerivation rec {
  name = "sentencepiece-${version}";
  version = "0.1.81";
  src = fetchFromGitHub {
    owner = "google";
    repo = "sentencepiece";
    rev = "635752e49220cfd188b4d0ddb76b692bc33e968d";
    sha256 = "1ygp95xcj7nmqg85sx4zm4ly0aqq4pzw6c6s5qn2gp49ljill1vd";
  };
  buildInputs = [ cmake pkgconfig ];
  meta = {
    description = "Unsupervised text tokenizer for Neural Network-based text generation.";
    homepage = https://github.com/google/sentencepiece;
    license = stdenv.lib.licenses.apache2;
    maintainers = [ stdenv.lib.maintainers.xzfc ];
    platforms = [ "x86_64-linux" ];
  };
}
