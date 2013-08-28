
## TODO: finish implementing filters...
module Accel
  @@ex_filters = []
end

def ex(cmd, opts = {prefix:''})
  require 'open3'
  out = ''
  exit_status = nil
  Open3.popen2e(cmd) do |i,oe,waiter|
    pid = waiter.pid
    oe.each_line do |l|
      p = ( block_given? ? yield(l) : l )
      print "#{opts[:prefix]}#{p}"
      out << p
    end
    # TODO: add filtering capability
    exit_status = waiter.value
    raise "shell command error: #{exit_status}" if not exit_status.success?
  end
  return exit_status
end