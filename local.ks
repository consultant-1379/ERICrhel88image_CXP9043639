install
text
keyboard uk
lang en_GB.UTF-8
skipx
network --device eth0 --bootproto dhcp
#network --bootproto dhcp
rootpw %ROOTPW%
firewall --disabled
authconfig --enableshadow --passalgo=sha256
selinux --enforcing
timezone --utc Europe/Dublin
bootloader --location=mbr --append="console=tty0 console=ttyS0,115200 net.ifnames=0 systemd.log_target=kmsg log_buf_len=1M"
zerombr
clearpart --all --drives=vda

part biosboot --fstype=biosboot --size=1
part /boot --fstype xfs --size=1000 --ondisk=vda --mkfsoptions="-m reflink=0"
part pv.2 --size=1 --grow --ondisk=vda
volgroup VolGroup00 --pesize=32768 pv.2
logvol / --fstype xfs --name=LogVol00 --vgname=VolGroup00 --mkfsoptions="-m reflink=0" --size=1024 --grow
reboot

%packages
@core
@perl:5.26/common
@python36:3.6/common

%end
