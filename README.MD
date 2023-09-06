<h1 align="center">MegaYume
<p>
<sub>-= SEGA MEGA DRIVE EMULATOR =-</sub>
</p>
</h1>

MegaYume is a SEGA Mega Drive / Genesis emulator for
Parallax P2 micro-controllers with appropriate memory expansions
(Currently supported: HyperRAM, 4xQPI PSRAM, 2xQPI PSRAM, 1x QPI PSRAM).

Features include:
  - Low latency framebuffer-less high-level emulation
  - Pretty decent FM sound
  - 6 button controller support
  - SRAM save support
  - Video output over VGA, HDMI, YPbPr, S-video, Composite or 6bit RGB bus (ILI9342 LCD)
  - Low-latency USB input (Keyboard and gamepads, see below) or direct hookup to discrete switches.

See the issues section of this GitHub repository for known issues.


Forum thread, chronicalling development and other interesting info: https://forums.parallax.com/discussion/173381/console-emulation/p1


## Usage

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

## USB Controllers

Many different kinds of USB controller are supported. For multiplayer, a USB Hub must be used.

The default input map is as follows:

|MegaDrive button|Keyboard (QWERTY)|Generic Gamepad|XInput / PS3       |RetroBit 6-button|Neo Geo mini     |
|---------------:|:----------------|:--------------|:------------------|:----------------|:----------------|
|Directions      |Arrow Keys       |X/Y axes or Hat|Left stick or D-Pad|D-Pad            |D-Pad            |
|A               |X                |Button 4       |X / Square         |A                |A                |
|B               |C                |Button 3       |A / Cross          |B                |B                |
|C               |V                |Button 2       |B / Circle         |C                |D                |
|Start           |Enter            |Button 10      |Start / Start      |Start            |Start            |
|X               |S                |Button 5       |LT / L2            |X                |_N/A_            |
|Y               |D                |Button 1       |Y / Triangle       |Y                |_N/A_            |
|Z               |F                |Button 6       |RT / R2            |Z                |_N/A_            |
|Mode            |A                |Button 9       |Select / Select    |Mode (or Start+X)|_N/A_            |


Gamepad maps can be user configured through a `PADMAP.TXT` file placed in the SD card root.

Each line may have the following format:
```
megayume <VID and PID> <Y> <C> <B> <A> <X> <Z> <ignored> <ignored> <Mode> <Start> # <Comment>
```

For example:
```
megayume 20D6A713   4  3  2  1  5  6  7  8  9  10 # PowerA Switch controller
```

A mapping is detected as a 6-button controller if X, Y and Z are all mapped.

Mappings for the NeoGeo mini controller (ID 0E6F1112) and RetroBit USB controllers (ID 0F0D00C1) are built-in to MegaYume, but can still be overridden using a PADMAP.TXT rule.

For more information, see [the usbnew documentation](https://github.com/Wuerfel21/usbnew/wiki/PADMAP.TXT-Format-and-the-reference-gamepad).

Keyboard controls can currently not be reconfigured (except by editing the source code). The keyboard always controls Player 1, independently of any connected game controllers.

MegaYume uses a modified version of usbnew for usb input support, see [the usbnew wiki](https://github.com/Wuerfel21/usbnew/wiki) for info on further information on device compatibility.


## Project Files

|||
|-|-|
|`config.spin2`|User config include file|
|`RAMCONFIG.MD`|External memory configuration guide|
|`build.sh`|Standard build script|
|`build_gbrk.sh`|Build script for core debugging|
|`build_comptest.sh`|Build script for compiler testing|
|`megayume_lower.spin2`|Assembly language emulation core (68000,Z80,VDP,Audio,glue)|
|`megayume_upper.spin2`|Spin2 upstart code and GUI|
|`fsadapter.c`|File system helper functions|
|`MegaVGA.spin2`|Custom video driver|
|`usbnew.spin2`|USB Input driver|
|`padmap_parser.spin2`|PADMAP.TXT parser|
|`OPN2_ROM.DAT`|YM2612 quarter-sine and antilog ROM|
|`CRAM2RGB.DAT`|CRAM to truecolor expansion table|
|`cram_tablegen.rb`|Can generate the above|
|`padmap_builtin.dat`|Compiled builtin gamepad maps|
|`padmap_builtin.rb`|Can generate the above|
|`FUNSCII.DAT`|main UI font (funscii 8x8)|
|`MISAKI4W.DAT`|JIS font, half-width part (Misaki Gothic 2nd)|
|`MISAKI8W.DAT`|JIS font, full-width part (Misaki Gothic 2nd)|
|`memstuff`|Various (mostly outdated) things to do with external memory|
