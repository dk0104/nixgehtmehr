_:

{
  systemd.network = {
    enable = true;
  };

   networking = {
    useDHCP = lib.mkDefault true;
    hostId = "78c1c644";
  };
}
