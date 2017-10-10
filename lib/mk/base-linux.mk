#
# \brief  Base lib parts that are not used by hybrid applications
# \author Sebastian Sumpf
# \date   2014-02-21
#

BLX_DIR = $(shell sed "s/base-linux-hw/base-linux/g" <<< $(REP_DIR))
include $(BLX_DIR)/lib/mk/base-linux.inc

LIBS   += startup-linux base-linux-common cxx
SRC_CC += thread.cc thread_myself.cc thread_linux.cc
SRC_CC += capability_space.cc capability_raw.cc
SRC_CC += attach_stack_area.cc
SRC_CC += signal_transmitter.cc signal.cc
