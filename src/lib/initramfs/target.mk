TARGET = lx_init
SRC_C  = init.c
INC_DIR += /usr/include/\
	   /usr/include/x86_64-linux-gnu/
CUSTOM_CC = gcc
CFLAGS = -static -march=native -std=gnu99
LDFLAGS = 
