#!/bin/env ruby
# -*- coding: utf-8 -*-
require "time"

# single line comment.
=begin
Here is multiple line comment.
=end

CONST_VARIABLE = 1

class ClassA
  def initialize(arg1, arg2=1, arg3=nil)
    @value = arg1 + arg2
    @value += arg3 unless (arg3.nil?)
  end
end

class ClassB < ClassA
  attr_reader :value

  def initialize()
    super(1, 2, 3)
  end

  def function()
    return 6
  end
end

$global_var = ClassB.new()
puts($global_var.value)
raise unless ($global_var.value == $global_var.function())

if ("melanite" =~ /^m([itlane]+e)$/)
  puts("matched")
end

begin
  x = 1 / 0
rescue ZeroDivisionError => e
  puts(e)
end

puts(`ls`)
