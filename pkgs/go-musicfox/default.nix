{ lib
, fetchFromGitHub
, buildGoModule
, clangStdenv
, pkg-config
, alsa-lib
, flac
}:

# gcc only supports objc on darwin
buildGoModule.override { stdenv = clangStdenv; } rec {
  pname = "go-musicfox";
  version = "4.1.6";

  src = fetchFromGitHub {
    owner = "go-musicfox";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-ushJZKZPIUo6IO33E9A/CneLHHrE6MtdwpCYR4ivHmo=";
  };

  deleteVendor = true;

  vendorHash = null;

  subPackages = [ "cmd/musicfox.go" ];

  ldflags = [
    "-s"
    "-w"
    "-X github.com/go-musicfox/go-musicfox/pkg/constants.AppVersion=${version}"
  ];

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    alsa-lib
    flac
  ];

  meta = with lib; {
    description = "Terminal netease cloud music client written in Go";
    homepage = "https://github.com/go-musicfox/go-musicfox";
    license = licenses.mit;
    mainProgram = "musicfox";
    maintainers = with maintainers; [ zendo Ruixi-rebirth Hertz ];
  };
}
