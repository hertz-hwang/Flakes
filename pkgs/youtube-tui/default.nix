{ lib
, rustPlatform
, fetchFromGitHub
, pkg-config
, openssl
, xorg
, stdenv
, darwin
, python3
, libsixel
}:

rustPlatform.buildRustPackage rec {
  pname = "youtube-tui";
  version = "0.8.0";

  src = fetchFromGitHub {
    owner = "Siriusmart";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-gogV/+zo/Spg5d8Fh4gDTJL4ojdWbB6mDbppF0i+H20=";
  };

  cargoHash = "sha256-V6vSt4DGDN7Ohm9KMs9zFxTCOLXdDsk3dccJAUI+iJw=";

  nativeBuildInputs = [
    pkg-config
    python3
  ];

  buildInputs = [
    openssl
    xorg.libxcb
    libsixel
  ] ++ lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.CoreFoundation
    darwin.apple_sdk.frameworks.Security
  ];

  meta = with lib; {
    description = "An aesthetically pleasing YouTube TUI written in Rust";
    homepage = "https://github.com/Siriusmart/youtube-tui";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ Ruixi-rebirth Hertz ];
  };
}
