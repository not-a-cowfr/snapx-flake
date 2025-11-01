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

buildDotnetModule rec {
  pname = "SnapX";
  version = "latest";
  dotnet-sdk = dotnetCorePackages.dotnet_9.sdk;

  src = fetchFromGitHub {
    owner = "SnapXL";
    repo = "SnapX";
    rev = "master";
    sha256 = "sha256-rLue0PRlnNisn14vKuA3fT8Cd6TPxbJvPaOrYgX9NEw=";
  };

  nugetDeps = ./deps.json;

  nativeBuildInputs = [
    gitMinimal
    ffmpeg_8-headless
    clang_multi
    zlib.dev
  ];

  projectFile = "SnapX.sln";

  dotnetFlags = [ "-p:Configuration=Release" ];
  useAppHost = false;
  dontDotnetFixup = true;
  enableParallelBuilding = true;

  dotnetInstallFlags = [
    "-p:TargetPlaform=unix-generic"
    "-p:CopyGenericLauncher=True"
    "-p:CopyCncDll=True"
    "-p:CopyD2kDll=True"
    "-p:UseAppHost=False"
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp -r ./SnapX.Avalonia/bin/Release/net9.0/* $out/bin/
    cp -r ./SnapX.CLI/bin/Release/net9.0/* $out/bin/
  '';

  meta = {
    description = "Screenshot tool that handles images, text, and video (fork of ShareX)";
    homepage = "https://github.com/SnapXL/SnapX";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ not-a-cowfr ];
    platforms = lib.platforms.all;
  };
}
