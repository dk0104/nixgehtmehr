_:

{
  boot.initrd.luks.devices."enc".device = "/dev/disk/by-uuid/3133d4d4-ba2b-4b19-bd01-4ed695386517";

  # For impermanence
  boot.initrd.systemd.services.rollback = {
    description = "Rollback BTRFS root subvolume to a pristine state";
    unitConfig.DefaultDependencies = "no";
    serviceConfig.Type = "oneshot";
    wantedBy = [ "initrd.target" ];
    after = [ "systemd-cryptsetup@crypted.service" ];
    before = [ "sysroot.mount" ];

    script = ''
      mkdir /mnt
      mount -t btrfs /dev/mapper/enc /mnt 
      btrfs subvolume delete /mnt/root
      btrfs subvolume snapshot /mnt/root-blank/ mnt/root
    '';
  };

 fileSystems."/" =
    { device = "/dev/disk/by-uuid/826bd990-1e2a-424d-a579-ea69e95048a8";
      fsType = "btrfs";
      options = [ "subvol=root" 
        "rw"
        "noatime"
        "ssd"
        "compress=zstd"
       ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/826bd990-1e2a-424d-a579-ea69e95048a8";
      fsType = "btrfs";
      options = [ "subvol=home"
        "rw"
        "noatime"
        "compress=zstd"
        "ssd"
        ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/826bd990-1e2a-424d-a579-ea69e95048a8";
      fsType = "btrfs";
      options = [ "subvol=nix" 
        "rw"
        "noatime"
        "ssd"
        "compress=zstd"
      ];
    };

  fileSystems."/persist" =
    { device = "/dev/disk/by-uuid/826bd990-1e2a-424d-a579-ea69e95048a8";
      fsType = "btrfs";
      options = [ "subvol=persist" 
        "rw"
        "noatime"
        "ssd"
        "compress=zstd"
      ];
      neededForBoot = true;
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/49B3-D875";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };
}
