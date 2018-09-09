{ pkgs, theme, secret, ... }:
{
    polybar = import ./polybar { inherit pkgs; inherit theme; inherit secret; };
    zshrc = builtins.readFile (pkgs.stdenv.mkDerivation rec {
        name = "zshrc-extra.sh";
        src = ./zshrc.sh;
        buildInputs = with pkgs; [ libnotify xorg.xprop ];
        unpackPhase = "";
        installPhase = "cp $src $out";
    });
}
