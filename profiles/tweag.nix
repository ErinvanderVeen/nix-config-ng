{...}: {
  nix.buildMachines = [
    {
      hostName = "build01.tweag.io";
      maxJobs = 24;
      sshUser = "nix";
      sshKey = "/root/.ssh/id-tweag-builder";
      system = "x86_64-linux";
      supportedFeatures = ["big-parallel" "kvm" "nixos-test"];
    }
    {
      hostName = "build02.tweag.io";
      maxJobs = 24;
      sshUser = "nix";
      sshKey = "/root/.ssh/id-tweag-builder";
      systems = ["aarch64-darwin" "x86_64-darwin"];
      supportedFeatures = ["big-parallel"];
    }
  ];

  nix.extraOptions = ''
    builders-use-substitutes = true
  '';
}
