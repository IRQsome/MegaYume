
#include <compiler.h>
#include <dirent.h>
#include <sys/stat.h>

char *get_name_for_dirent(struct dirent *d) {
    return d->d_name;
}


int get_type_for_dirent(struct dirent *d) {
    switch(d->d_type) {
    case DT_REG:
        return 2;
    case DT_DIR:
        return 1;
    default:
        return 0;
    }
}

int get_type_for_path(const char *path) {
    struct stat buf;
    if(!stat(path,&buf)) {
        if (S_ISDIR(buf.st_mode)) return 1;
        if (S_ISREG(buf.st_mode)) return 2;
    }
}



int exists(const char *path) {
    struct stat buf;
    return stat(path,&buf) == 0;
}
