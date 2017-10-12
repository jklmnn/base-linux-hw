#
# \brief  Portions of base library shared by core and non-core processes
# \author Norman Feske
# \date   2013-02-14
#

BLX_DIR = $(shell sed "s/base-linux-hw/base-linux/g" <<< $(REP_DIR))
INC_DIR += $(BLX_DIR)/src/include \
	   $(BLX_DIR)/src/lib/syscall


include $(BASE_DIR)/lib/mk/base-common.inc

LIBS += syscall-linux-hw

SRC_CC += region_map_mmap.cc debug.cc
SRC_CC += rpc_dispatch_loop.cc
SRC_CC += thread_env.cc
SRC_CC += capability.cc

vpath %.cc $(BLX_DIR)/src/lib/base

