#include <ruby.h>

#include "stat_flags.h"

void
Init_stat_flags(void)
{
  rb_define_method(rb_cStat, "flags", rb_stat_flags, 0);
}

static VALUE
rb_stat_flags(VALUE self)
{
  return UINT2NUM(ST2UINT(get_stat(self)->st_flags));
}
