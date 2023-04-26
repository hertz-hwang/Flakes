{ stdenv
, lib
, fetchurl
}:
stdenv.mkDerivation {
  pname = "fcitx5-pinyin-moegirl";
  version = "20230414";

  src = fetchurl {
    url = "https://github.com/outloudvi/mw2fcitx/releases/download/20230414/moegirl.dict";
    sha256 = "sha256-NaQbS/JlO1JbfLpM93KaYuwYVSwQkwrDL6WttgTKToM=";
  };

  dontUnpack = true;
  installPhase = ''
    install -Dm644 $src $out/share/fcitx5/pinyin/dictionaries/moegirl.dict
  '';
  meta = with lib; {
    description = "Fcitx 5 PinyinDictionary from zh.moegirl.org.cn ";
    homepage = "https://github.com/outloudvi/mw2fcitx";
    license = licenses.unlicense;
    maintainers = with maintainers; [ Ruixi-rebirth Hertz ];
  };
}
