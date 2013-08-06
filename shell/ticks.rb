require_relative 'ex'

# Overrides backtick operator (``) to echo everything to stdout line-by-line
def `(cmd)
  ex(cmd)
end
