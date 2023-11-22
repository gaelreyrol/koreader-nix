# koreader-nix

[![.github/workflows/ci.yml](https://github.com/gaelreyrol/koreader-nix/actions/workflows/ci.yml/badge.svg)](https://github.com/gaelreyrol/koreader-nix/actions/workflows/ci.yml)
[![flakestry.dev](https://flakestry.dev/api/badge/flake/github/gaelreyrol/koreader-nix)](https://flakestry.dev/flake/github/gaelreyrol/koreader-nix)
[![FlakeHub](https://img.shields.io/endpoint?url=https://flakehub.com/f/gaelreyrol/koreader-nix/badge)](https://flakehub.com/flake/gaelreyrol/koreader-nix)

[![koreader release](https://img.shields.io/github/v/release/koreader/koreader?label=koreader)
](https://github.com/koreader/koreader/releases)
[![kfmon release](https://img.shields.io/github/v/tag/NiLuJe/kfmon?label=kfmon)
](https://github.com/NiLuJe/kfmon/tags)
[![plato release](https://img.shields.io/github/v/release/baskerville/plato?label=plato)
](https://github.com/baskerville/plato/releases)

This repository allows you to automatically install KOReader, KFMon and Plato on your ebook reader with a one liner command.

## Supported devices

- Kobo

To support new devices, feel free to contribute!

## Usage

### Kobo

1. Please check any important changes [here](https://github.com/koreader/koreader/wiki/Installation-on-Kobo-devices).
2. Make sure your ebook is plugged in.
3. On the selection menu, update KOReader first.
4. Re-run the command to update other dependencies.

The installer relies on the [semi-automated installation](https://github.com/koreader/koreader/wiki/Installation-on-Kobo-devices#semi-automated-installation-method) method.

```bash
nix run github:gaelreyrol/koreader-nix#kobo-installer
```

Et voilà!

#### Versions

You can check the source file [kobo.nix](installers/kobo.nix) to see what versions are installed. Feel free to submit a pull request if new versions are available.
