

# Linear ramp
#EVELS = (0..14).map{|x|(x*73)>>2}

# Approximate real ramp
LEVELS = [0,29,52,70,87,101,116,130,144,158,172,187,206,228,255]

File.binwrite("CRAM2RGB.DAT",(0..0x7FF).map do |c|
    if c&0x008 != 0 # Normal
        next LEVELS[((c>>0)&7)<<1] << 24 |
             LEVELS[((c>>4)&7)<<1] << 16 |
             LEVELS[((c>>8)&7)<<1] <<  8
    elsif c&0x080 != 0 # Highlit
        next LEVELS[((c>>0)&7)+7] << 24 |
             LEVELS[((c>>4)&7)+7] << 16 |
             LEVELS[((c>>8)&7)+7] <<  8
    else # Shadowed
        next LEVELS[((c>>0)&7)] << 24 |
             LEVELS[((c>>4)&7)] << 16 |
             LEVELS[((c>>8)&7)] <<  8
    end
end.pack("I<*"))
