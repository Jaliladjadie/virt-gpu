#define _GNU_SOURCE
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/syscall.h>
#include <sys/types.h>

#define finit_module(fd, param_values, flags) \
	syscall(SYS_finit_module, fd, param_values, flags)

int main(void) {
	const char *module_path = "/virt-gpu.ko";

	int fd = open(module_path, O_RDONLY);
	if (fd < 0) {
		perror("open");
		return 1;
	}

	if (finit_module(fd, "", 0) != 0) {
		perror("finit_module");
		close(fd);
		return 1;
	}

	close(fd);
	printf("Module %s loaded successfully.\n", module_path);
	return 0;
}
