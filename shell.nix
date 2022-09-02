let
  pkgs = import <nixpkgs> {};
in
  with pkgs;
    mkShell.override {
      stdenv = stdenvNoCC;
    } {
      packages = [
        debootstrap
        dpkg
        arch-install-scripts
      ];
    }
