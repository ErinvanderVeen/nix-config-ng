{
  config,
  lib,
  ...
}: {
  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/48a94e72-c6b8-4af1-a05f-7cd421197f0a";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

  boot.initrd.luks.devices."luks-4dfbf947-3d83-4d0b-9269-c9c906014b26".device = "/dev/disk/by-uuid/4dfbf947-3d83-4d0b-9269-c9c906014b26";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/7C78-B809";
      fsType = "vfat";
    };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
