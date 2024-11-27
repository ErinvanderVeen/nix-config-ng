{
  config,
  lib,
  ...
}:
{
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "thunderbolt"
    "nvme"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/0a7aeca9-01e9-4942-85c9-a052e807ba1b";
    fsType = "btrfs";
    options = [ "subvol=@" ];
  };

  boot.initrd.luks.devices."luks-f8b5516e-0be9-4327-b6ca-fde211b4c25b".device = "/dev/disk/by-uuid/f8b5516e-0be9-4327-b6ca-fde211b4c25b";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/F906-A32F";
    fsType = "vfat";
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
