.PHONY: all clean

all: clean
	podman --transient-store build -t virt-gpu --no-hosts --runtime=runc --squash-all .
	podman --transient-store --rm \
	--cap_add=MKNOD --cap_add=SYS_ADMIN \
	-v /dev:/dev:rw \
	virt-gpu

clean:
	podman --transient-store image rm virt-gpu || true
