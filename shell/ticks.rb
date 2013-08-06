
# Overrides backtick operator (``) to echo everything to stdout line-by-line
def `(command)
  require 'open3'
  out = ''
  Open3.popen2e(command) do |i,oe,waiter|
    pid = waiter.pid
    oe.each_line{|l| puts l.strip; out << l }
    # TODO: add filtering capability
    exit_status = waiter.value
    raise "shell command error: #{exit_status}" if not exit_status.success?
  end
  return out
end
