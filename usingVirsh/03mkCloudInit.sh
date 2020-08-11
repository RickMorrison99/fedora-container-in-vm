#!/bin/bash

cat > tmp/meta-data << EOF
instance-id: Cloud00
local-hostname: cloud-00
EOF

cat > tmp/user-data << EOF
#cloud-config
# Set the default user
system_info:
  default_user:
    name: cloud

# Unlock the default user
chpasswd:
  list: |
     cloud:password
  expire: False

# Other settings
resize_rootfs: True
ssh_pwauth: True
timezone: America/Edmonton

# Add any ssh public keys
ssh_authorized_keys:
 - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDFrebPhjobbJMs7eNueAHtzjY8OSiCRYPehnt3WRC2uyIfddhMJy03Pkvb8W72l30AGweQJaQx1W5eKjBNRdR6nZ5lF5a2pz+D0A5STC1v/QWN3oRcSajHcOWjwHRuvbgmGHpIs7oVoSoujRZnML2S/TEAwO5ekqwdWE063v/NbgC0Bve3j3K5VI4VCKrO+qMy3Y/fcqaXJQZWXrMnfFDyerCYunUr0QwEEjPsJnFA/bACAI9kQXcr0tA2Qmjfnh+stZgEVCIYD5bR8uSIFAhrTKKQFgHe7dVt5bFDeI9EPH/k9UmdEWeQ8xpmiiww+nsJ3v4y4Oj5vtWH8pyedh6x0lcAhaCxb+GgTfI9B/3Zg8O7YKTgEgTBvbTew68pf/gAHTsxqwKnQXoHC1D26HosY//MLu03lB0etzHKjFHHXV5kG+xyDWQEM20j+lB3N4wx7Iev8d5KVOWITk0tPCA6Dwcrpy96sWK72HGTbLBSv4dFZipxpoFFRyEWJNgaE8M= rik@shaw.ca

bootcmd:
 - [ sh, -c, echo "=========bootcmd=========" ]
 
runcmd:
 - [ sh, -c, echo "=========runcmd=========" ]
 
# For pexpect to know when to log in and begin tests
final_message: "SYSTEM READY TO LOG IN"
EOF

cd tmp
genisoimage -output work-seed.iso -volid cidata -joliet -rock user-data meta-data
