{ pkgs, secret, theme, ... }:
{
    weather = pkgs.stdenv.mkDerivation {
        name = "weather.sh";
        src = ./weather.sh;
        buildInputs = with pkgs; [ bash jq curl ];
        owm-key = secret.owm-key;
        city-id = "513378";
        units = "metric";
        symbol = "°";
        inherit theme;
        unpackPhase = "":
        installPhase = ''
            mkdir -p $out/bin $out/etc
            cp $src $out/bin
            chmod +x $out/bin/weather.sh
            cat << EOF > $out/etc/config
            KEY=${owm-key}
            CITY=${city-id}
            UNITS=${units}
            SYMBOL=${symbol}
            BG=${theme.bg}
            FG=${theme.fg}
            GREEN=${theme.green}
            RED=${theme.red}
            BLUE=${theme.blue}
            EOF
        '';
    };
}
