#!/usr/bin/env ruby

$LOAD_PATH.unshift File.expand_path("../ext", __FILE__)

require 'benchmark'
require 'fileutils'
require 'open3'
require 'stat_flags'
require 'tmpdir'

Dir.mktmpdir do |dir|
  Dir.chdir dir do
    n = 10_000

    files = n.times.to_a.map { |n|
      FileUtils.touch n.to_s
      n.to_s
    }

    Benchmark.bmbm do |x|
      x.report("File::Stat#flags") do
        files.each do |file|
          File::Stat.new(file).flags
        end
      end

      x.report("system") do
        begin
          old_stdout = $stdout.dup
          old_stderr = $stderr.dup

          $stderr.reopen("/dev/null")
          $stdout.reopen("/dev/null")

          files.each do |file|
            system "stat", "-f", "%Of", file
          end
        ensure
          $stdout.reopen(old_stdout)
          $stderr.reopen(old_stderr)

          old_stdout.close
          old_stderr.close
        end
      end

      x.report("Open3") do
        files.each do |file|
          Open3.capture3("stat", "-f", "%Of", file)
        end
      end
    end
  end
end
