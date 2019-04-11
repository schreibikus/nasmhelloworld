
NASM=C:\Program Files\NASM\nasm.exe
export PATH:=C:\Program Files (x86)\CodeBlocks\MinGW\bin;$(PATH)
CC=C:\Program Files (x86)\CodeBlocks\MinGW\bin\gcc.exe

ifeq ($(MAKECMDGOALS),Debug)
BUILD_PATH := bin\Debug
else
BUILD_PATH := bin\Release
endif

TARGET := $(BUILD_PATH)\HelloWorld.exe

ASM_SOURCES:=$(wildcard src/[^~]*.asm)
ASM_OBJECTS:=$(patsubst src/%.asm,$(BUILD_PATH)/%.obj,$(ASM_SOURCES))

Debug:all
Release:all

all: $(TARGET)

$(BUILD_PATH)/%.obj:src/%.asm
		@echo Assemble $< to $@
		$(shell if not exist $(BUILD_PATH) mkdir $(BUILD_PATH))
		@$(NASM) -fwin32 -o $@ $<

$(TARGET):$(ASM_OBJECTS)
		@echo Linking $@ from $(ASM_OBJECTS) sources $(ASM_SOURCES)
		@$(CC) -o $@ $(ASM_OBJECTS)

.PHONY: clean cleanDebug cleanRelease

cleanDebug: clean
cleanRelease: clean

clean:
		@echo Clean project
		$(shell if exist bin rmdir /s /q bin)
