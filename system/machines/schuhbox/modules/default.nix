{ config, ... }:

{
  module = {
    boot.enable       = true;
    network.enable    = true;
    users.enable      = true;
    timedate.enable   = true;
  }

  security = {
    enable            = true;
    enableBootOptions = true;
  };

}
