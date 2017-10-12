TARGET        = core-linux-hw
REQUIRES      = linux-hw
LIBS          = cxx base-linux-hw-common syscall-linux-hw startup-linux

BLX_DIR = $(shell sed "s/base-linux-hw/base-linux/g" <<< $(REP_DIR))

INC_DIR += $(BLX_DIR)/src/include

