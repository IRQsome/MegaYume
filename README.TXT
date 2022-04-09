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

MegaYume is beta-quality software, please keep that in mind.

Features include:
  - Low latency framebuffer-less high-level emulation
  - Pretty decent FM sound
  - 6 button controller support
  - Video output over VGA, HDMI, S-video or Composite
  - USB Keyboard input (somewhat easy to hack in other devices)
  - Buuuuggggssss!!

See the issues section of this GitHub repository for known issues.


  -= HOW TO USE =-
  ----------------

- Make you have flexspin 5.9.10 or newer installed

- Configure memory type, pinouts and video mode in "config.spin2".
  In particular, if you have problems that seem to be related to memory,
  try tweaking the PSRAM_DELAY or HYPER_DELAY value
  
- Run "build.sh".

- Load the compiled "megayume_lower.binary"

- Select your game ROM from the SD listing. If present, a "MEGAYUME" directory
  on the SD root will be opened by default.

- Enjoy the game! (Or not, if it's broken....)


  -= FILES =-
  -----------

config.spin2  - User config include file
megayume_lower.spin2  - Assembly language emulation core (68000,Z80,VDP,Audio,glue)
megayume_upper.spin2  - Spin2 upstart code and GUI
fsadapter.c  - File system helper functions
MegaVGA.spin2  - Custom video driver
1CogKbM_rja3b.spin2  - USB Keyboard driver
OPN2_ROM.DAT  - YM2612 quarter-sine and antilog ROM
CRAM2RGB.DAT  - CRAM to truecolor expansion table
cram_tablegen.rb  - Can generates the above
build.sh  - Standard build script
build_gbrk.sh  - Build script for core debugging
memstuff  - Various things to do with external memory


