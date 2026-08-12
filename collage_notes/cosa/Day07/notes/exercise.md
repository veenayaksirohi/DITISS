# mount a disk automatically using systemd unit

- attach a 10GB disk to your VM

```bash

# find the list of disks attached to the machine
> sudo lsblk

# partition the disk to create only one partition
# > sudo fdisk <device file for the disk>
> sudo fdisk /dev/nvme0n2

# confirm the partitions
> sudo lsblk

# format the partition
# > sudo mkfs.ext4 <partition>
> sudo mfks.ext4 /dev/nvme0n2p1
> sudo mkfs -t ext4 /dev/nvme0n2p1

# create a mount point
> sudo mkdir /mydisk

# mount the partition on the mount point
> sudo mount -t ext4 /dev/nvme0n2p1 /mydisk

# find all the mount points
> sudo findmnt

# unmount the disk
# > sudo umount <mount point>
> sudo umount /mydisk

# create a unit file named /etc/systemd/system/mydisk.mount
> vim /etc/systemd/system/mydisk.mount

[Unit]
Description=Automounting mydisk

[Mount]
What=/dev/nvme0n2p1
Where=/mydisk
Type=ext4

[Install]
WantedBy=multi-user.target

# attributes used in the configuration
> What -> the disk to be mounted
> Where -> the mount path
> Type -> file system
> WantedBy -> target

# check the status of the mount
> sudo systemctl status mydisk.mount

# start the mount unit
> sudo systemctl start mydisk.mount

# autostart the mount unit
> sudo systemctl enable mydisk.mount

# debug the problem
# > sudo journalctl -u <name>
> sudo journalctl -u mydisk

# confirm the device being mounted at the mount point
> sudo findmnt | grep mydisk

```
