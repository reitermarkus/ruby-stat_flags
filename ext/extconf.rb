require 'mkmf'

extension_name = 'stat_flags'

ENV["CFLAGS"] = "-Wno-implicit-function-declaration"

dir_config(extension_name)
create_makefile(extension_name)
