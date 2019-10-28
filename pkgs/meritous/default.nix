{ SDL, SDL_image, SDL_mixer, fetchFromGitLab, fetchurl, gettext, intltool
, stdenv, zlib, enableMusic ? false }:

let
  orig-src = fetchurl {
    url = "http://www.asceai.net/files/meritous_v12_src.tar.bz2";
    sha256 = "07apyzg1ygwlb1kw4qfs8yncpnn9v7wj8jnfs17w046881i0ici0";
  };

in stdenv.mkDerivation rec {
  pname = "meritous";
  version = "1.5";

  src = fetchFromGitLab {
    owner = "meritous";
    repo = "meritous";
    rev = "v${version}";
    sha256 = "0n5jm4g0arjllgqmd2crv8h02i6hs3hlh1zyc7ng7yfpg1mbd8p8";
  };

  patches = [ ./fix-audio.patch ];

  # FIXME: this doesn't work anyway for some reason
  postUnpack = stdenv.lib.optionalString enableMusic ''
    tar xf ${orig-src} --strip-components=3 -C source/dat/m/ meritous_v12_src/dat/m/
    n=0
    for i in ICEFRONT.S3M cavern.xm cave.xm cave06.s3m Wood.s3m \
             iller_knarkloader_final.xm fear2.mod Cv_boss.mod Fr_boss.mod \
             CT_BOSS.MOD rpg_bat1.xm amblight.xm FINALBAT.s3m; do
      ext=''${i#*.}
      mv source/dat/m/$i source/dat/m/track$((n++)).''${ext,,}
    done
    rm source/dat/m/README-music.txt
  '';

  buildInputs = [ SDL SDL_image SDL_mixer gettext intltool zlib ];

  buildPhase = "make prefix=$out";

  installPhase = "make prefix=$out install";

  meta = {
    description = "action-adventure dungeon crawl game";
    homepage = "https://gitlab.com/meritous/meritous";
    license = with stdenv.lib.licenses;
      if enableMusic then unfree else gpl3Plus;
    maintainers = [ stdenv.lib.maintainers.xzfc ];
    platforms = stdenv.lib.platforms.all;
  };
}
