# Deadpool
# One stop reference to get a development evnviorment up and running from the OS and up

# wget https://raw.githubusercontent.com/gndpwnd/dotfiles/main/deadpool

echo -e "

## OS - Pumpkin Spice Arch with ENC LVM
# https://gist.github.com/mjnaderi/28264ce68f87f52f2cabb823a503e673#file-install-arch-md
# https://gist.github.com/mattiaslundberg/8620837#file-arch-linux-install

lsblk
ur_root_passphrase=\"supersecret\"
ur_user_passphrase=\"supersecret\"
ur_disk_passphrase=\"supersecret\"
ur_disk=\"/dev/sda\"
ur_disk_efi=\"/dev/sda1\"
ur_disk_boot=\"/dev/sda2\"
ur_disk_luks=\"/dev/sda3\"
fdisk /dev/\$\"ur-disk\"
g
n
<Press Enter>
<Press Enter>
+100M
t
uefi
n
<Press Enter>
<Press Enter>
+512M
t
<Press Enter>
linux
n
<Press Enter>
<Press Enter>
<Press Enter>
t
<Press Enter>
linux
p
w
mkfs.fat -F 32 /dev/\"\$ur_disk_efi\"
mkfs.ext4 /dev/\"\$ur_disk_boot\"
cryptsetup --use-random luksFormat \"\$ur_disk_luks\"
# ---> Enter 'YES'
# ---> Enter your passphrase and confirm
cryptsetup luksOpen \"\$ur_disk_luks\" cryptlvm
pvcreate /dev/mapper/cryptlvm
vgcreate vg0 /dev/mapper/cryptlvm
lvcreate --size 8G vg0 --name swap
lvcreate -l +10%FREE vg0 --name root
lvcreate -l +100%FREE vg0 --name home
lvreduce --size -256M vg0/home
mkswap /dev/vg0/swap
mkfs.ext4 /dev/vg0/root
mkfs.ext4 /dev/vg0/home
mount /dev/vg0/root /mnt
mount --mkdir \"\$ur_disk_efi\" /mnt/efi
mount --mkdir \"\$ur_disk_boot\" /mnt/boot
mount --mkdir /dev/vg0/home /mnt/home
swapon /dev/vg0/swap
pacstrap -K /mnt base linux linux-headers linux-lts linux-lts-headers linux-firmware openssh git vim sudo
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt /bin/bash
ln -s /usr/share/zoneinfo/America/New_York /etc/localtime
hwclock --systohc
vim /etc/locale.gen
# press "/" to start search, uncomment en_US.UTF-8 UTF-8)
# press i to enter Insert mode
# press ESC to return to command mode
# :wq
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
datename=`date '+%y%m%e'`
echo \"pwnstar\$datename\" > /etc/hostname
passwd
useradd -m -G wheel --shell /bin/bash devel
passwd devel
visudo
# ---> Uncomment \"%wheel ALL=(ALL) ALL\"
pacman -S --noconfirm lvm2 grub efibootmgr networkmanager
vim /etc/mkinitcpio.conf
# ---> Add 'encrypt' and 'lvm2' to HOOKS before 'filesystems'
# HOOKS=(base udev autodetect microcode modconf kms keyboard keymap consolefont block encrypt lvm2 filesystems fsck)
mkinitcpio -P
modprobe efivarfs
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
GRUB_CMDLINE_LINUX=\"cryptdevice=/dev/<your-disk-luks>:cryptlvm root=/dev/vg0/root\"
grub-mkconfig -o /boot/grub/grub.cfg
systemctl enable NetworkManager
sudo cryptsetup luksHeaderBackup /dev/\$ur_disk_luks --header-backup-file /opt/luks-header-backup-\$(date -I)
exit
umount -R /mnt
swapoff -a
reboot now
" > install.md

echo -e "

## Desktop packages and setup dotfiles
# https://www.fosskers.ca/en/blog/wayland

cd /opt

# wayland ansd sway
sudo pacman -S --noconfirm \
  sway alacritty waybar wofi \
  xorg-xwayland xorg-xlsclients qt5-wayland glfw-wayland

# AUR Helper yay
git clone https://aur.archlinux.org/yay-git.git
cd yay
makepkg -si

# AUR Helper Snap
git clone https://aur.archlinux.org/snapd.git
cd snapd
makepkg -si
sudo systemctl enable --now snapd.socket
sudo systemctl enable --now snapd.apparmor.service

# google chrome
yay -S google-chrome

sudo reboot now
" > deadpool-desktop.sh

echo -e "

## Dev packages and repos

cd /opt

git clone https://github.com/gndpwnd/dotfiles

# NASM
pacman -Sy gcc make nasm
# C/C++
pacman -Sy base-devel
# Python
pacman -Sy python python-pip
pip install tqdm, NumPy, Pandas, Matplotlib, TensorFlow, PyTorch, Scikit-learn, \
            Requests, Keras, Seaborn, Plotly, NLTK, Beautiful Soup, urllib

# Rust
echo \"in a separate terminal, run the following\ncurl https://sh.rustup.rs -sSf | sh\npress c to continue\"

# Golang
wget https://gist.githubusercontent.com/jeanmolossi/8f2a643540aee671becf828d983952fd/raw/5b9b77c6f96bbcfcbd4cd1ddf8e8df3dced799da/install-go.sh
echo \"in a separate trrminal run the install-go script\"

#Arduino / Pio
sudo snap install arduino
wget -O get-platformio.py https://raw.githubusercontent.com/platformio/platformio-core-installer/master/get-platformio.py
echo \"in a separate terminal run the following \npython3 get-platformio.py\"

pacman -S curl sudo sublime-text
snap install spotify

curl -O https://blackarch.org/strap.sh

chmod +x strap.sh
sudo ./strap.sh

sudo reboot now
" > deadpool-devenv.sh


"
fdisk /dev/sda
p
g
p
n
<>
<>
+1G
n
<>
<>
+1G
n
<>
<>
<>
t
<>
44
p
w
mkfs.fat -F32 /dev/sda1
mkfs.ext4 /dev/sda2
cryptsetup luksFormat /dev/sda3
YES
toortoor
toortoor
cryptsetup open --type luks /dev/sda3 lvm
toortoor
pvcreate /dev/mapper/lvm
vgcreate volgroup0 /dev/mapper/lvm
lvcreate -L 30GB volgroup0 -n lv_root
lvcreate -l +100%FREE volgroup0 -n lv_home
lvdisplay
modprobe dm_mod
vgscan

mkfs.ext4 /dev/volgroup0/lv_root
mkfs.ext4 /dev/volgroup0/lv_home

mount /dev/volgroup0/lv_root /mnt
mkdir /mnt/boot
mount /dev/sda2 /mnt/boot
mkdir /mnt/home
mount /dev/volgroup0/lv_home /mnt/home

pacstrap -i /mnt base
<>
<>
genfstab -U -p /mnt >> /mnt/etc/fstab
cat /mnt/etc/fstab
arch-chroot /mnt

passwd
toortoor
toortoor
useradd -m -g users -G wheel devel
passwd devel
toortoor
toortoor

pacman -S base-devel dosfstools efibootmgr lvm2 mtools vim nano networkmanager openssh os-prober sudo git linux linux-headers linux-lts linux-lts-headers linux-firmware mesa intel-media-driver nvidia nvidia-utils nvidia-lts

systemctl enable sshd

systemctl enable NetworkManager

vim /etc/mkinitcpio.conf
# ---> Add 'encrypt' and 'lvm2' to HOOKS before 'filesystems'
# HOOKS=(base udev autodetect microcode modconf kms keyboard keymap consolefont block encrypt lvm2 filesystems fsck)

mkinitcpio -p linux
mkinitcpio -p linux-lts

ln -s /usr/share/zoneinfo/America/New_York /etc/localtime
hwclock --systohc
vim /etc/locale.gen
# press "/" to start search, uncomment en_US.UTF-8 UTF-8)
# press i to enter Insert mode
# press ESC to return to command mode
# :wq
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
datename=`date '+%y%m%e'`
echo \"pwnstar\$datename\" > /etc/hostname


nano /etc/default/grub
cryptdevice=/dev/sda3:volgroup0

mkdir /boot/EFI
mount /dev/sda1 /boot/EFI
# pacman -S grub
#grub-install --target=x86_64-efi --bootloader-id=grub_uefi

*if no efi vars
exit
modprobe efivarfs
arch-chroot /mnt

refind-install --usedefault /dev/sda1
"
