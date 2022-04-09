
#include <compiler.h>
#include <dirent.h>
#include <sys/stat.h>

char *get_name(struct dirent *d) {
    return d->d_name;
}

int get_type(const char *path) {
    struct stat buf;
    if(!stat(path,&buf)) {
        if (S_ISDIR(buf.st_mode)) return 1;
        if (S_ISREG(buf.st_mode)) return 2;
    }
    return 0;
}
