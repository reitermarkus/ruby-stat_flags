```ruby
require 'stat_flags'

dir = "directory"

system "mkdir", "-p", dir
File.stat(dir).flags
==> 0

system "chflags", "hidden", dir
File.stat(dir).flags
==> 32768
```
