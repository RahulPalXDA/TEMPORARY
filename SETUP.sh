function Installing_Base() {
    pacstrap -i /mnt base base-devel linux-lts linux-firmware sudo nano git xdg-user-dirs ttf-dejavu ttf-indic-otf noto-fonts-emoji ntfs-3g
}
function Fstab_chroot() {
    genfstab -U -p /mnt >> /mnt/etc/fstab
    arch-chroot /mnt /bin/bash
}
function Set_Locale() {
    mv /etc/locale.gen /etc/locale.gen.bak
    sed 's/#en_US.UTF-8/en_US.UTF-8/g' /etc/locale.gen.bak >> /etc/locale.gen
    locale-gen
    echo "LANG=en_US.UTF-8" >> /etc/locale.conf
}
function Set_Time() {
    hwclock --systohc --utc
    date
    sleep 5
}
function Set_Hostname() {
    echo "asus-x505za" >> /etc/hostname
    echo "127.0.1.1 localhost.localdomain asus-x505za" >> /etc/hosts
}
function Enable_Network() {
    pacman -S networkmanager
    systemctl enable NetworkManager
}
function Installing_Grub() {
    pacman -S grub efibootmgr
    grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi --removable
    mv /etc/default/grub /etc/default/grub.bak
    sed 's/quiet/acpi_backlight=vendor/g' /etc/default/grub.bak >> /etc/default/grub
    grub-mkconfig -o /boot/grub/grub.cfg
}
function TODO() {
    clear
    echo ""
    echo ""
    echo "## TODO: Set password for root"
    echo "## TODO: Create USER for this System && Set password"
    echo ""
    echo ""
    sleep 10
}
clear
Installing_Base
Fstab_chroot
Set_Locale
Set_Time
Set_Hostname
Enable_Network
Installing_Grub
TODO
