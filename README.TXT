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
(Currently supported: HyperRAM, 4xQPI PSRAM, 2xQPI PSRAM, 1x QPI PSRAM).

Features include:
  - Low latency framebuffer-less high-level emulation
  - Pretty decent FM sound
  - 6 button controller support
  - SRAM save support
  - Video output over VGA, HDMI, YPbPr, S-video, Composite or 6bit RGB bus (ILI9342 LCD)
  - USB input (Keyboard and select gamepads, see below) or direct hookup to discrete switches.
  - Buuuuggggssss!!

See the issues section of this GitHub repository for known issues.


Forum thread, chronicalling development and other interesting info: https://forums.parallax.com/discussion/173381/console-emulation/p1


  -= HOW TO USE =-
  ----------------

- Make you have flexspin 6.1.6 or newer installed

- Configure memory type, pinouts and video mode in "config.spin2".
  In particular, read RAMCONFIG.MD for more info on.. uh.. RAM config.
  
- Run "build.sh".

- Load the compiled "megayume_lower.binary"

- Select your game ROM from the SD listing. If present, a "MEGAYUME" directory
  on the SD root will be opened by default.

- Enjoy the game! (Or not, if it's broken....)

- When playing a game with a save feature,
  wait at least 5 seconds for the save to be flushed to disk before powering off.
  Returning to the selection screen is always safe.

- You may return to the game selection by holding Start+Down for a few seconds or hitting Ctrl+Esc
- You may RESET the game by holding Start+Up for a few seconds or hitting Ctrl+R
- You may freeze the CPU by hitting Pause/Break - this is a debugging feature and may mess things up.


If you want to download some freeware ROMs to play around with, here's a couple:

 - Bad Apple demo: https://www.dropbox.com/s/waa4c2cje0tegon/BadApple.bin?dl=1
 - Cave Story MD: https://github.com/andwn/cave-story-md
 - L'Abbaye des Morts: https://playonretro.itch.io/labbaye-des-morts-megadrivegenesis-por-002
 - Old Towers: https://retrosouls.itch.io/old-towers
 - Alter Ego: https://retrosouls.itch.io/alterego16bit
 - Runes: https://cannibalcat.itch.io/runes
 - 240p Test Suite (test pattern generator): https://artemiourbina.itch.io/240p-test-suite

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

  -= NOTES ON USB INPUT =-
  ------------------------

Supported USB input devices are:
 - Any normal Keyboard (6KRO/boot protocol)
 - Generic XInput controllers (possibly also real wired Xbox360 controllers)
 - RetroBit SEGA Saturn/Megadrive USB controller (PID 0x0011 VID 0x0079)
 - NeoGeo mini controller (PID 0x1112 VID 0x0E6F) (3-button only - C/d both map to C)

Keyboard map:
| Keyboard   | MegaDrive        |
|:----------:|:----------------:|
| Arrow Keys | D-Pad (Player 1) |
|          X | A     (Player 1) |
|          C | B     (Player 1) |
|          V | C     (Player 1) |
|          S | X     (Player 1) |
|          D | Y     (Player 1) |
|          F | Y     (Player 1) |
|      Enter | Start (Player 1) |
|          A | Mode  (Player 1) |
|       Num5 | Up    (Player 2) |
|       Num2 | Down  (Player 2) |
|       Num1 | Left  (Player 2) |
|       Num3 | Right (Player 2) |
|          M | A     (Player 2) |
|          , | B     (Player 2) |
|          . | C     (Player 2) |
|          J | X     (Player 2) |
|          K | Y     (Player 2) |
|          L | Y     (Player 2) |
|   NumEnter | Start (Player 2) |
|          H | Mode  (Player 2) |


