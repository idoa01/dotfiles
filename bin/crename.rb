#!/usr/bin/env ruby
require 'optparse'
$:.unshift File.dirname(__FILE__)

def crename(filename, options)
  new_filename = filename.gsub(" ","_").gsub(/\([a-zA-Z]+[^)]*\)/,"").gsub(/[()]/,"").gsub(/_+\./,".")
  new_filename = options[:num] + "_" + new_filename if options[:num]
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
    opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
      options[:verbose] = v
    end
  end.parse!
  filename = ARGV[0]
  crename(filename, options)
end
