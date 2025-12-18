# Add local directories to path, if available.
if [ -d /Users/russ/local/gcc-arm-none-eabi-latest/bin ]; then
      PATH=$PATH:/Users/russ/local/gcc-arm-none-eabi-latest/bin
fi
if [ -d /Users/russ/Trango/nordic_sdk/nRF-Command-Line-Tools_latest/mergehex ]; then
      PATH=$PATH:/Users/russ/Trango/nordic_sdk/nRF-Command-Line-Tools_latest/mergehex
fi
if [ -d /Users/russ/Trango/nordic_sdk/nRF-Command-Line-Tools_latest/nrfjprog ]; then
      PATH=$PATH:/Users/russ/Trango/nordic_sdk/nRF-Command-Line-Tools_latest/nrfjprog
fi
if [ -d /Users/russ/Trango/flutter/bin ]; then
      PATH=$PATH:/Users/russ/Trango/flutter/bin
fi
export PATH
