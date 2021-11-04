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
  utqemu start    - Stats qemu
  utqemu create   - Creates ubuntu touch qemu
  utqemu recreate - reCreates ubuntu touch qemu
  utqemu delete   - Deletes ubuntu touch qemu
  utqemu ssh      - ssh into running ubuntu touch qemu
  Default user:password is phablet:phablet
```
