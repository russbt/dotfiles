# bash setting for host compute4

#alias ss=/apps/smartsvn/latest/bin/smartsvn.sh

# Add local directories to path, if available (PATH will be exported in top-level bashrc)
if [ -d /Users/russ/local/gcc-arm-none-eabi-latest/bin ]; then
      PATH=$PATH:/Users/russ/local/gcc-arm-none-eabi-latest/bin
fi
if [ -d /Users/russ/Trango/nordic_sdk/nRF-Command-Line-Tools_latest/mergehex ]; then
      PATH=$PATH:/Users/russ/Trango/nordic_sdk/nRF-Command-Line-Tools_latest/mergehex
fi
if [ -d /Users/russ/Trango/nordic_sdk/nRF-Command-Line-Tools_latest/nrfjprog ]; then
      PATH=$PATH:/Users/russ/Trango/nordic_sdk/nRF-Command-Line-Tools_latest/nrfjprog
fi

# Don't set up tools when in a non-interactive shell, so they can be updated per-window
#if [ "$RUSS_INTERACTIVE" = "TRUE" ]; then
  #export MODELSIM=/apps/common/xilinx_libs/modelsim.ini
#fi
