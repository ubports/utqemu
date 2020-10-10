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

## Troubleshooting
#### Problem:
Running ``` utq start ``` command throws following error displayed:
 ``` 
 Display 'sdl' is not available 
 ```
#### Solution: 
Change the display type to gtk in utq.sh file.Make following changes in your utq.sh file.

##### From: 
 ```
 function start_qemu {
    exec $F_QEMU \
        -enable-kvm \
        -m 2G \
        -device virtio-vga,virgl=on \
        -display sdl,gl=on \
        -netdev user,id=ethernet.0,hostfwd=tcp::10022-:22 \
        -device rtl8139,netdev=ethernet.0 \
        ${IMG_FILE}
}
```
##### To:
``` function start_qemu {
    exec $F_QEMU \
        -enable-kvm \
        -m 2G \
        -device virtio-vga,virgl=on \
        -display gtk,gl=on \
        -netdev user,id=ethernet.0,hostfwd=tcp::10022-:22 \
        -device rtl8139,netdev=ethernet.0 \
        ${IMG_FILE}
}
```


