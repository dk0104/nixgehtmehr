_:

{
  programs.fuse.userAllowOther = true;

  environment.persistence = {
    "/persist" = {
      hideMounts = true;

      directories = [
        "/etc/nixos"
        "/etc/NetworkManager/system-connections"
        "/etc/wireguard"
        "/etc/secureboot"
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/log"
        "/var/lib/docker"
        "/var/lib/netbird"
        "/var/lib/containers"
        "/var/lib/qemu"
        "/var/lib/private"
        "/var/db"
        "/var/lib/NetworkManager"
        "/var/lib/chrony"
        "/var/lib/iwd"
        "/var/lib/libvirt"
        "/var/lib/systemd"
      ];

      files = [
        "/etc/machine-id"
      ];
    };
  };
}
