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
    url = "https://storage.gra.cloud.ovh.net/v1/AUTH_2ac4bfee353948ec8ea7fd1710574097/kfmon-pub/OCP-KOReader-v2025.10.zip";
    hash = "sha256-KFhMA3tFQIC9Uzrj3cI5H4WR6urodjy7fDZx1dKk6TY=";
  };
  kfmon = fetchurl {
    url = "https://storage.gra.cloud.ovh.net/v1/AUTH_2ac4bfee353948ec8ea7fd1710574097/kfmon-pub/OCP-KFMon-1.4.6-179-ge000d65.zip";
    hash = "sha256-SQqLA8q03ErPobGVxaI/AdfM/wTUgIrAOjZaPYsCkSU=";
  };
  plato = fetchurl {
    url = "https://storage.gra.cloud.ovh.net/v1/AUTH_2ac4bfee353948ec8ea7fd1710574097/kfmon-pub/OCP-Plato-0.9.44.zip";
    hash = "sha256-ypk+vqn+zQV3ma+WXV4mNXb7sCP7+nqfWcL/8K8U+Rs=";
  };
  koreader-plato = fetchurl {
    url = "https://storage.gra.cloud.ovh.net/v1/AUTH_2ac4bfee353948ec8ea7fd1710574097/kfmon-pub/OCP-Plato-0.9.44_KOReader-v2025.10.zip";
    hash = "sha256-A8cvmBaeDnINiaR01NQ+BnC632tvTAG5HhymzFrabZg=";
  };
in
stdenv.mkDerivation (finalAttrs: {
  pname = "kobo-installer";
  version = "4.0.1";

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
    ln -s ${koreader} $out/bin/OCP-KOReader-v${finalAttrs.version}.zip
    ln -s ${kfmon} $out/bin/OCP-KFMon-${finalAttrs.version}.zip
    ln -s ${plato} $out/bin/OCP-Plato-${finalAttrs.version}.zip
    ln -s ${koreader-plato} $out/bin/OCP-Plato-${finalAttrs.version}_KOReader-v${finalAttrs.version}.zip

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
