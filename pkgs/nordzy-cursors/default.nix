{ lib, stdenv, fetchzip, ... }:
stdenv.mkDerivation rec {
  pname = "nordzy-cursors";
  version = "v0.6.0";
  src = fetchzip {
    url =
      "https://github.com/alvatip/Nordzy-cursors/archive/refs/tags/v0.6.0.zip";
    sha256 = "sha256-q9PEEyxejRQ8UCwbqsfOCL7M70pLCOLyCx8gEFmZkWA=";
  };
  installPhase = ''
    mkdir -p $out/share/icons
    cp -va Nordzy-cursors $out/share/icons/
    cp -va Nordzy-cursors-lefthand $out/share/icons/
    cp -va Nordzy-cursors-white $out/share/icons/
  '';
  meta = {
    description = "Cursor theme using the Nord color";
    homepage = "https://github.com/alvatip/Nordzy-cursors";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.unix;
    maintainers = [ lib.maintainers.Hertz ];
  };
}
