    _______ _______ _______ _______                 _______ _______ 
   (       |  ____ (  ____ (  ___  )\     /|\     /(       |  ____ \
   | () () | (    \/ (    \/ (   ) ( \   / ) )   ( | () () | (    \/
   | || || | (__   | |     | (___) |\ (_) /| |   | | || || | (__    
   | |(_)| |  __)  | | ____|  ___  | \   / | |   | | |(_)| |  __)   
   | |   | | (     | | \_  ) (   ) |  ) (  | |   | | |   | | (      
   | )   ( | (____/\ (___) | )   ( |  | |  | (___) | )   ( | (____/\
   |/     \(_______(_______)/     \|  \_/  (_______)/     \(_______/
                                                                    
                    -= SEGA MEGA DRIVE EMULATOR =-
                    ------------------------------

MegaYume is a SEGA Mega Drive / Genesis emulator for
Parallax P2 micro-controllers with appropriate memory expansions
(Currently supported: HyperRAM, 4xQPI PSRAM, 1x QPI PSRAM).
(ROMs up to 128k can also be run without a memory expansion)

MegaYume is alpha-quality software and is currently a bit clunky to use.
A built-in SD card ROM loading GUI for standalone usage and a less clunky
configuration system are planned.

Features include:
  - Low latency framebuffer-less high-level emulation
  - Pretty decent FM sound
  - 6 button controller support
  - Video output over VGA, HDMI, S-video or Composite
  - USB Keyboard input (easy to hack in other devices)
  - Buuuuggggssss!!

See the issues section of this GitHub repository for known issues.


  -= HOW TO USE =-
  ----------------

- Make sure prerequisites are installed:
  - flexspin (current version as of writing: 5.7.9)
  - loadp2
  - ruby (2.6 or newer)

- Configure A/V output and USB pins in megayume_upper.spin2

- Configure machine settings and memory configuration in megayume_lower.spin2

- Search for "PSRAM as ROM", "HyperRAM as ROM" and "HUB RAM as ROM" in 
  megayume_lower.spin2 and make sure only the blocks corresponding to
  your memory type are enabled. Note that some blocks are common between
  the 4 bit and 16 bit PSRAM setups

- If using "HUB RAM as ROM", go to the bottom of megayume_lower.spin2 and
  add your ROM as a FILE-include after "fake_rom". Make sure only one FILE
  is active.
- Run "./build.sh"

- If using HyperRAM or PSRAM on nonstandard pins,
  (ie. not HyperRAM on 0..15 or PSRAM on 40..57)
  edit the appropriate loader to fit.
  HyperRAM -> memstuff/hyper_loadit.spin2
  PSRAM 16bit -> memstuff/psram_loadit.spin2
  PSRAM4 16bit -> memstuff/psram4_loadit.spin2

- If NOT using "HUB RAM as ROM",
  run "ruby loadit.rb --hyper -p COMx your_game_rom.bin"
  "COMx" is your P2's serial port. Omit the "--hyper" if using PSRAM.
  Use "--4bit" instead if using 4 bit PSRAM.

- Start emulation using "loadp2 -p COMx megayume_lower.binary"

- Enjoy the game! (Or not, if it's broken....)


  -= FILES =-
  -----------

megayume_lower.spin2  - Assembly language emulation core (68000,Z80,VDP,Audio,glue)
megayume_upper.spin2  - Spin2 upstart code (also, currently, input mapping)
MegaVGA.spin2  - Custom video driver
1CogKbM_rja3b.spin2  - USB Keyboard driver
OPN2_ROM.DAT  - YM2612 quarter-sine and antilog ROM
CRAM2RGB.DAT  - CRAM to truecolor expansion table
cram_tablegen.rb  - Can generates the above
build.sh  - Standard build script
build_gbrk.sh  - Build script for core debugging
memstuff  - Various things to do with external memory


