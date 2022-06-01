{pkgs ? (builtins.getFlake "nixpkgs").legacyPackages.${builtins.currentSystem}}:
pkgs.mkShell {
  packages = [
    (pkgs.python3.withPackages (pP: []))
    pkgs.debootstrap
    pkgs.dpkg
    pkgs.arch-install-scripts
  ];
}
