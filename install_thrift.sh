#!/usr/bin/env ruby

require "optparse" or abort("'optparse' required but not installed!")
require "ostruct"
require "colorize"

options = OpenStruct.new
options.version = "0.9.1"
options.dry_run = false
options.with_language = %w(java python ruby haskell go erlang)
OptionParser.new do |opts|
  opts.banner = "Usage: install_thrift.sh [options]"
  opts.on('-v', '--version VERSION', "Installed library version. Default: #{options.version}.") { |v| options.version = v }
  opts.on('-n', '--dry-run', 'Dry run.') { options.dry_run = true }
end.parse!


def run_command(command, options)
  if options.dry_run
    puts "Would run command '#{command}'"
    return
  end
  output = `#{command} 2>&1`
  if $?.exitstatus == 0
    puts "Command '#{command}' execution success".green
  else
    puts "Command '#{command}' execution failure".red
    puts "Output:\n#{output}".red
    exit($?.exitstatus)
  end
end

DownloadUrl = "http://ftp.ps.pl/pub/apache/thrift/#{options.version}/thrift-#{options.version}.tar.gz"
unless File.exist?("/opt/thrift-#{options.version}")
  run_command("curl #{DownloadUrl} -o /tmp/thrift-#{options.version}.tar.gz", options)
  run_command("tar xzf /tmp/thrift-#{options.version}.tar.gz -C /opt/", options)
  run_command("rm /tmp/thrift-#{options.version}.tar.gz", options)
end

DownloadDir = "/opt/thrift-#{options.version}"
run_command("cd #{DownloadDir} && ./configure --prefix='/opt/thrift' --with-#{options.with_language.join(' --with-')}", options)
run_command("cd #{DownloadDir} && ", options)
run_command("cd #{DownloadDir} && ", options)
run_command("cd #{DownloadDir} && ", options)
