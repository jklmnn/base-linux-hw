#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/mount.h>

int insmod(char *path)
{
    int fd;
    struct stat st;
    void *image;

    fd = open(path, O_RDONLY);
    if(fd == -1){
        return 1;
    }
    fstat(fd, &st);

    image = malloc(st.st_size);
    read(fd, image, st.st_size);
    close(fd);

    return syscall(__NR_init_module, image, st.st_size, "");
}

int
main (int argc __attribute__((unused)), char *argv[] __attribute__((unused)))
{
    char *args = "core";
    
    printf("preparing environment for Genode\n");
    if(mount("none", "/dev", "devtmpfs", 0, ""))
        perror("mount");
    
    if(insmod("/hwio.ko")){
        perror("insmod");
    }

    if(insmod("/platform_info.ko")){
        perror("platform_info");
    }
    close(open("/dev/platform_info", O_RDONLY));

    printf("loading Genode on Linux\n");
    if (chdir("/genode")){
        perror("failed to chdir into /genode");
        return 1;
    }
    if(execve("core", &args, NULL)){
        perror("failed to start core");
        return 1;
    }
}
