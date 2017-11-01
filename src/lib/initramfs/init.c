#include <unistd.h>
#include <stdio.h>

int
main (int argc __attribute__((unused)), char *argv[] __attribute__((unused)))
{
    char *args = "core";
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
