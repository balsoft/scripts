{ pkgs, theme, secret, ... }:
{
    polybar = import ./polybar { pkgs, secret, theme };
    zshrc = builtins.readFile (pkgs.stdenv.mkDerivation rec {
        name = "zshrc-extra.sh";
        src = ./zshrc.sh;
        buildInputs = with pkgs; [ libnotify xorg.xprop ];
        installPhase = "cp $src $out";
    };)
}