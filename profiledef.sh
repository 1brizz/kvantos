#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="kvantos"
iso_label="KVANTOS_$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y%m)"
iso_publisher="KvantOS Project"
iso_application="KvantOS Live/Rescue DVD"
iso_version="$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y.%m.%d)"
install_dir="kvantos"
bootmodes=('bios.syslinux'
           'uefi.systemd-boot')
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'xz' '-Xbcj' 'x86,arm64' '-b' '1M' '-Xdict-size' '1M')
bootstrap_tarball_compression=('zstd' '-c' '-T0' '--auto-threads=logical' '--long' '-19')
kernel_params_x86_64="quiet splash"
kernel_params_aarch64="clk_ignore_unused pd_ignore_unused arm64.nopauth"
file_permissions=(
  ["/etc/shadow"]="0:0:400"
  ["/root"]="0:0:750"
  ["/root/.automated_script.sh"]="0:0:755"
  ["/root/.gnupg"]="0:0:700"
  ["/usr/local/bin/choose-mirror"]="0:0:755"
  ["/usr/local/bin/kvantos-set-wallpaper"]="0:0:755"
  ["/etc/xdg/autostart/kvantos-wallpaper.desktop"]="0:0:755"
  ["/etc/xdg/autostart/kvantos-hello.desktop"]="0:0:755"
  ["/etc/sudoers.d/99-kvantos-live"]="0:0:440"
  ["/usr/local/bin/Installation_guide"]="0:0:755"
  ["/usr/local/bin/livecd-sound"]="0:0:755"
  ["/home/kvantos"]="1000:1000:755"
  ["/home/kvantos/Desktop"]="1000:1000:755"
  ["/home/kvantos/Desktop/install-kvantos.desktop"]="1000:1000:755"
)
