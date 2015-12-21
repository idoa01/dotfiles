#!/usr/bin/env ruby
require 'optparse'
$:.unshift File.dirname(__FILE__)

def crename(filename, options)
  num = nil
  if not options[:num].nil?
    num = options[:num]
  elsif filename =~ /\b(\d{3})\b/
    num = filename.scan(/\b(\d{3})\b/)[0][0]
  end
  puts num
  new_filename = filename.gsub(" ","_").gsub(/\([a-zA-Z]+[^)]*\)/,"").gsub(/[()]/,"").gsub(/_+\./,".")
  new_filename = num + "_" + new_filename if num
  $stderr.puts "#{if options[:rename] then "Renaming" else "Will rename" end} #{filename.inspect} to #{new_filename.inspect}" if options[:verbose]
  File.rename(filename, new_filename) if options[:rename]
end

if __FILE__ == $0
  options = {:verbose => true}
  OptionParser.new do |opts|
    opts.on("-m", "--rename", "actually do the rename") do |m|
      options[:rename] = true
    end
    opts.on("-n", "--num NUMBER", "use prefix") do |n|
      options[:num] = n
    end
    opts.on("-N", "--no-number", "do not use prefix") do |n|
      options[:num] = false
    end
    opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
      options[:verbose] = v
    end
  end.parse!
  filename = ARGV[0]
  crename(filename, options)
end
