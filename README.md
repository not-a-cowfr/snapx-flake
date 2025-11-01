# SnapX flake

Nix flake for the [SnapX] project

> [!WARNING]
>
> doesnt work, I get this error when running `snapx` or `snapx-ui`
>
> ```
> You must install .NET to run this application.
>
> App: /nix/store/7sj3xb8v0jf0816w0yv20lkm19yp0yd8-SnapX-latest/bin/snapx-ui
> Architecture: x64
> App host version: 9.0.10
> .NET location: Not found
>
> Learn more:
> https://aka.ms/dotnet/app-launch-failed
>
> Download the .NET runtime:
> https://aka.ms/dotnet-core-applaunch?missing_runtime=true&arch=x64&rid=linux-x64&os=nixos.25.11&apphost_version=9.0.10
> Failed to resolve libhostfxr.so [not found]. Error code: 0x80008083
> ```

## Usage

```nix
# flake.nix
{
	# ...
	inputs = {
	    snapx.url = "github:not-a-cowfr/snapx-flake";
	};
	# ...
}
```

```nix
# home.nix
{
  # ...
  imports = [
    inputs.snapx.homeModules.snapx
  ];

  programs.snapx.enable = true;
  # ...
}
```

## Contributing

[nushell] script to catch nuget-related build errors and add them to the deps

```nu
use std/clip
nix build .#packages.x86_64-linux.snapx
	| complete
	| get stderr
	| parse --regex ".*Unable to find package (?<name>\\S*)\\..*"
	| get name
	| uniq
	| each { $"dotnet add package ($in)" }
	| str join "\n"
	| save -a deps.sh
```

then run the update script

```sh
./update.sh
```

[snapx]: https://github.com/SnapXL/SnapX
[nushell]: https://github.com/nushell/nushell
