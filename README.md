# SnapX flake

Nix flake for the [SnapX] project

> [!WARNING]
>
> doesnt work, crashes when attempting to take a screenshot due to a missing lib

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
nix build .#packages.x86_64-linux.snapx
	| complete
	| get stderr
	| parse --regex ".*Unable to find package (?<name>[\\S\\.]*)\\..*"
	| get name
	| uniq
	| each { $"\ndotnet add package ($in)" }
	| save -a deps.sh
```

then run the update script

```sh
./update.sh
```

then test the build

```sh
nix build .#packages.<platform>.snapx
```

[snapx]: https://github.com/SnapXL/SnapX
[nushell]: https://github.com/nushell/nushell
