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
    url = "https://storage.gra.cloud.ovh.net/v1/AUTH_2ac4bfee353948ec8ea7fd1710574097/kfmon-pub/OCP-KOReader-v2023.10.zip";
    hash = "sha256-EcsAh453E9zZzm0dyzAEVT7LxV0naM3khEXKEgzC/GU=";
  };
  kfmon = fetchurl {
    url = "https://storage.gra.cloud.ovh.net/v1/AUTH_2ac4bfee353948ec8ea7fd1710574097/kfmon-pub/OCP-KFMon-1.4.6-39-g56612ad.zip";
    hash = "sha256-IuUco0dI1TiOOOMNvC6w1f7fYMNjFVayL8nJNYJthcI=";
  };
  plato = fetchurl {
    url = "https://storage.gra.cloud.ovh.net/v1/AUTH_2ac4bfee353948ec8ea7fd1710574097/kfmon-pub/OCP-Plato-0.9.39.zip";
    hash = "sha256-EjC1sETS44MPYa1TDb94QyDAullcbbOfLyhkh9XIFfg=";
  };
  koreader-plato = fetchurl {
    url = "https://storage.gra.cloud.ovh.net/v1/AUTH_2ac4bfee353948ec8ea7fd1710574097/kfmon-pub/OCP-Plato-0.9.39_KOReader-v2023.10.zip";
    hash = "sha256-N4jh167/eflH6jHRSC28r/PzyMkribiJojH+57fO3+w=";
  };
in
stdenv.mkDerivation (finalAttrs: {
  pname = "kobo-installer";
  version = "3.0.0";

  src = fetchzip {
    url = "https://storage.gra.cloud.ovh.net/v1/AUTH_2ac4bfee353948ec8ea7fd1710574097/kfmon-pub/kfm_nix_install.zip";
    hash = "sha256-5z7EyN0/gKzAQ0u8UKA/YOOea5NQRcGKOudsniw1P+A=";
  };

  dontConfigure = true;
  dontBuild = true;

  buildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mv install.sh $out/bin/kobo-installer
    wrapProgram "$out/bin/kobo-installer" \
      --prefix PATH ":" "${lib.makeBinPath [ unzip util-linux ]}"
    ln -s ${koreader} $out/OCP-KOReader-v${finalAttrs.version}.zip
    ln -s ${kfmon} $out/OCP-KFMon-${finalAttrs.version}.zip
    ln -s ${plato} $out/OCP-Plato-${finalAttrs.version}.zip
    ln -s ${koreader-plato} $out/OCP-Plato-${finalAttrs.version}_KOReader-v${finalAttrs.version}.zip

    runHook postInstall
  '';

  passthru.archives = {
    inherit koreader kfmon plato koreader-plato;
  };

  meta = with lib; {
    description = "Install KOReader on your favorite ebook reader with Nix";
    homepage = "https://github.com/gaelreyrol/koreader-nix";
    changelog = "https://github.com/gaelreyrol/koreader-nix/releases/tag/v${finalAttrs.version}";
    platforms = platforms.linux;
    license = licenses.gpl3;
    maintainers = with maintainers; [ gaelreyrol ];
    mainProgram = "kobo-installer";
  };
})
