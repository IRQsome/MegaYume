

# Linear ramp
#LEVELS = (0..7).map{|x|(x*73)>>1}

# Approximate real ramp
LEVELS = [0,52,87,116,144,172,206,255]

File.binwrite("CRAM2RGB.DAT",(0..0x777).map do |c|
    next LEVELS[(c>>0)&7] << 24 |
         LEVELS[(c>>4)&7] << 16 |
         LEVELS[(c>>8)&7] <<  8
end.pack("I<*"))
