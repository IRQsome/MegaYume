set -e # Enable error reporting
rm megayume_lower.binary || true
../spin2cpp/build/flexspin -2 -E -H 327680 -O1,extrasmall,inline-single,experimental,aggressive-mem,merge-duplicate-functions --fcache=128 --charset=shiftjis -DFF_FS_TINY=1 -DFF_FS_NORTC=1 megayume_upper.spin2
../spin2cpp/build/flexspin -2 -l --compress megayume_lower.spin2
