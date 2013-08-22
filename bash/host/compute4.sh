# bash setting for host compute4

alias ss=/apps/smartsvn/latest/bin/smartsvn.sh

# Source the Sankhya Tools (only do before Forte setup, not after):
. /apps/scripts/stc.sh

# Source the Forte Tools:
. /apps/scripts/forte.sh > /dev/null

# Source the Xilinx Tools:
. /apps/scripts/xilinx.sh > /dev/null

# Coverage setup
. /apps/scripts/jeda_1_3_3.sh > /dev/null

# Mentor Questa setup
. /apps/scripts/mentor.sh > /dev/null

