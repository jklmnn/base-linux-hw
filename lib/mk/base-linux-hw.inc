#
# The content of this file is used for both native Genode as well as hybrid
# Linux/Genode programs. Hence, it must be void of any thread-related code.
#

BLX_DIR = $(shell sed "s/base-linux-hw/base-linux/g" <<< $(REP_DIR))

vpath %.cc $(BLX_DIR)/src/lib/base

include $(BASE_DIR)/lib/mk/base.inc

SRC_CC += platform_env.cc

LIBS += syscall-linux-hw
