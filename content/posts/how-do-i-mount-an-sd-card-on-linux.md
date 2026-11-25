+++
title = "How do I mount an SD card on Linux"
date = '2026-11-25T12:39:22-03:00'
draft = false
+++

First insert the SD card in the SD card slot of your computer (of course!).

Use `sudo fdisk -l` to get the SD card info:

```bash
sudo fdisk -l
Disk /dev/sda: 238,47 GiB, 256060514304 bytes, 500118192 sectors
Disk model: LITEON CV8-8E256
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gp
Disk identifier: D93519F5-AC25-4ECB-9518-6EF3DC30BA70

Device         Start       End   Sectors   Size Type
/dev/sda1       4096   2101247   2097152     1G EFI System
/dev/sda2    2101248 481663187 479561940 228,7G Linux filesystem
/dev/sda3  481663188 500118125  18454938   8,8G Linux filesystem


Disk /dev/mapper/luks-8fe3e538-d29b-4eed-9f58-86716a49dc8c: 228,66 GiB, 245518936064 bytes, 479529172 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/mapper/luks-769370cf-598d-44a8-a737-92503b44a377: 8,78 GiB, 9432151040 bytes, 18422170 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/sdb: 7,5 GiB, 8053063680 bytes, 15728640 sectors
Disk model: USB DISK        
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x00000000

Device     Boot Start      End  Sectors  Size Id Type
/dev/sdb1        8192 15728639 15720448  7,5G  c W95 FAT32 (LBA)
```

Ok, it has a bunch of info, mostly they are not about SD card :(

How do I know what's my SD card? There's a simple solution, remove the SD card and run the command again:

```bash
sudo fdisk -l
Disk /dev/sda: 238,47 GiB, 256060514304 bytes, 500118192 sectors
Disk model: LITEON CV8-8E256
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: D93519F5-AC25-4ECB-9518-6EF3DC30BA70

Device         Start       End   Sectors   Size Type
/dev/sda1       4096   2101247   2097152     1G EFI System
/dev/sda2    2101248 481663187 479561940 228,7G Linux filesystem
/dev/sda3  481663188 500118125  18454938   8,8G Linux filesystem


Disk /dev/mapper/luks-8fe3e538-d29b-4eed-9f58-86716a49dc8c: 228,66 GiB, 245518936064 bytes, 479529172 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/mapper/luks-769370cf-598d-44a8-a737-92503b44a377: 8,78 GiB, 9432151040 bytes, 18422170 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
```

Alright, so now we know that this is the diff:

```bash
Disk /dev/sdb: 7,5 GiB, 8053063680 bytes, 15728640 sectors
Disk model: USB DISK        
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x00000000

Device     Boot Start      End  Sectors  Size Id Type
/dev/sdb1        8192 15728639 15720448  7,5G  c W95 FAT32 (LBA)
```

Yeah, I was expecting the `Disk model` to be `SD CARD` instead of `USB DISK`.

Now that we identified what is the disk name, reinsert it and let's mount it (yay!):

First, create a directory for the SD card to be mounted to: `sudo mkdir /media/sdcard/`

Mount to the created directory: `sudo mount /dev/sdb1/ /media/sdcard/`

After finishing your work, detaches the SD card: `sudo umount /dev/sdb1`. You can remove the directory (optional, it will be empty after the umount): `sudo rmdir /media/sdcard/`

---

Do I really need `sudo`? Yes:

```bash
fdisk -l
fdisk: cannot open /dev/sda: Permission denied
fdisk: cannot open /dev/mapper/luks-8fe3e538-d29b-4eed-9f58-86716a49dc8c: Permission denied
fdisk: cannot open /dev/mapper/luks-769370cf-598d-44a8-a737-92503b44a377: Permission denied
fdisk: cannot open /dev/sdb: Permission denied
```

Do I really need `-l`? Yes:

```bash
fdisk -l
fdisk: cannot open /dev/sda: Permission denied
fdisk: cannot open /dev/mapper/luks-8fe3e538-d29b-4eed-9f58-86716a49dc8c: Permission denied
fdisk: cannot open /dev/mapper/luks-769370cf-598d-44a8-a737-92503b44a377: Permission denied
fdisk: cannot open /dev/sdb: Permission denied
```

WTF is `-l`?

```bash
fdisk --help | grep "\--list"
 -l, --list                    display partitions and exit
 -x, --list-details            like --list but with more details
```

So now you know, that if you want more information you can use `-x` or `--list-details`:

```bash
sudo fdisk -x
Disk /dev/sda: 238,47 GiB, 256060514304 bytes, 500118192 sectors
Disk model: LITEON CV8-8E256
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: D93519F5-AC25-4ECB-9518-6EF3DC30BA70
First usable LBA: 2048
Last usable LBA: 500118158
Alternative LBA: 500118191
Partition entries starting LBA: 2
Allocated partition entries: 128
Partition entries ending LBA: 33

Device         Start       End   Sectors Type-UUID                            UUID                                 Name Attrs
/dev/sda1       4096   2101247   2097152 C12A7328-F81F-11D2-BA4B-00A0C93EC93B 0C31A868-BCF7-4741-B4BD-869DC91EB35B EFI  
/dev/sda2    2101248 481663187 479561940 0FC63DAF-8483-4772-8E79-3D69D8477DE4 7AF95225-B487-4BBD-B472-1DA391BAFD90 root 
/dev/sda3  481663188 500118125  18454938 0FC63DAF-8483-4772-8E79-3D69D8477DE4 568736A3-905A-4BAB-A727-2388525CCCAA      


Disk /dev/mapper/luks-8fe3e538-d29b-4eed-9f58-86716a49dc8c: 228,66 GiB, 245518936064 bytes, 479529172 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/mapper/luks-769370cf-598d-44a8-a737-92503b44a377: 8,78 GiB, 9432151040 bytes, 18422170 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/sdb: 7,5 GiB, 8053063680 bytes, 15728640 sectors
Disk model: USB DISK        
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x00000000

Device     Boot Start      End  Sectors Id Type            Start-C/H/S End-C/H/S Attrs
/dev/sdb1        8192 15728639 15720448  c W95 FAT32 (LBA)     0/130/3 979/15/60
```

Reference: https://askubuntu.com/questions/95391/how-do-i-mount-an-sd-card/266092#266092
