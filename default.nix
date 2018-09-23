{ nixpkgs ? <nixpkgs> }:
let
  pkgs = import nixpkgs {
    config = {};
    overlays = [
      (import ./overlay.nix)
      (import ./demo7/overlays/overlay.nix)
    ];
  };

in pkgs.gnuradio-iio
