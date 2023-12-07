mkdir -p rootfs
bash -c 'podman export $(podman create busybox) | tar -C rootfs -xvf -'
crun spec --rootless
crun run cont1

# Change the executable of the container:
# sed -i 's/"sh"/"sh", "-c", "echo Hi, my PID is $$; sleep 10; echo Bye Bye"/' config.json
# sed -i 's/"terminal": true/"terminal": false/' config.json
