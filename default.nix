{ pkgs, ... }:

let 
  koreader = pkgs.fetchurl {
    url = "https://storage.gra.cloud.ovh.net/v1/AUTH_2ac4bfee353948ec8ea7fd1710574097/kfmon-pub/OCP-KOReader-v2023.06.zip";
    hash = pkgs.lib.fakeHash;
  };
  kfmon = pkgs.fetchurl {
    url = "https://storage.gra.cloud.ovh.net/v1/AUTH_2ac4bfee353948ec8ea7fd1710574097/kfmon-pub/OCP-KFMon-1.4.6-19-g490e0bb.zip";
    hash = pkgs.lib.fakeHash;
  };
in pkgs.stdenv.mkDerivation (finalAttrs: {
  pname = "koreader-installer";
  version = "2023.06";

  src = pkgs.fetchzip {
    url = "https://storage.gra.cloud.ovh.net/v1/AUTH_2ac4bfee353948ec8ea7fd1710574097/kfmon-pub/kfm_nix_install.zip";
    hash = pkgs.lib.fakeHash;
  };

  dontConfigure = true;
  dontBuild = true;

  buildInputs = [ kfmon ];

  installPhase = ''
    runHook preInstall

    cp -a . $out
    cp ${koreader} ${kfmon} $out

    runHook postInstall
  '';

  meta = with pkgs.lib; {
    description = "An ebook reader application supporting PDF, DjVu, EPUB, FB2 and many more formats, running on Cervantes, Kindle, Kobo, PocketBook and Android devices";
    homepage = "http://koreader.rocks/";
    changelog = "https://github.com/koreader/koreader/releases/tag/v${finalAttrs.version}";
    platforms = platforms.linux;
    license = licenses.agpl3;
    maintainers = with maintainers [ gaelreyrol ];
  };
})