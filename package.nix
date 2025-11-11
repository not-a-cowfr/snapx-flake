{
  lib,
  buildDotnetModule,
  fetchFromGitHub,
  dotnetCorePackages,
  ffmpeg_8-headless,
  clang_multi,
  gitMinimal,
  zlib,
  ...
}:
let
  dotnet = dotnetCorePackages.dotnet_9;
in
buildDotnetModule rec {
  pname = "SnapX";
  version = "latest";

  src = fetchFromGitHub {
    owner = "SnapXL";
    repo = "SnapX";
    rev = "df5e89f6d3e9714c0fdc43a57b0f40edc2e84bf2";
    sha256 = "sha256-1D562znJ4nkAuMSlGP3S4kAzlQ+Qti00n5SRdutwD/g=";
  };

  nugetDeps = ./deps.json;
  projectFile = "SnapX.Avalonia/SnapX.Avalonia.csproj";

  dotnet-sdk = dotnet.sdk;
  dotnet-runtime = dotnet.runtime;

  selfContainedBuild = true;
  useAppHost = true;
  enableParallelBuilding = true;

  nativeBuildInputs = [
    gitMinimal
    ffmpeg_8-headless
    clang_multi
    zlib.dev
  ];

  postInstall = ''
    # ln -s $out/bin/snapx-ui $out/bin/snapx
  '';

  meta = {
    description = "Screenshot tool that handles images, text, and video (fork of ShareX)";
    homepage = "https://github.com/SnapXL/SnapX";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ not-a-cowfr ];
    platforms = lib.platforms.all;
  };
}
