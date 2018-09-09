#!/usr/bin/env ruby

require 'fileutils'
require 'tmpdir'

Dir.chdir File.expand_path("../ext", __FILE__) do |dir|
  FileUtils.rm_f [
    "Makefile",
    "stat_flags.bundle",
  ]

  $LOAD_PATH.unshift dir
  require "extconf"
  system "make"

  require "stat_flags"
  Dir.mktmpdir do |dir|
    system "chflags", "hidden", dir

    if (flags = File.stat(dir).flags) == 0o100000
      puts "0o#{flags.to_s(8)} == 0o100000"
    else
      $stderr.puts "0o#{flags.to_s(8)} != 0o100000"
      exit 1
    end
  end
end
