Video driver configuration
--------------------------

The video driver used in MegaYume supports many different output formats with different sub-modes.

There are 6 variables to control this:

- `VIDEO_MODE` selects the broad output type
- `VIDEO_SUBMODE` selects a sub-variant. Can be `SUBMODE_AUTO` to select the default.
- `ANALOG_BASEPIN` determines which pins the analog output is sent to (this must be a multiple of 4)
- `VSYNC_PIN` determines where VSync goes (for modes that have it)
- `DIGITAL_BASEPIN` determines which pins the digital output is sent to (this must be a multiple of 8)
- `DIGITAL_REVERSED` sets if digital TMDS signalling should use reverse pin order

## MODE_HDMI

Digital HDMI output with embedded audio. 8 TMDS signals are sent to `DIGITAL_BASEPIN`.

HDMI audio packet generation is semi-experimental, please report if it works or doesn't work for you.

Supported submodes are:
- `SUBMODE_TMDS_640x480` standard 4:3 signal (default)
- `SUBMODE_TMDS_768x480` extra horizontal padding for 16:10 monitors
- `SUBMODE_TMDS_800x480` extra horizontal padding for certain LCD panels
- `SUBMODE_TMDS_854x480` extra horizontal padding for 16:9 monitors

(Older versions of NeoYume used to default to 800x480)

## MODE_DVI

Same as `MODE_HDMI`, but using plain DVI signalling (no data islands or guard bands)

## MODE_HDMI_VGA / MODE_DVI_VGA

Same as the the above, but with simultaneous analog output. The analog timing is off-spec, so this is not very useful.

## MODE_VGA / MODE_RGBHV

Analog RGB output with separate sync signals. HSync, R, G and B are sent, in that order, to four pins at `ANALOG_BASEPIN`. VSync is sent to `VSYNC_PIN`.

Supported submodes are `SUBMODE_1X` through `SUBMODE_5X`, corrosponding to different scaling settings. The default `SUBMODE_2X` results in a standard 640x480 signal.

## MODE_RGBS

Analog RGB output with composite sync. CSync, R, G and B are sent, in that order, to four pins at `ANALOG_BASEPIN`.

Everything else is the same as `MODE_VGA`

## MODE_SoG

Analog RGB output with Sync-On-Green. R, G and B are sent, in that order, to three pins at `ANALOG_BASEPIN` **+ 1**.

Everything else is the same as `MODE_VGA`

## MODE_YPBPR

Analog YPbPr output. Pr, Y and Pb are sent, in that order, to three pins at `ANALOG_BASEPIN` **+ 1**.

This supports the same scaling modes as `MODE_VGA`, but additionally allows overriding the color space with `SUBMODE_FORCE_REC601` and `SUBMODE_FORCE_REC709`. By default Rec. 601 is used for 1X and 2X, Rec. 709 above that.

## MODE_COMPOSITE

Analog composite video. This can be sent to any `ANALOG_BASEPIN` (does not need to be a multiple of 4).

Supports `SUBMODE_NTSC` (default) and `SUBMODE_PAL`. The latter is infact PAL60.

## MODE_SVIDEO 

Analog S-Video. Luma and Chroma are sent, in that order, to two pins at `ANALOG_BASEPIN`.

Everything else is the same as `MODE_COMPOSITE`

## MODE_SVID_AND_COMP 

Analog S-Video and composite simultaneously. Luma, Chroma and Composite are sent, in that order, to three pins at `ANALOG_BASEPIN`.

Everything else is the same as `MODE_COMPOSITE`

## MODE_LCD6

6-bit digital output for ILI9342-based LCD screen.

**TODO**

## Note on interlace mode

A few Megadrive games (notable: 2-player vs. mode in _Sonic 2_) use the system's interlaced mode. In modes using native 15kHz timing (except `MODE_RGBHV`), this is implemented as real interlacing. In all upscaling modes, this is implemented as "Bob" deinterlacing. `MODE_RGBHV` with `SUBMODE_1X` currently does not support interlace properly.

