OUTPUT_FORMAT("elf32-littlearm")
OUTPUT_ARCH("arm")
ENTRY(start)
SECTIONS {
        . = 0x100000;
        kernel_first_byte = .;
        .text : { *(.text); }
        kernel_text_final_byte = .;
        . = ALIGN(4k);
        .rodata . :
        {
                *(.rodata);
        }
        .got . :
        {
                got_base = .;
                *(.got);
        }
        .bss . :
        {
                *(.bss);
        }
        kernel_final_byte = .;
        /DISCARD/ :
        {
                *(.eh_frame);
                *(.eh_frame_hdr);
  *(.note.gnu.build-id);
                *(.interp);
              *(.dynamic);
        }
}
