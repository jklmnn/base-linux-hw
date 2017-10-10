SRC_CC += lx_hybrid.cc new_delete.cc capability_space.cc
SRC_CC += signal_transmitter.cc signal.cc

vpath new_delete.cc $(BASE_DIR)/src/lib/cxx
vpath lx_hybrid.cc   $(BLX_DIR)/src/lib/lx_hybrid

# add parts of the base library that are shared with core
LIBS += base-linux-common timeout

# non-core parts of the base library (except for the startup code)
include $(BLX_DIR)/lib/mk/base-linux.inc
