void Init_stat_flags(void);
static VALUE rb_stat_flags(VALUE self);

// everything below is copied from 'file.c'

#include <sys/types.h>
#include <sys/stat.h>

#ifndef ST2UINT
  #define ST2UINT(val) ((val) & ~(~1UL << (sizeof(val) * CHAR_BIT - 1)))
#endif

static struct stat*
get_stat(VALUE self)
{
    struct stat* st;
    TypedData_Get_Struct(self, struct stat, RTYPEDDATA_TYPE(self), st);
    if (!st) rb_raise(rb_eTypeError, "uninitialized File::Stat");
    return st;
}
