set -e # Enable error reporting
rm megayume_lower.binary || true
flexspin -2 -E -H 327680 -O1,extrasmall,inline-single --fcache=128 --charset=shiftjis -DFF_FS_TINY=1 -DFF_FS_NORTC=1  megayume_upper.spin2
flexspin -2 -l megayume_lower.spin2
