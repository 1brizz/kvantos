# SPDX-License-Identifier: GPL-3.0-or-later
#
# KvantOS — костыль для BIOS-установок: модуль bootloader требует, чтобы
# GlobalStorage содержал ключ "bootLoader" (диск для установки GRUB).
# На BIOS при автоматической разметке (Erase disk) partition-модуль может
# его не выставить, и установка загрузчика молча пропускается. Мы выставляем
# диск корневого раздела, если ключ отсутствует.

import re

import libcalamares


def _disk_for(device):
    # /dev/sda2 -> /dev/sda; /dev/nvme0n1p2 -> /dev/nvme0n1; /dev/mmcblk0p2 -> /dev/mmcblk0
    m = re.match(r"^(/dev/(?:nvme\d+n\d+|mmcblk\d+)p?|/dev/[a-zA-Z]+)\d+$", device or "")
    return m.group(1) if m else None


def run():
    fw_type = libcalamares.globalstorage.value("firmwareType")
    if fw_type == "efi":
        return None
    if libcalamares.globalstorage.contains("bootLoader") and libcalamares.globalstorage.value("bootLoader"):
        return None
    partitions = libcalamares.globalstorage.value("partitions") or []
    for p in partitions:
        if p.get("mountPoint") == "/":
            disk = _disk_for(p.get("device", ""))
            if disk:
                libcalamares.globalstorage.insert("bootLoader", disk)
                libcalamares.utils.debug(f"kvantos-bootloaderfix: bootLoader={disk}")
            else:
                libcalamares.utils.warning(f"kvantos-bootloaderfix: cannot derive disk from {p.get('device')}")
            break
    return None
