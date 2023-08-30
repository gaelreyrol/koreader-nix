{ lib
, stdenv
, fetchurl
, fetchzip
, makeWrapper
, unzip
, util-linux
}:

let
  koreader = fetchurl {
    url = "https://storage.gra.cloud.ovh.net/v1/AUTH_2ac4bfee353948ec8ea7fd1710574097/kfmon-pub/OCP-KOReader-v2023.08.zip";
    hash = "sha256-f8oUHYzGoujgzxtURqcZSF5And1jTXRK8JHKyrMNxFM=";
  };
  kfmon = fetchurl {
    url = "https://storage.gra.cloud.ovh.net/v1/AUTH_2ac4bfee353948ec8ea7fd1710574097/kfmon-pub/OCP-KFMon-1.4.6-28-g32f4afc.zip";
    hash = "sha256-bVMTJqnhzole9SfobFkGBGRRWbXIhJbQeTfOB/J6HzA=";
  };
in stdenv.mkDerivation (finalAttrs: {
  pname = "koreader-installer";
  version = "2.0.0";

  src = fetchzip {
    url = "https://storage.gra.cloud.ovh.net/v1/AUTH_2ac4bfee353948ec8ea7fd1710574097/kfmon-pub/kfm_nix_install.zip";
    hash = "sha256-5z7EyN0/gKzAQ0u8UKA/YOOea5NQRcGKOudsniw1P+A=";
  };

  dontConfigure = true;
  dontBuild = true;

  buildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    mkdir $out
    mv install.sh $out/koreader-installer
    wrapProgram "$out/koreader-installer" \
      --prefix PATH ":" "${lib.makeBinPath [ unzip util-linux ]}"
    ln -s ${koreader} $out/OCP-KOReader-v${finalAttrs.version}.zip
    ln -s ${kfmon} $out/OCP-KFMon-${finalAttrs.version}.zip

    runHook postInstall
  '';

  meta = with lib; {
    description = "An ebook reader application supporting PDF, DjVu, EPUB, FB2 and many more formats, running on Cervantes, Kindle, Kobo, PocketBook and Android devices";
    homepage = "http://koreader.rocks/";
    changelog = "https://github.com/gaelreyrol/koreader-nix/releases/tag/v${finalAttrs.version}";
    platforms = platforms.linux;
    license = licenses.agpl3;
    maintainers = with maintainers; [ gaelreyrol ];
    mainProgram = "koreader-installer";
  };
})