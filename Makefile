#uncomment the next line out to enable transient store if somwthing isn't working
#podman-args = --transient-store

.PHONY: all clean

all: clean
	podman $(podman-args) build -t virt-gpu --no-hosts --runtime=runc --squash-all .
	podman $(podman-args) --rm \
	--cap_add=MKNOD --cap_add=SYS_ADMIN \
	-v /dev/nvidia0:/dev/nvidia0:rw \
	-v /proc/devices:/proc/devices:rw \
	virt-gpu

clean:
	podman $(podman-args) image rm virt-gpu || true
