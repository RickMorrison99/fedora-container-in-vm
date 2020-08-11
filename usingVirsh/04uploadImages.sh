#!/bin/bash -x

IMG=`ls -1 tmp/Fedora-Cloud*.qcow2 | tail -1`
ISO=tmp/work-seed.iso

SISO=$(stat -Lc%s "$ISO")
SIMG=$(stat -Lc%s "$IMG")

virsh vol-create-as default f32-seed.iso $SISO --format raw
virsh vol-create-as default f32.qcow2    $SIMG --format qcow2

virsh vol-upload --pool default f32-seed.iso $ISO
virsh vol-upload --pool default f32.qcow2    $IMG
