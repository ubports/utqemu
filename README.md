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
Copyright (C) 2018–2022 UBports Foundation.

This program is free software: you can redistribute it and/or modify it under
the terms of [the GNU Lesser General Public License version 3](./LICENSE.md),
as published by the Free Software Foundation.

This program is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranties of MERCHANTABILITY,
SATISFACTORY QUALITY, or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

Unlike the other files in this repo, [`snap/gui/icon.png`](./snap/gui/icon.png)
comes from [QEMU](https://gitlab.com/qemu-project/qemu) and is released under
[the GNU General Public License, version 2](./gpl-2.0.md) or (at your option)
any later version.

[Because `snap/gui/icon.png` is available under a different license, the
combination of that icon with the rest of this repo is available under the GNU
GPLv3.](https://www.gnu.org/licenses/gpl-faq.html#AllCompatibility) (See
[`gpl-3.0.md`](./gpl-3.0.md) for details).
