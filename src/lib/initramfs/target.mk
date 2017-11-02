TARGET = lx_init

INITRAMFS = initramfs
INITRAMFS_SRC_C = init.c

EXT_OBJECTS += $(BUILD_BASE_DIR)/lib/initramfs/$(INITRAMFS)

$(TARGET): $(INITRAMFS)

$(INITRAMFS): $(INITRAMFS_SRC_C)
	$(MSG_BUILD)$(INITRAMFS)
	$(VERBOSE)gcc $^ -Ofast $(CC_MARCH) -Wall -W -Wextra -Werror -std=gnu99 -o $@ -Wl,-O3 -Wl,--as-needed -static

clean_initramfs:
	$(VERBOSE)rm -rf $(INITRAMFS)

clean: clean_initramfs

vpath init.c $(PRG_DIR)
