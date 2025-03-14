{
  description = "Thorium using Nix Flake";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    {
      self,
      nixpkgs,
      ...
    }:
    {
      ##### x86_64-linux #####
      packages.x86_64-linux =
        let
          pkgs = import nixpkgs { system = "x86_64-linux"; };
        in
        {
          thorium-avx =
            let
              pkgs = import nixpkgs { system = "x86_64-linux"; };
              name = "thorium-avx";
              version = "M130.0.6723.174";
              src = pkgs.fetchurl {
                url = "https://github.com/Alex313031/thorium/releases/download/M130.0.6723.174/Thorium_Browser_130.0.6723.174_AVX.AppImage";
                sha256 = "sha256-23Vq+MDoV1ePkcVVy5SHWX6QovFUKxDdsgteWfG/i1U=";
              };
              appimageContents = pkgs.appimageTools.extractType2 { inherit name src; };
            in
            pkgs.appimageTools.wrapType2 {
              inherit name version src;
              extraInstallCommands = ''
                install -m 444 -D ${appimageContents}/thorium-browser.desktop $out/share/applications/thorium-browser.desktop
                install -m 444 -D ${appimageContents}/thorium.png $out/share/icons/hicolor/512x512/apps/thorium.png
                substituteInPlace $out/share/applications/thorium-browser.desktop \
                --replace 'Exec=AppRun --no-sandbox %U' 'Exec=${name} %U'
              '';
            };

          thorium-avx2 =
            let
              pkgs = import nixpkgs { system = "x86_64-linux"; };
              name = "thorium-avx2";
              version = "M130.0.6723.174";
              src = pkgs.fetchurl {
                url = "https://github.com/Alex313031/thorium/releases/download/M130.0.6723.174/Thorium_Browser_130.0.6723.174_AVX2.AppImage";
                sha256 = "sha256-HANrDUv/oFW2uWLSYilTCzdnZDY1yuqhLo/jRQil3QA=";
              };
              appimageContents = pkgs.appimageTools.extractType2 { inherit name src; };
            in
            pkgs.appimageTools.wrapType2 {
              inherit name version src;
              extraInstallCommands = ''
                install -m 444 -D ${appimageContents}/thorium-browser.desktop $out/share/applications/thorium-browser.desktop
                install -m 444 -D ${appimageContents}/thorium.png $out/share/icons/hicolor/512x512/apps/thorium.png
                substituteInPlace $out/share/applications/thorium-browser.desktop \
                --replace 'Exec=AppRun --no-sandbox %U' 'Exec=${name} %U'
              '';
            };

          thorium-sse3 =
            let
              pkgs = import nixpkgs { system = "x86_64-linux"; };
              name = "thorium-sse3";
              version = "122.0.6261.132 - 56";
              src = pkgs.fetchurl {
                url = "https://github.com/Alex313031/thorium/releases/download/M130.0.6723.174/Thorium_Browser_130.0.6723.174_SSE3.AppImage";
                sha256 = "sha256-G+Z85w7d7YT/03tqcH1VMJGoenoegcttbxz38u0JWcI=";
              };
              appimageContents = pkgs.appimageTools.extractType2 { inherit name src; };
            in
            pkgs.appimageTools.wrapType2 {
              inherit name version src;
              extraInstallCommands = ''
                install -m 444 -D ${appimageContents}/thorium-browser.desktop $out/share/applications/thorium-browser.desktop
                install -m 444 -D ${appimageContents}/thorium.png $out/share/icons/hicolor/512x512/apps/thorium.png
                substituteInPlace $out/share/applications/thorium-browser.desktop \
                --replace 'Exec=AppRun --no-sandbox %U' 'Exec=${name} %U'
              '';
            };

          # AVX is compatible with most CPUs
          default = self.packages.x86_64-linux.thorium-avx;
        };

      apps.x86_64-linux = {
        thorium-avx = {
          type = "app";
          program = "${self.packages.x86_64-linux.thorium-avx}/bin/thorium-avx";
        };

        thorium-avx2 = {
          type = "app";
          program = "${self.packages.x86_64-linux.thorium-avx2}/bin/thorium-avx2";
        };

        thorium-sse3 = {
          type = "app";
          program = "${self.packages.x86_64-linux.thorium-sse3}/bin/thorium-sse3";
        };

        default = self.apps.x86_64-linux.thorium-avx;
      };

    };
}
