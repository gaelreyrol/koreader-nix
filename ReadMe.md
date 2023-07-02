# koreader-nix

This repository allows to automatically install KOReader & KFMon with a one liner command on your ebook reader.

## Usage

1. Please checks any important changes [here](https://github.com/koreader/koreader/wiki/Installation-on-Kobo-devices).
2. Make sure your ebook is plugged in.
3. Update KOReader first and then KFMon if you need to.

The installer relies on the [semi-automated installation](https://github.com/koreader/koreader/wiki/Installation-on-Kobo-devices#semi-automated-installation-method) method.

```bash
nix run github:gaelreyrol/koreader-nix
```

Et voilà!

## Versions

You can check the file [default.nix](./default.nix) to see what versions are installed. Feel free to submit a pull request if new versions are available.