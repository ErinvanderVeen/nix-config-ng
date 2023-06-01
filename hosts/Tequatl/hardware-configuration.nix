{
  config,
  lib,
  ...
}: {
  boot.initrd.availableKernelModules = ["xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/ba02ea46-1bbf-4423-beb2-5aa356cb0c7b";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-0601f987-72cb-4116-9819-acedb9733ddb".device = "/dev/disk/by-uuid/0601f987-72cb-4116-9819-acedb9733ddb";

  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-uuid/831E-43C8";
    fsType = "vfat";
  };

  swapDevices = [
    {
      device = "/swapfile";
      size = 16384;
    }
  ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
