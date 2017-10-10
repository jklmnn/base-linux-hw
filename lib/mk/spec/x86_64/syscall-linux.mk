REQUIRES = linux-hw x86
SRC_S   += lx_clone.S lx_restore_rt.S lx_syscall.S

vpath lx_restore_rt.S $(BLX_DIR)/src/lib/syscall/spec/x86_64
vpath lx_clone.S      $(BLX_DIR)/src/lib/syscall/spec/x86_64
vpath lx_syscall.S    $(BLX_DIR)/src/lib/syscall/spec/x86_64

