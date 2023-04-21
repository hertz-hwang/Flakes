{ stdenv
, lib
, fetchFromGitHub
, rustPlatform
, pkg-config
, libxkbcommon
, lz4
,
}:
rustPlatform.buildRustPackage rec {
  pname = "swww";
  version = "0.7.3";

  src = fetchFromGitHub {
    owner = "Horus645";
    repo = "${pname}";
    rev = "v${version}";
    hash = "sha256-1SmCeIlcjOX3yCvpfqQ82uq4h2xlGhX9OCwKb6jGK78=";
  };

  cargoHash = "sha256-52uRogUcwR/NeuZC3g2m6f6A7HlxLmFn0sXxpsc+SpA=";

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ lz4 libxkbcommon ];

  doCheck = false;

  meta = with lib; {
    description = "A Solution to your Wayland Wallpaper Woes. ";
    homepage = "https://github.com/Horus645/${pname}";
    license = licenses.gpl3Only;
    platforms = [ "x86_64-linux" ];
    maintainers = with maintainers; [ Ruixi-rebirth Hertz ];
  };
}
