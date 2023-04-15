{
  description = "A flake for proxmox support in NixOS";

  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";

  };

  outputs = { nixpkgs, ... }@inputs:
    let
      supported_plats = [ "x86_64-linux" ];
    in

    rec {

      packages = builtins.listToAttrs
        (builtins.map
          (plat: {
            name = plat;
            value =
              (builtins.listToAttrs (builtins.map
                (e: {
                  name = e;
                  value = supported_plats.${plat}.callPackage (./packages + "/${e}") { };
                })
                (builtins.attrNames (builtins.readDir ./packages))));
          })
          supported_plats);


      hydraJobs = packages.x86_64-linux;

    };
}


