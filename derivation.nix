{ stdenv, fetchFromGitHub, cmake, pkgconfig, boost, gnuradio, libiio, libad9361-iio
, makeWrapper, cppunit
, bison, flex, libxml2
, pythonSupport ? true, python, swig
}:

assert pythonSupport -> python != null && swig != null;

stdenv.mkDerivation rec {
  name = "gnuradio-iio-${version}";
  version = "0.0.1";

  src = ./.;

  nativeBuildInputs = [ bison flex pkgconfig ];
  buildInputs = [
    cmake boost libxml2 libiio libad9361-iio makeWrapper gnuradio cppunit
  ] ++ stdenv.lib.optionals pythonSupport [ python swig ];

  postInstall = ''
    for prog in "$out"/bin/*; do
        wrapProgram "$prog" --set PYTHONPATH $PYTHONPATH:$(toPythonPath "$out")
    done
  '';

  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    description = "GNURadio OOT for iio";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [ tomberek ];
  };
}
