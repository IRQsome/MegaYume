MegaYume external memory configuration
-------------------------------------

Configuring the external memory settings is a bit tricky, so here is a detailed explanation of what each setting does and known-good values for particular hardware configurations.

## Known-good configs

Note that these are specific to MegaYume. Note that MegaYume uses slightly different clock speeds depending on video mode, so a timing that just barely works in one mode might not in another.

### P2EDGE 32MB

Since this is the most common config, these are the default values in config.spin2.

```spin
' Enable one of these to select the exmem type to use
#define USE_PSRAM16
'#define USE_PSRAM8
'#define USE_PSRAM4
'#define USE_HYPER

PSRAM_CLK = 56
PSRAM_SELECT = 57
PSRAM_BASE = 40
PSRAM_BANKS = 1 ' Only used to stop further banks from interfering

PSRAM_WAIT  = 5
PSRAM_DELAY = 13
PSRAM_SYNC_CLOCK = false
PSRAM_SYNC_DATA = false

' Uncomment for slower memory clock
'#define USE_PSRAM_SLOW
```

### Rayslogic 96MB PSRAM board (on P2EVAL, basepin 0)

```spin
' Enable one of these to select the exmem type to use
'#define USE_PSRAM16
#define USE_PSRAM8
'#define USE_PSRAM4
'#define USE_HYPER

' For PSRAM (either type)
PSRAM_CLK = 8 addpins 1
PSRAM_SELECT = 10
PSRAM_BASE = 0
PSRAM_BANKS = 6 ' Only used to stop further banks from interfering

PSRAM_WAIT  = 5
PSRAM_DELAY = 17
PSRAM_SYNC_CLOCK = true
PSRAM_SYNC_DATA = true

' Uncomment for slower memory clock
#define USE_PSRAM_SLOW
```

### Rayslogic 24MB PSRAM board (on P2EVAL, basepin 48)

```spin
' Enable one of these to select the exmem type to use
'#define USE_PSRAM16
'#define USE_PSRAM8
#define USE_PSRAM4
'#define USE_HYPER

' For PSRAM (either type)
PSRAM_CLK = 48+4
PSRAM_SELECT = 48+5
PSRAM_BASE = 48
PSRAM_BANKS = 3 ' Only used to stop further banks from interfering

PSRAM_WAIT  = 5
PSRAM_DELAY = 15
PSRAM_SYNC_CLOCK = true
PSRAM_SYNC_DATA = true

' Uncomment for slower memory clock
'#define USE_PSRAM_SLOW
```

### Parallax HyperBus accessory (on P2EVAL, basepin 0)

```spin
' Enable one of these to select the exmem type to use
'#define USE_PSRAM16
'#define USE_PSRAM8
'#define USE_PSRAM4
#define USE_HYPER

' For HyperRAM
HYPER_ACCESSORY = 0 ' Base pin for P2EVAL HyperRAM board
HYPER_CLK    =  8+HYPER_ACCESSORY
HYPER_RWDS   = 10+HYPER_ACCESSORY
HYPER_SELECT = 12+HYPER_ACCESSORY
HYPER_BASE   =  0+HYPER_ACCESSORY
HYPER_RESET  = 15+HYPER_ACCESSORY

HYPER_WAIT  = 22
HYPER_DELAY = 13
HYPER_SYNC_CLOCK = false
HYPER_SYNC_DATA = false
```

## Configurable Values

### USE_PSRAM4 / USE_PSRAM8 / USE_PSRAM16 / USE_HYPER

One of these defines must be enabled to select the RAM type and bus width used (and thus the number of RAM chips in parallel).
 USE_PSRAM4 -> single PSRAM chip
 USE_PSRAM16 -> quad PSRAM chips
 USE_HYPER -> single HyperRAM chip

### PSRAM_CLK

PSRAM clock output pin. This can be any pin (and if needed, 3 additional clock pins may be added using addpins syntax).

### PSRAM_SELECT

PSRAM select pin. This can be any pin.

### PSRAM_BANKS

Number of PSRAM banks to use. The second bank will use PSRAM_SELECT **+ 1** as its select pin (and so on for the third, etc).
Note that in any case, MegaYume only requires one bank, any additional ones will not be used.

### PSRAM_BASE

PSRAM data bus base pin. This must be a multiple of 8 (or 4 if USE_PSRAM4) and the data pins must be connected to this in order.

### PSRAM_WAIT

Number of data bit periods between address send and data return. **Leave this value at 5 unless you have a different type of memory chip.**

### PSRAM_DELAY

Read delay compensation in P2 machine cycles. Try changing this value if you have problems.

### PSRAM_SYNC_DATA

Enables `P_SYNC_IO` mode on the data bus. This is a sort-of "half step backwards" for PSRAM_DELAY and should be adjusted alongside it.

### PSRAM_SYNC_CLOCK

Enables `P_SYNC_IO` mode on the clock pin. This is a further timing adjustment. In most cases you can leave it on true.

### USE_PSRAM_SLOW

Enables a slower bus speed (CPU clock divided by 3 instead of 2). This is useful for setups with a large number of banks.

### READBACK_TEST

If enabled, the machine type (i.e. the "SEGA GENESIS"/"SEGA MEGADRIVE") string from the ROM is displayed on screen before a game starts. This is for debugging memory timing issues that stem from the disconnect between the memory driver code used by upper and lower code. If the lower code can't correctly read from RAM, the game will simply not run, whereas read failures for upper code will result in more nuanced failure. If in doubt, try playing a game with a saving feature. If MegaYume fails to create/open the save file, it has failed to identify the ROM header (or the header doesn't properly declare the SRAM)
