{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "nvme" "thunderbolt" "usb_storage" "sd_mod" "sdhci_pci" ];
      kernelModules = [ "dm-snapshot" ];

      luks.devices = {
        "luks-root".device = "/dev/disk/by-uuid/caece4bc-e550-49ee-8b22-ffd63ae9b25b";
        "luks-blockcahin".device = "/dev/disk/by-uuid/d96197d7-8aa3-40a8-af39-0568ee639875";
      };
    };

    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/mapper/sean_work-nixos";
      fsType = "ext4";
    };

    "/boot" = { device = "/dev/disk/by-uuid/BE79-5344";
      fsType = "vfat";
      options = [ "umask=0077" ];
    };

    "/home" = {
      device = "/dev/mapper/sean_work-home";
      fsType = "ext4";
    };

    "/blockchain" = {
      device = "/dev/mapper/luks-blockcahin";
      fsType = "ext4";
    };
  };

  swapDevices = [{
    device = "/dev/mapper/sean_work-swap";
  }];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
