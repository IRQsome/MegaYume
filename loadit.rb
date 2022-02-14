# encoding: utf-8
# frozen_string_literal: true

comport = 'COM7'
SLICE_SIZE = 256*1024

require 'tempfile'
require 'optparse'

loader = "psram_loadit"

OptionParser.new do |opts|
    opts.on("-p PORT") do |v|
        comport = v
    end
    opts.on("--hyper") do |v|
        loader = "hyper_loadit"
    end
end.parse!

`flexspin -2 #{__dir__}/memstuff/#{loader}.spin2`
raise "Failed to build loader" unless $?.success?



raise "Need exactly one argument" if ARGV.size != 1


thefile = File.binread(ARGV[0])

totalslices = ((thefile.size-1)/SLICE_SIZE)+1

i = 0
until thefile.empty?
    puts "Loading slice #{i}..."
    tmp = Tempfile.new("loadit", binmode: true)
    tmp.write(i.chr)
    tmp.write(totalslices.chr)
    tmp.write(thefile.slice!(0...SLICE_SIZE).ljust(SLICE_SIZE,?\0))
    tmp.close
    `loadp2 -p #{comport} @0=#{__dir__}/memstuff/#{loader}.binary,@7FFE=#{tmp.path} -e "recv(E)"`
    puts "Error while loading!" unless $?.success?
    tmp.unlink
    i+=1
end


