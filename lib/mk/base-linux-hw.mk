#
# \brief  Base lib parts that are not used by hybrid applications
# \author Sebastian Sumpf
# \date   2014-02-21
#

BLX_DIR = $(shell sed "s/base-linux-hw/base-linux/g" <<< $(REP_DIR))
INC_DIR += $(BLX_DIR)/src/include \
	   $(BLX_DIR)/src/lib/syscall

include $(REP_DIR)/lib/mk/base-linux-hw.inc

LIBS   += startup-linux-hw base-linux-hw-common cxx
SRC_CC += thread.cc thread_myself.cc thread_linux.cc
SRC_CC += capability_space.cc capability_raw.cc
SRC_CC += attach_stack_area.cc
SRC_CC += signal_transmitter.cc signal.cc

vpath %.cc $(BLX_DIR)/src/lib/base
