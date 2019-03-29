{ buildPythonPackage
, pkgconfig
, sentencepiece
}:

buildPythonPackage rec {
  pname = "sentencepiece-python";
  version = sentencepiece.version;

  src = sentencepiece.src;

  nativeBuildInputs = [
    pkgconfig
  ];

  propagatedBuildInputs = [
    sentencepiece
  ];

  sourceRoot = "source/python";

  doCheck = false;

  meta = {
    description = sentencepiece.meta.description;
    homepage = sentencepiece.meta.homepage;
    license = sentencepiece.meta.license;
  };
}
