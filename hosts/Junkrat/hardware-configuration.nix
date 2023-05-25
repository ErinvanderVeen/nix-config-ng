# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [];

  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/035275a1-a3c4-4400-a17f-8c62848824aa";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-b48eaefc-fc48-4eb8-bf03-24dc96dcb431".device = "/dev/disk/by-uuid/b48eaefc-fc48-4eb8-bf03-24dc96dcb431";

  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-uuid/5CF9-04F3";
    fsType = "vfat";
  };

  swapDevices = [
    {
      device = "/swapfile";
      size = 4096;
    }
  ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}