{ stdenv, fetchFromGitLab, SDL, SDL_image, zlib, SDL_mixer, gettext, intltool }:
stdenv.mkDerivation rec {
  name = "meritous-${version}";
  version = "1.5";

  src = fetchFromGitLab {
    owner = "meritous";
    repo = "meritous";
    rev = "v${version}";
    sha256 = "0n5jm4g0arjllgqmd2crv8h02i6hs3hlh1zyc7ng7yfpg1mbd8p8";
  };
  # TODO: include music files from
  #       http://www.asceai.net/files/meritous_v12_src.tar.bz2

  patches = [ ./fix-audio.patch ];

  buildInputs = [ SDL SDL_image zlib SDL_mixer gettext intltool ];

  buildPhase = "make prefix=$out";

  installPhase = "make prefix=$out install";

  meta = {
    description = "action-adventure dungeon crawl game";
    homepage = https://gitlab.com/meritous/meritous;
    license = stdenv.lib.licenses.gpl3Plus;
    maintainers = [ stdenv.lib.maintainers.xzfc ];
    platforms = stdenv.lib.platforms.all;
  };
}
