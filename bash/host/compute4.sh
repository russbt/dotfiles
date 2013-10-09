# bash setting for host compute4

alias ss=/apps/smartsvn/latest/bin/smartsvn.sh

# Don't set up tools when in a non-interactive shell, so they can be updated per-window
if [ "$RUSS_INTERACTIVE" = "TRUE" ]; then
  # Source the Sankhya Tools (only do before Forte setup, not after):
  #. /apps/scripts/stc.sh

  # Source the Forte Tools:
  #. /apps/scripts/forte.sh > /dev/null

  # Source the SystemC configuration:
  . /apps/scripts/systemc.sh > /dev/null

  # Source the Xilinx Tools:
  . /apps/scripts/xilinx.sh > /dev/null

  # Misc useful tools
  . /apps/scripts/others.sh > /dev/null

  # SysC coverage setup
  #. /apps/scripts/jeda_1_3_3.sh > /dev/null

  # Mentor Questa setup
  . /apps/scripts/mentor.sh > /dev/null
  export XIL_LIBS_PATH=/apps/common/xilinx_libs/questa_${_QUESTA_VERSION}/${_XILINX_VERSION}_libs
  export MODELSIM=/apps/common/xilinx_libs/modelsim.ini
fi
