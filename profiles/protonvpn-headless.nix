{ ... }:
{
  services.protonvpn = {
    enable = true;
    interface = {
      privateKeyFile = "/private/protonvpn_key";
    };
    peer = {
      publicKey = "sSbgwNAoZtBVWlg6ZLnFDrXTM3YFTpPVKgE4DtzSUw0=";
      endpoint = "146.70.170.2:51820";
    };
  };
}
