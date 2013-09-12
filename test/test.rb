#!/usr/bin/env ruby
require 'ap'
require_relative '../lib/accel/opt'

o = Accel::opt! {
  foo 1
  bar "hello"
}

puts o.inspect
