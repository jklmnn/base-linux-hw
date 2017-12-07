#include <unistd.h>
#include <stdio.h>
#include <string.h>

#include <dirent.h>
#include <sys/types.h>
#include <sys/stat.h>

void print_rom(void)
{
    printf("\n:initramfs: ROM modules:\n");
    DIR *genode = opendir(".");
    if(genode){
        struct dirent* entry;
        off_t offset = 0;
        while((entry = readdir(genode))){
            if(strcmp(entry->d_name, ".") && strcmp(entry->d_name, "..")){
                struct stat st;
                stat(entry->d_name, &st);
                printf(" ROM: [%#08lx, %#08lx] %s\n", offset, st.st_size, entry->d_name);
            }
            offset += entry->d_off;
        }
    }
    printf("\n");
}

int
main (int argc __attribute__((unused)), char *argv[] __attribute__((unused)))
{
    char *args = "core";
    printf("loading Genode on Linux\n");
    if (chdir("/genode")){
        perror("failed to chdir into /genode");
        return 1;
    }
    print_rom();
    if(execve("core", &args, NULL)){
        perror("failed to start core");
        return 1;
    }
}
