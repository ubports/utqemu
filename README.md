# Ubuntu touch qemu

Ubuntu touch qemu is an easy to use ubuntu touch emulator/virtual machine.

Snap parts are based on qemu-virgil 
See https://snapcraft.io/qemu-virgil

## Installation
Install the snap and connect to kvm:
```
snap install utqemu --edge
sudo snap connect utqemu:kvm
```

## Usage
```
$ utqemu --help
Ubuntu touch qemu - usage
  utq start    - Stats qemu
  utq create   - Creates ubuntu touch qemu
  utq recreate - reCreates ubuntu touch qemu
  utq delete   - Deletes ubuntu touch qemu
  utq ssh      - ssh into running ubuntu touch qemu
  Default user:password is phablet:phablet
```

## Copying
Unlike the other files in this repo, [`snap/gui/icon.png`](./snap/gui/icon.png)
comes from [QEMU](https://gitlab.com/qemu-project/qemu) and is released under
[the GNU General Public License, version 2](./gpl-2.0.md) or (at your option)
any later version.
