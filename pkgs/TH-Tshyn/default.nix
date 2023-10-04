{ lib, stdenvNoCC, fetchurl, p7zip }:

stdenvNoCC.mkDerivation rec {
  pname = "TH-Tshyn";
  version = "4.1.0";

  src = fetchurl {
    # Use the 'ttc' files here for a smaller closure size.
    # (Using 'ttf' files gives a closure size about 15x larger, as of November 2021.)
    url = "http://home.26hz.com.cn:28080/tarball/${pname}-${version}.7z";
    hash = "sha256-vISzHiYTmlKYQkXawGwYNZVzTIJzXS2QOvS4E639yBg=";
  };

  sourceRoot = ".";

  nativeBuildInputs = [ p7zip ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts/TH-Tshyn
    mv *.ttf $out/share/fonts/TH-Tshyn

    runHook postInstall
  '';

  meta = with lib; {
    description = "All fontsets in Unicode15.1";
    homepage = "http://cheonhyeong.com";
    license = licenses.ofl;
    maintainers = with maintainers; [ Hertz ];
    platforms = platforms.all;
  };
}
