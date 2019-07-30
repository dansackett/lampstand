# Shared memory allows data to be passed between applications. Sometimes,
# multiple processes can share the same memory space and this can lead to
# exploitation.

Secure shared memeory:
  file.append:
    - name: /etc/fstab
    - sources:
      - salt://security/files/fstab
