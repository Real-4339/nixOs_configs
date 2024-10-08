{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/vdb"; 
        content = {
          type = "gpt"; # Using GPT partitioning scheme
          partitions = {
            ESP = { 
              size = "256M";
              type = "EF00"; # EFI System Partition for UEFI boot
              content = {
                type = "filesystem";
                format = "vfat"; # FAT32 filesystem for EFI
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ]; 
              };
            };
	    swap = {  # Dedicated swap partition
              size = "20G"; # Changed from 8 to 20 (just in case)
              content = {
                type = "swap";
                resumeDevice = true;
              };
            };
            luks = {
              size = "100%"; # Use the rest of the disk for LUKS
              content = {
                type = "luks"; 
                name = "crypted"; # Name of the LUKS container
                extraOpenArgs = [ ]; 
                settings = {
                  keyFile = "/tmp/secret.key"; # Path to your encryption key
                  allowDiscards = true; # Improves performance, but may reduce security slightly 
                };
                additionalKeyFiles = [ "/tmp/additionalSecret.key" ]; # Add more keys if needed
                content = {
                  type = "lvm_pv"; # This is where LVM comes in
                  vg = "pool";    # Assigning this LUKS container to the "pool" volume group
                };
              };
            };
          };
        };
      };
    };
    lvm_vg = {
      pool = {                # Defining the "pool" volume group
        type = "lvm_vg";
        lvs = {             # Defining logical volumes within the "pool" VG
          root = {
            size = "50G";   # Size of the root LV
            content = {
              type = "filesystem";
              format = "btrfs";
              mountpoint = "/"; 
              mountOptions = [ "defaults" ];
            };
          };
          home = {          # Home directory LV
            size = "40G"; 
            content = {
              type = "filesystem";
              format = "btrfs";
              mountpoint = "/home";
            };
          };
        };
      };
    };
  };
}
