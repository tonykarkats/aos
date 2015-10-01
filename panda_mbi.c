#include <assert.h>
#include <stdio.h>
#include <stdint.h>
#include <stddef.h>
#include <string.h>
#include <barrelfish_kpi/types.h>
#include <errors/errno.h>
#include <elf/elf.h>
#include "../kernel/include/multiboot.h"
extern char _binary___armv7_sbin_cpu_omap44xx_start;
extern char _binary___armv7_sbin_cpu_omap44xx_end;
extern char _binary___armv7_sbin_cpu_omap44xx_start;
extern char _binary___armv7_sbin_cpu_omap44xx_end;
extern char _binary___armv7_sbin_init_start;
extern char _binary___armv7_sbin_init_end;
static uint32_t mbi_mmap0[] = {0x80000000, 0x40000000, 1};
static struct multiboot_modinfo mbi_mods[3];
static struct multiboot_mmap mbi_mmaps[1];
static struct multiboot_info mbi;

struct multiboot_info *molly_get_mbi(void) {
memset(&mbi, 0, sizeof(struct multiboot_info));
memset(&mbi_mods, 0, sizeof(mbi_mods));
memset(&mbi_mmaps, 0, sizeof(mbi_mmaps));
  mbi.flags |= MULTIBOOT_INFO_FLAG_HAS_CMDLINE;
  mbi.flags |= MULTIBOOT_INFO_FLAG_HAS_MODS;
  mbi.flags |= MULTIBOOT_INFO_FLAG_HAS_ELF_SYMS;
  mbi.flags |= MULTIBOOT_INFO_FLAG_HAS_MMAP;
  mbi.cmdline = (uint32_t) "/armv7/sbin/cpu_omap44xx loglevel=4";
  mbi.mods_count = 3;
  mbi.mods_addr = (uint32_t) mbi_mods;
  mbi_mods[0].mod_start = (uint32_t) &_binary___armv7_sbin_cpu_omap44xx_start;
  mbi_mods[0].mod_end = (uint32_t) &_binary___armv7_sbin_cpu_omap44xx_end;
  mbi_mods[0].string = (uint32_t)"/armv7/sbin/cpu_omap44xx loglevel=4";
  mbi_mods[1].mod_start = (uint32_t) &_binary___armv7_sbin_cpu_omap44xx_start;
  mbi_mods[1].mod_end = (uint32_t) &_binary___armv7_sbin_cpu_omap44xx_end;
  mbi_mods[1].string = (uint32_t) "/armv7/sbin/cpu_omap44xx ";
  mbi_mods[2].mod_start = (uint32_t) &_binary___armv7_sbin_init_start;
  mbi_mods[2].mod_end = (uint32_t) &_binary___armv7_sbin_init_end;
  mbi_mods[2].string = (uint32_t) "/armv7/sbin/init ";
  mbi.mmap_length = sizeof(mbi_mmaps);
  mbi.mmap_addr = (uint32_t) mbi_mmaps;
  mbi_mmaps[0].size = sizeof(struct multiboot_mmap);
  mbi_mmaps[0].base_addr = mbi_mmap0[0];
  mbi_mmaps[0].length = mbi_mmap0[1];
  mbi_mmaps[0].type = (int)mbi_mmap0[2];
  return &mbi;
}

