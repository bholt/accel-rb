#!/usr/bin/env ruby
require "awesome_print"
require "open3"
require "accel-rb"

softxmt_files = "--exclude=*.test --exclude=*.d --exclude=*.o --exclude=*.a --exclude=*.exe --exclude=.fuse_hidden* --exclude=*.ckpt --exclude=core.* --exclude=*.swp --exclude=.srunrc* --exclude=*.events --exclude=*.trc --exclude=*.edf --exclude=profile.* --exclude=app* --exclude=fn_mappings --exclude=reader.out --exclude=*.prof --exclude=*.events.z --exclude=*.def.z --exclude=*.marker.z --exclude=*.otf"

$aliases = {
  "eddie-softxmt" => {
    filter: "--include=*/ #{softxmt_files} ",
    home: "~",
    remote: "eddie:/share",
    name: "softxmt"
  },
  "eddie-grappa-timing" => {
    filter: "--include=*/ #{softxmt_files} ",
    home: "~",
    remote: "eddie:/share",
    name: "grappa-timing"
  },
  "eddie-grappa-fresh" => {
    filter: "--include=*/ #{softxmt_files} ",
    home: "~",
    remote: "eddie:/share",
    name: "grappa-fresh"
  },
	"alta-softxmt" => {
		filter: "--include=*/ #{softxmt_files} ",
    home: "~/",
		remote: "alta:/share",
		name: "softxmt"
	},
	"frozen" => {
		filter: "--include=*/ --exclude=.fuse_hidden* --exclude=*.rb --exclude=core.* --exclude=*.o --exclude=*.d --exclude=*.ckpt --exclude=*.nedge --include=include.mk --include=system/** --include=applications/** --include=.git/** --exclude=*",
		home: "~",
		remote: "~/frozen",
		name: "softxmt",
	},
}

def DIR
  File.dirname(__FILE__)
end

def alias_lookup(name)
  $aliases.each_pair do |key,value|
    return key,value if key =~ /#{name}/
  end
  puts "Alias #{name} not found."
  exit
end

def pull(name, local, remote, filter)
  puts "pull: #{remote}/#{name} -> #{local}/#{name}"
	cmd = "rsync -avz #{filter} #{remote}/#{name} #{local}"
  #puts cmd
  Open3.popen2e(cmd) do |i,oe|
    oe.each {|line| puts line }
  end
end

def push(name, local, remote, filter)
  puts "push: #{local}/#{name} -> #{remote}/#{name}"
  cmd = "rsync -avz #{filter} --exclude=.sync.rb #{local}/#{name} #{remote}"
  Open3.popen2e(cmd) do |i,oe|
    oe.each {|line| puts line }
  end
end

def print_usage()
  puts "Usage: #{$PROGRAM_NAME} <push/pull>"
  exit
end

############################
# Main                     #
############################
if __FILE__ == $PROGRAM_NAME
  if ARGV.length < 1 or ARGV.length > 2 then
    print_usage
  end
  
  # set global variables with innermost '.sync' file found
  find_up_path('.sync.rb').reverse_each do |e|
    #enclosing_dir = File.dirname(e)
    m = e.match(/(.*)\/(.*)\/\.sync\.rb/)
    $local = m[1]
    $name = m[2]
    require e
  end

  case ARGV[0]
  when /pull/
    pull($name, $local, $remote, $filter)
  when /push/
    push($name, $local, $remote, $filter)
  when /mate/
    rmachine, rbase = *$remote.split(':')
    relative_file = ( ARGV.length > 1 ? File.expand_path(ARGV[1]).gsub("#{$local}/#{$name}","") : '' )
    `ssh #{rmachine} "mate #{rbase}/#{$name}/#{relative_file}"`
  else
    print_usage()
  end
end

