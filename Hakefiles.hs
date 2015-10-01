module Hakefiles where {
import RuleDefs;
import HakeTypes;
import Path;
import Args;
import qualified Config;
import qualified Data.List;
allfiles = ["./menu.lst.aos","./Hakefiles.hs","./Makefile","./README_NETWORKING","./aos_image","./panda_mbi.c","./LICENSE","./tags","./AUTHORS","./.marker","./milestone0_test_image","./symbolic_targets.mk","./README","./include/limits.h","./include/k_r_malloc.h","./include/omap44xx_map.h","./include/time.h","./include/cpiobin.h","./include/Hakefile","./include/semaphore.h","./include/fcntl.h","./include/values.h","./include/zlib.h","./include/unistd.h","./include/stdio_file.h","./include/termios.h","./include/utime.h","./include/zconf.h","./include/posixcompat.h","./include/x86emu.h","./include/nl_types.h","./include/strings.h","./include/libgen.h","./include/multicast.h","./include/netdb.h","./include/grp.h","./include/dlfcn.h","./include/signal.h","./include/acpi_client/acpi_client.h","./include/barrelfish_kpi/legacy_idc_buffer.h","./include/barrelfish_kpi/cpu.h","./include/barrelfish_kpi/dispatcher_shared.h","./include/barrelfish_kpi/types.h","./include/barrelfish_kpi/sys_debug.h","./include/barrelfish_kpi/syscalls.h","./include/barrelfish_kpi/domain_params.h","./include/barrelfish_kpi/dispatcher_handle.h","./include/barrelfish_kpi/init.h","./include/barrelfish_kpi/lmp.h","./include/barrelfish_kpi/vmkit.h","./include/arch/ia64","./include/arch/powerpc","./include/arch/cc.h","./include/arch/sys_arch.h","./include/arch/mips","./include/arch/perf.h","./include/arch/sparc64","./include/arch/scc/barrelfish/bulk_transfer_arch.h","./include/arch/scc/barrelfish/cpu_arch.h","./include/arch/x86_32/float.h","./include/arch/x86_32/_fpmath.h","./include/arch/x86_32/fenv.h","./include/arch/x86_32/barrelfish_kpi/spinlocks_arch.h","./include/arch/x86_32/barrelfish_kpi/shared_mem_arch.h","./include/arch/x86_32/barrelfish_kpi/dispatcher_shared_arch.h","./include/arch/x86_32/barrelfish_kpi/generic_arch.h","./include/arch/x86_32/barrelfish_kpi/asm_inlines_arch.h","./include/arch/x86_32/barrelfish_kpi/pic_arch.h","./include/arch/x86_32/barrelfish_kpi/eflags_arch.h","./include/arch/x86_32/barrelfish_kpi/registers_arch.h","./include/arch/x86_32/barrelfish_kpi/lmp_arch.h","./include/arch/x86_32/barrelfish_kpi/syscall_overflows_arch.h","./include/arch/x86_32/barrelfish_kpi/paging_arch.h","./include/arch/x86_32/barrelfish_kpi/cpu_arch.h","./include/arch/x86_32/arch/stdint.h","./include/arch/x86_32/arch/inttypes.h","./include/arch/x86_32/arch/setjmp.h","./include/arch/x86_32/machine/_limits.h","./include/arch/x86_32/machine/endian.h","./include/arch/x86_32/barrelfish/curdispatcher_arch.h","./include/arch/x86_32/barrelfish/bulk_transfer_arch.h","./include/arch/x86_32/barrelfish/syscall_arch.h","./include/arch/x86_32/barrelfish/pmap_arch.h","./include/arch/x86_32/barrelfish/invocations_arch.h","./include/arch/x86_32/barrelfish/dispatcher_arch.h","./include/arch/x86_32/barrelfish/core_state_arch.h","./include/arch/x86_32/barrelfish/lmp_chan_arch.h","./include/arch/x86_32/barrelfish/cpu_arch.h","./include/arch/x86_32/bench/bench_arch.h","./include/arch/arm/float.h","./include/arch/arm/_fpmath.h","./include/arch/arm/fenv.h","./include/arch/arm/barrelfish_kpi/spinlocks_arch.h","./include/arch/arm/barrelfish_kpi/flags_arch.h","./include/arch/arm/barrelfish_kpi/dispatcher_shared_arch.h","./include/arch/arm/barrelfish_kpi/generic_arch.h","./include/arch/arm/barrelfish_kpi/asm_inlines_arch.h","./include/arch/arm/barrelfish_kpi/unknown_arch.h","./include/arch/arm/barrelfish_kpi/registers_arch.h","./include/arch/arm/barrelfish_kpi/lmp_arch.h","./include/arch/arm/barrelfish_kpi/paging_arch.h","./include/arch/arm/barrelfish_kpi/cpu_arch.h","./include/arch/arm/arch/stdint.h","./include/arch/arm/arch/inttypes.h","./include/arch/arm/arch/setjmp.h","./include/arch/arm/machine/_limits.h","./include/arch/arm/machine/endian.h","./include/arch/arm/barrelfish/curdispatcher_arch.h","./include/arch/arm/barrelfish/bulk_transfer_arch.h","./include/arch/arm/barrelfish/syscall_arch.h","./include/arch/arm/barrelfish/pmap_arch.h","./include/arch/arm/barrelfish/invocations_arch.h","./include/arch/arm/barrelfish/dispatcher_arch.h","./include/arch/arm/barrelfish/core_state_arch.h","./include/arch/arm/barrelfish/lmp_chan_arch.h","./include/arch/arm/barrelfish/cpu_arch.h","./include/arch/arm/omap44xx/device_registers.h","./include/arch/arm/bench/bench_arch.h","./include/arch/alpha/arch/stdint.h","./include/arch/alpha/arch/inttypes.h","./include/arch/x86_64/float.h","./include/arch/x86_64/_fpmath.h","./include/arch/x86_64/fenv.h","./include/arch/x86_64/barrelfish_kpi/spinlocks_arch.h","./include/arch/x86_64/barrelfish_kpi/dispatcher_shared_arch.h","./include/arch/x86_64/barrelfish_kpi/generic_arch.h","./include/arch/x86_64/barrelfish_kpi/asm_inlines_arch.h","./include/arch/x86_64/barrelfish_kpi/eflags_arch.h","./include/arch/x86_64/barrelfish_kpi/registers_arch.h","./include/arch/x86_64/barrelfish_kpi/lmp_arch.h","./include/arch/x86_64/barrelfish_kpi/paging_arch.h","./include/arch/x86_64/barrelfish_kpi/cpu_arch.h","./include/arch/x86_64/arch/stdint.h","./include/arch/x86_64/arch/inttypes.h","./include/arch/x86_64/arch/setjmp.h","./include/arch/x86_64/machine/fpu.h","./include/arch/x86_64/machine/_limits.h","./include/arch/x86_64/machine/types.h","./include/arch/x86_64/machine/endian.h","./include/arch/x86_64/machine/asm.h","./include/arch/x86_64/concurrent/arch/cas.h","./include/arch/x86_64/barrelfish/curdispatcher_arch.h","./include/arch/x86_64/barrelfish/ldt.h","./include/arch/x86_64/barrelfish/bulk_transfer_arch.h","./include/arch/x86_64/barrelfish/syscall_arch.h","./include/arch/x86_64/barrelfish/pmap_arch.h","./include/arch/x86_64/barrelfish/invocations_arch.h","./include/arch/x86_64/barrelfish/dispatcher_arch.h","./include/arch/x86_64/barrelfish/core_state_arch.h","./include/arch/x86_64/barrelfish/lmp_chan_arch.h","./include/arch/x86_64/barrelfish/cpu_arch.h","./include/arch/x86_64/bench/bench_arch.h","./include/arch/powerpc64/arch/stdint.h","./include/arch/powerpc64/arch/inttypes.h","./include/arch/powerpc64/arch/setjmp.h","./include/arch/powerpc64/arch/asm.h","./include/arch/mips64/arch/stdint.h","./include/arch/mips64/arch/inttypes.h","./include/arch/mips64/arch/setjmp.h","./include/arch/x86/barrelfish_kpi/spinlocks_arch.h","./include/arch/x86/barrelfish_kpi/perfmon_amd.h","./include/arch/x86/barrelfish_kpi/asm_inlines_arch.h","./include/arch/x86/barrelfish_kpi/perfmon.h","./include/arch/x86/barrelfish/bulk_transfer_arch.h","./include/arch/x86/barrelfish/core_state_arch.h","./include/arch/x86/barrelfish/perfmon.h","./include/arch/x86/barrelfish/iocap_arch.h","./include/arch/x86/barrelfish/ipi_notify.h","./include/arch/x86/bench/bench_arch.h","./include/dist/args.h","./include/dist/start.h","./include/dist/barrier.h","./include/dist/service.h","./include/collections/flipbuffer.h","./include/collections/list.h","./include/collections/stack.h","./include/collections/hash_table.h","./include/mm/slot_alloc.h","./include/mm/mm.h","./include/pcre/pcreposix.h","./include/netif/loopif.h","./include/netif/bfeth.h","./include/netif/etharp.h","./include/netif/slipif.h","./include/cxx/fstream","./include/cxx/typeinfo","./include/cxx/bitset","./include/cxx/typeindex","./include/cxx/cfloat","./include/cxx/ostream","./include/cxx/strstream","./include/cxx/mutex","./include/cxx/ratio","./include/cxx/valarray","./include/cxx/algorithm","./include/cxx/iomanip","./include/cxx/cwchar","./include/cxx/numeric","./include/cxx/future","./include/cxx/locale","./include/cxx/ctgmath","./include/cxx/cstdio","./include/cxx/queue","./include/cxx/vector","./include/cxx/cmath","./include/cxx/cstdint","./include/cxx/cinttypes","./include/cxx/__locale","./include/cxx/unordered_map","./include/cxx/clocale","./include/cxx/stdexcept","./include/cxx/__tuple_03","./include/cxx/cstdarg","./include/cxx/cerrno","./include/cxx/__tuple","./include/cxx/string","./include/cxx/ccomplex","./include/cxx/cassert","./include/cxx/random","./include/cxx/__functional_03","./include/cxx/cwctype","./include/cxx/__split_buffer","./include/cxx/tgmath.h","./include/cxx/iostream","./include/cxx/climits","./include/cxx/regex","./include/cxx/complex.h","./include/cxx/atomic","./include/cxx/cstdlib","./include/cxx/csetjmp","./include/cxx/__tree","./include/cxx/unordered_set","./include/cxx/set","./include/cxx/streambuf","./include/cxx/new","./include/cxx/deque","./include/cxx/initializer_list","./include/cxx/__mutex_base","./include/cxx/__config","./include/cxx/iterator","./include/cxx/cfenv","./include/cxx/forward_list","./include/cxx/tuple","./include/cxx/__functional_base","./include/cxx/cstring","./include/cxx/cctype","./include/cxx/sstream","./include/cxx/__functional_base_03","./include/cxx/exception","./include/cxx/scoped_allocator","./include/cxx/array","./include/cxx/istream","./include/cxx/chrono","./include/cxx/memory","./include/cxx/ios","./include/cxx/ciso646","./include/cxx/limits","./include/cxx/__hash_table","./include/cxx/system_error","./include/cxx/complex","./include/cxx/type_traits","./include/cxx/cstddef","./include/cxx/__bit_reference","./include/cxx/condition_variable","./include/cxx/map","./include/cxx/cstdbool","./include/cxx/codecvt","./include/cxx/iosfwd","./include/cxx/ctime","./include/cxx/functional","./include/cxx/stack","./include/cxx/__sso_allocator","./include/cxx/thread","./include/cxx/csignal","./include/cxx/utility","./include/cxx/list","./include/cxx/__std_stream","./include/cxx/ext/hash_set","./include/cxx/ext/hash_map","./include/netinet/in.h","./include/netinet/ip.h","./include/netinet/in_systm.h","./include/netinet/tcp.h","./include/target/x86_32/barrelfish_kpi/registers_target.h","./include/target/x86_32/barrelfish_kpi/dispatcher_shared_target.h","./include/target/x86_32/barrelfish_kpi/paging_target.h","./include/target/x86_32/barrelfish/dispatcher_target.h","./include/target/x86_32/barrelfish/pmap_target.h","./include/target/arm/barrelfish_kpi/paging_arm_v5.h","./include/target/arm/barrelfish_kpi/dispatcher_shared_target.h","./include/target/arm/barrelfish_kpi/arm_core_data.h","./include/target/arm/barrelfish_kpi/paging_arm_v7.h","./include/target/arm/barrelfish/dispatcher_target.h","./include/target/arm/barrelfish/pmap_target.h","./include/target/x86_64/barrelfish_kpi/registers_target.h","./include/target/x86_64/barrelfish_kpi/dispatcher_shared_target.h","./include/target/x86_64/barrelfish_kpi/cpu_target.h","./include/target/x86_64/barrelfish_kpi/paging_target.h","./include/target/x86_64/barrelfish/dispatcher_target.h","./include/target/x86_64/barrelfish/pmap_target.h","./include/target/x86/barrelfish_kpi/coredata_target.h","./include/target/x86/barrelfish/pmap_target.h","./include/openssl/rsa.h","./include/openssl/ssl.h","./include/openssl/x509_vfy.h","./include/openssl/krb5_asn.h","./include/openssl/ui.h","./include/openssl/cast.h","./include/openssl/rc4.h","./include/openssl/asn1_mac.h","./include/openssl/x509.h","./include/openssl/rand.h","./include/openssl/pqueue.h","./include/openssl/rc2.h","./include/openssl/obj_mac.h","./include/openssl/cms.h","./include/openssl/safestack.h","./include/openssl/pkcs12.h","./include/openssl/sha.h","./include/openssl/ssl2.h","./include/openssl/symhacks.h","./include/openssl/md5.h","./include/openssl/buffer.h","./include/openssl/opensslconf.h","./include/openssl/dso.h","./include/openssl/pkcs7.h","./include/openssl/asn1.h","./include/openssl/blowfish.h","./include/openssl/aes.h","./include/openssl/stack.h","./include/openssl/pem2.h","./include/openssl/ecdh.h","./include/openssl/bn.h","./include/openssl/ui_compat.h","./include/openssl/whrlpool.h","./include/openssl/idea.h","./include/openssl/err.h","./include/openssl/mdc2.h","./include/openssl/bio.h","./include/openssl/md4.h","./include/openssl/ossl_typ.h","./include/openssl/seed.h","./include/openssl/conf_api.h","./include/openssl/e_os2.h","./include/openssl/ripemd.h","./include/openssl/ts.h","./include/openssl/pem.h","./include/openssl/ssl23.h","./include/openssl/comp.h","./include/openssl/evp.h","./include/openssl/lhash.h","./include/openssl/objects.h","./include/openssl/engine.h","./include/openssl/crypto.h","./include/openssl/opensslv.h","./include/openssl/tls1.h","./include/openssl/conf.h","./include/openssl/txt_db.h","./include/openssl/des_old.h","./include/openssl/x509v3.h","./include/openssl/dh.h","./include/openssl/ebcdic.h","./include/openssl/ssl3.h","./include/openssl/ocsp.h","./include/openssl/modes.h","./include/openssl/dtls1.h","./include/openssl/dsa.h","./include/openssl/kssl.h","./include/openssl/ecdsa.h","./include/openssl/hmac.h","./include/openssl/asn1t.h","./include/openssl/des.h","./include/openssl/ec.h","./include/openssl/camellia.h","./include/openssl/local/cryptlib.h","./include/openssl/local/evp_locl.h","./include/openssl/local/o_time.h","./include/openssl/local/asn1_locl.h","./include/openssl/local/md32_common.h","./include/openssl/local/e_os.h","./include/concurrent/linked_list.h","./include/x86emu/decode.h","./include/x86emu/fpu.h","./include/x86emu/debug.h","./include/x86emu/regs.h","./include/x86emu/types.h","./include/x86emu/ops.h","./include/x86emu/prim_asm.h","./include/x86emu/fpu_regs.h","./include/x86emu/x86emui.h","./include/x86emu/prim_ops.h","./include/octopus/lock.h","./include/octopus/getset.h","./include/octopus/definitions.h","./include/octopus/capability_storage.h","./include/octopus/pubsub.h","./include/octopus/semaphores.h","./include/octopus/trigger.h","./include/octopus/octopus.h","./include/octopus/init.h","./include/octopus/barrier.h","./include/octopus/parser/ast.h","./include/tweed/tweed.h","./include/net_device_manager/net_ports_service.h","./include/net_device_manager/net_device_manager.h","./include/pci/mem.h","./include/pci/devids.h","./include/pci/pci.h","./include/pci/confspace/pci_confspace.h","./include/pci/confspace/mackerelpci.h","./include/procon/procon.h","./include/pager/pager.h","./include/bfdmuxvm/vm.h","./include/skb/skb.h","./include/dmalloc/dmalloc.h","./include/nfs/nfs_rpc.h","./include/nfs/mount_rpc.h","./include/nfs/xdr.h","./include/nfs/nfs.h","./include/spawndomain/spawndomain.h","./include/spawndomain/getopt.h","./include/timer/timer.h","./include/bfdmuxtools/bfdmux.h","./include/bfdmuxtools/debug.h","./include/bfdmuxtools/filter.h","./include/bfdmuxtools/codegen.h","./include/bfdmuxtools/tools.h","./include/cpuid/cpuid_spaces.h","./include/cpuid/cpuid.h","./include/hashtable/hashtable.h","./include/hashtable/multimap.h","./include/hashtable/dictionary.h","./include/getopt/getopt.h","./include/flounder/flounder_support_caps.h","./include/flounder/flounder.h","./include/flounder/flounder_support_ump.h","./include/flounder/flounder_support_lmp.h","./include/flounder/flounder_support.h","./include/ahci/ahci.h","./include/ahci/ahci_dma_pool.h","./include/ahci/ahci_util.h","./include/ahci/sata_fis.h","./include/ahci/ahci_defs.h","./include/deputy/nodeputy.h","./include/c/stdbool.h","./include/c/stdarg.h","./include/c/stddef.h","./include/barrelfish/barrelfish.h","./include/barrelfish/dispatch.h","./include/barrelfish/dispatcher.h","./include/barrelfish/types.h","./include/barrelfish/bulk_transfer.h","./include/barrelfish/core_state.h","./include/barrelfish/static_assert.h","./include/net_queue_manager/net_queue_manager.h","./include/contmng/contmng.h","./include/contmng/netbench.h","./include/rcce/RCCE.h","./include/rcce/RCCE_lib.h","./include/rcce/RCCE_debug.h","./include/rcce/RCCE_lib_pwr.h","./include/sys/dirent.h","./include/sys/ttycom.h","./include/sys/cdefs.h","./include/sys/time.h","./include/sys/_iovec.h","./include/sys/ioctl.h","./include/sys/param.h","./include/sys/un.h","./include/sys/shm.h","./include/sys/_types.h","./include/sys/types.h","./include/sys/unistd.h","./include/sys/_termios.h","./include/sys/uio.h","./include/sys/stat.h","./include/sys/endian.h","./include/sys/_sigset.h","./include/sys/wait.h","./include/sys/file.h","./include/sys/ipc.h","./include/sys/times.h","./include/mdb/mdb.h","./include/mdb/types.h","./include/mdb/mdb_tree.h","./include/thc/thcstubs.h","./include/thc/thcinternal.h","./include/thc/thcsync.h","./include/thc/thc.h","./include/mackerel/mackerel.h","./include/mackerel/io.h","./include/elf/elf.h","./include/ipv4/lwip/ip_addr.h","./include/ipv4/lwip/inet.h","./include/ipv4/lwip/ip_frag.h","./include/ipv4/lwip/igmp.h","./include/ipv4/lwip/autoip.h","./include/ipv4/lwip/icmp.h","./include/ipv4/lwip/ip.h","./include/ipv4/lwip/inet_chksum.h","./include/bench/bench.h","./include/arpa/inet.h","./include/driverkit/driverkit.h","./include/oldc/dirent.h","./include/oldc/math.h","./include/oldc/time.h","./include/oldc/printf.h","./include/oldc/pwd.h","./include/oldc/ctype.h","./include/oldc/runetype.h","./include/oldc/stdlib.h","./include/oldc/_ctype.h","./include/oldc/locale.h","./include/oldc/stdio.h","./include/oldc/errno.h","./include/oldc/complex.h","./include/oldc/stdint.h","./include/oldc/wctype.h","./include/oldc/fpmath.h","./include/oldc/termios.h","./include/oldc/getopt.h","./include/oldc/inttypes.h","./include/oldc/assert.h","./include/oldc/setjmp.h","./include/oldc/ieeefp.h","./include/oldc/string.h","./include/oldc/grp.h","./include/oldc/wchar.h","./include/oldc/iso646.h","./include/vfs/vfs_path.h","./include/vfs/fdtab.h","./include/vfs/mmap.h","./include/vfs/vfs.h","./include/vfs/vfs_fd.h","./include/usb/usb_topology.h","./include/usb/debug.h","./include/usb/usb_device.h","./include/usb/shared_state.h","./include/usb/usb_pipe.h","./include/usb/ch9.h","./include/usb/usb_services.h","./include/usb/usbd.h","./include/usb/usb_debug.h","./include/usb/utility.h","./include/usb/driver_locator.h","./include/usb/device_commands.h","./include/usb/mem/usb_mem.h","./include/octopus_server/debug.h","./include/octopus_server/query.h","./include/octopus_server/init.h","./include/octopus_server/service.h","./include/ipv6/lwip/ip_addr.h","./include/ipv6/lwip/inet.h","./include/ipv6/lwip/icmp.h","./include/ipv6/lwip/ip.h","./armv7/include/cpiobin.h","./armv7/include/values.h","./armv7/include/zlib.h","./armv7/include/utime.h","./armv7/include/zconf.h","./armv7/include/asmoffsets.h","./armv7/include/x86emu.h","./armv7/include/.marker","./armv7/include/multicast.h","./armv7/include/dlfcn.h","./armv7/include/errors/errno.h","./armv7/include/errors/.marker","./armv7/sbin/init","./armv7/sbin/cpu_omap44xx","./armv7/sbin/.marker","./armv7/usr/init/_for_app_init/main.o","./armv7/usr/init/_for_app_init/main.o.depend","./armv7/usr/init/_for_app_init/init.o.depend","./armv7/usr/init/_for_app_init/.marker","./armv7/usr/init/_for_app_init/init.o","./armv7/usr/init/_for_app_init/syscall/syscall.o.depend","./armv7/usr/init/_for_app_init/syscall/syscalls.o.depend","./armv7/usr/init/_for_app_init/syscall/syscall.o","./armv7/usr/init/_for_app_init/syscall/.marker","./armv7/usr/init/_for_app_init/syscall/syscalls.o","./armv7/usr/init/_for_app_init/libc_glue/debug_printf.o.depend","./armv7/usr/init/_for_app_init/libc_glue/morecore.o","./armv7/usr/init/_for_app_init/libc_glue/debug_printf.o","./armv7/usr/init/_for_app_init/libc_glue/morecore.o.depend","./armv7/usr/init/_for_app_init/libc_glue/.marker","./armv7/lib/libstdlib_malloc.a","./armv7/lib/libstdlib_malign.a","./armv7/lib/libcommon.a","./armv7/lib/libsearch.a","./armv7/lib/libctype.a","./armv7/lib/libsys.a","./armv7/lib/libm.a","./armv7/lib/libnewlib.a","./armv7/lib/libstdio_i.a","./armv7/lib/libnewc.a","./armv7/lib/crtend.o","./armv7/lib/libcomplex.a","./armv7/lib/libstdlib_valloc.a","./armv7/lib/libelf.a","./armv7/lib/libstdlib_free.a","./armv7/lib/libstdlib_cfree.a","./armv7/lib/libreent.a","./armv7/lib/libstdlib_pvalloc.a","./armv7/lib/libstdio_s.a","./armv7/lib/crtbegin.o","./armv7/lib/libmath.a","./armv7/lib/libstring.a","./armv7/lib/libstdlib_mallinfo.a","./armv7/lib/libstdio.a","./armv7/lib/libtime.a","./armv7/lib/libstdlib.a","./armv7/lib/libmisc.a","./armv7/lib/libnewlib_.a","./armv7/lib/libstdlib_mallopt.a","./armv7/lib/crt0.o","./armv7/lib/libcollections.a","./armv7/lib/libstdlib_msize.a","./armv7/lib/liblocale.a","./armv7/lib/liberrno.a","./armv7/lib/libstdlib_calloc.a","./armv7/lib/.marker","./armv7/lib/libstdlib_mallstats.a","./armv7/lib/libstdlib_realloc.a","./armv7/lib/libargz.a","./armv7/lib/libstdio_si.a","./armv7/lib/collections/_for_lib_collections/list.o.depend","./armv7/lib/collections/_for_lib_collections/stack.o.depend","./armv7/lib/collections/_for_lib_collections/list.o","./armv7/lib/collections/_for_lib_collections/flipbuffer.o.depend","./armv7/lib/collections/_for_lib_collections/flipbuffer.o","./armv7/lib/collections/_for_lib_collections/.marker","./armv7/lib/collections/_for_lib_collections/hash_table.o","./armv7/lib/collections/_for_lib_collections/hash_table.o.depend","./armv7/lib/collections/_for_lib_collections/stack.o","./armv7/lib/procon/_for_lib_procon/procon.o.depend","./armv7/lib/procon/_for_lib_procon/.marker","./armv7/lib/newlib/newlib/libc/locale/_for_lib_locale/fix_grouping.o.depend","./armv7/lib/newlib/newlib/libc/locale/_for_lib_locale/timelocal.o","./armv7/lib/newlib/newlib/libc/locale/_for_lib_locale/lmessages.o","./armv7/lib/newlib/newlib/libc/locale/_for_lib_locale/nl_langinfo.o","./armv7/lib/newlib/newlib/libc/locale/_for_lib_locale/timelocal.o.depend","./armv7/lib/newlib/newlib/libc/locale/_for_lib_locale/locale.o","./armv7/lib/newlib/newlib/libc/locale/_for_lib_locale/lctype.o.depend","./armv7/lib/newlib/newlib/libc/locale/_for_lib_locale/lnumeric.o","./armv7/lib/newlib/newlib/libc/locale/_for_lib_locale/lmonetary.o.depend","./armv7/lib/newlib/newlib/libc/locale/_for_lib_locale/ldpart.o.depend","./armv7/lib/newlib/newlib/libc/locale/_for_lib_locale/fix_grouping.o","./armv7/lib/newlib/newlib/libc/locale/_for_lib_locale/locale.o.depend","./armv7/lib/newlib/newlib/libc/locale/_for_lib_locale/lmonetary.o","./armv7/lib/newlib/newlib/libc/locale/_for_lib_locale/lctype.o","./armv7/lib/newlib/newlib/libc/locale/_for_lib_locale/nl_langinfo.o.depend","./armv7/lib/newlib/newlib/libc/locale/_for_lib_locale/.marker","./armv7/lib/newlib/newlib/libc/locale/_for_lib_locale/lnumeric.o.depend","./armv7/lib/newlib/newlib/libc/locale/_for_lib_locale/ldpart.o","./armv7/lib/newlib/newlib/libc/locale/_for_lib_locale/lmessages.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio_si/svfiscanf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio_si/svfiprintf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio_si/svfiwscanf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio_si/svfiwprintf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio_si/.marker","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio_si/svfiwscanf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio_si/svfiscanf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio_si/svfiwprintf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio_si/svfiprintf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/getwchar.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/putw.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/puts.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vdprintf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/asprintf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/scanf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/setbuffer.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fiscanf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/ftell.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/dprintf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vwprintf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/getchar_u.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/putc_u.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/putc.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/rename.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/ftell.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/putc.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/getwchar.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vfprintf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/flags.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/getline.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fmemopen.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/viprintf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vswprintf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/wsetup.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/setvbuf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/swscanf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/putchar.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/swscanf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/ferror.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fgetc.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/dprintf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fdopen.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vdiprintf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/asniprintf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fgetwc.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/puts.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fclose.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/getw.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/stdio.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fwide.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vsiprintf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/ungetc.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vfwprintf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/funopen.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/refill.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/rget.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fputws.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/scanf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/snprintf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/rewind.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/asprintf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/setbuffer.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fgetpos.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fputwc.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/clearerr.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/ferror.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/getc.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/putw.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/ungetwc.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/freopen.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/makebuf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/freopen.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fwprintf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fwrite.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/getline.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/getchar_u.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fwprintf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/wscanf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vswprintf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/asiprintf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fcloseall.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/ftello.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fgetc.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vasprintf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/getchar.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/viscanf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vwscanf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fpurge.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/perror.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/ftello.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fopencookie.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/setlinebuf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vasnprintf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vdiprintf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vfwprintf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/getwc.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fputs.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fread.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/sprintf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fputc.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/diprintf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/getc.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fclose.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/feof.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vswscanf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fputs.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vsscanf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/asnprintf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fputwc.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/mktemp.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/siscanf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vwscanf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/putwchar.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/viprintf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fgetws.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/stdio.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/asniprintf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/perror.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fvwrite.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vdprintf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fwscanf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/getc_u.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/clearerr.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/siprintf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fgets.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/iprintf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fiprintf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fseeko.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fgetpos.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vsprintf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vasniprintf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fprintf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fgetws.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fsetpos.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/putwc.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/sniprintf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/iprintf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/siscanf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vfwscanf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vsniprintf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fwrite.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fseeko.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/putchar.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/wprintf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fvwrite.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/rename.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fgets.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vsiscanf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fscanf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fopencookie.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/snprintf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/makebuf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/getdelim.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fwide.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/setvbuf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vsnprintf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/wsetup.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/sscanf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/getchar.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/iscanf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vprintf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vasiprintf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/asnprintf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/putchar_u.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fiprintf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/diprintf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fflush.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fcloseall.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/sscanf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vwprintf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/sniprintf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fwalk.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/wprintf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vsscanf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/setlinebuf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vscanf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/swprintf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/getc_u.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/feof.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/wbuf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/asiprintf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fprintf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/tmpnam.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vsniprintf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fwscanf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fgetwc.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fopen.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vprintf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/tmpfile.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/getw.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/getwc.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/funopen.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fseek.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/ungetc.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/tmpnam.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/getdelim.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vsiprintf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vsprintf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/wscanf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vfscanf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vsnprintf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fileno.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/.marker","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/rget.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vasiprintf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fmemopen.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/printf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/swprintf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vscanf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/flags.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/iscanf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fiscanf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/wbuf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/setbuf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/ungetwc.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/open_memstream.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fflush.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fdopen.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fpurge.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vasnprintf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fread.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fopen.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/gets.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/tmpfile.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/remove.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fwalk.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/viscanf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vfscanf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/refill.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/putchar_u.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fileno.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/open_memstream.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/siprintf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/remove.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/rewind.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/gets.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/sccl.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/putwc.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vfwscanf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vsiscanf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/setbuf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fputws.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/sccl.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fscanf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/putwchar.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/putc_u.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fsetpos.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vfprintf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/mktemp.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vasniprintf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vswscanf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/printf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fputc.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/sprintf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/fseek.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio/vasprintf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio_i/vfiwprintf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio_i/vfiscanf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio_i/vfiprintf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio_i/vfiscanf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio_i/vfiwscanf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio_i/.marker","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio_i/vfiwscanf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio_i/vfiprintf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio_i/vfiwprintf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio_s/svfscanf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio_s/svfscanf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio_s/svfwprintf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio_s/svfwscanf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio_s/svfwscanf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio_s/.marker","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio_s/svfwprintf.o","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio_s/svfprintf.o.depend","./armv7/lib/newlib/newlib/libc/stdio/_for_lib_stdio_s/svfprintf.o","./armv7/lib/newlib/newlib/libc/_for_lib_newc/machine/arm/setjmp.o.depend","./armv7/lib/newlib/newlib/libc/_for_lib_newc/machine/arm/setjmp.o","./armv7/lib/newlib/newlib/libc/_for_lib_newc/machine/arm/.marker","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcswidth.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wmemcpy.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcsdup.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strndup_r.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strchr.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strerror.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strlen.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcscat.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strdup_r.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strcasestr.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strlcat.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strupr.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcsncpy.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strncat.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/stpcpy.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strtok_r.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/memcmp.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strncmp.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcslcpy.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strerror_r.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strndup.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/memset.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/memmem.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strndup.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcwidth.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strlwr.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcscmp.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/memccpy.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wmemcpy.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strupr.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strcmp.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/memmove.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcsrchr.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strncpy.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strcat.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcsnlen.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strcmp.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strcat.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcslcat.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcsdup.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/u_strerr.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcsspn.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strnlen.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strxfrm.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strsignal.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strrchr.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/memcmp.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strndup_r.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcscoll.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wmemcmp.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcscasecmp.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcsstr.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strncmp.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strcpy.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcsxfrm.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wmemset.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/stpncpy.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strcasecmp.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcslen.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/swab.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strstr.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strtok.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcstok.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strcasecmp.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcsncmp.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcscspn.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strncat.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/rindex.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/memchr.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/rindex.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/swab.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wmemchr.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strerror_r.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcscpy.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strpbrk.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcslcat.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcschr.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strcpy.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcspbrk.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strlcpy.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcpcpy.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcscat.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strtok_r.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcstok.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcslen.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strlen.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/bcmp.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strcoll.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strnlen.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strncasecmp.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcpncpy.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strcspn.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strdup.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcscoll.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/mempcpy.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strcoll.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/u_strerr.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcslcpy.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/memset.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcsncasecmp.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wmemmove.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/memmove.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcpcpy.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcsxfrm.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/stpncpy.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strsignal.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcsrchr.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcwidth.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcsnlen.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcsncat.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strcspn.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcschr.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strdup.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/stpcpy.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcscasecmp.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strncasecmp.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcsncpy.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/memcpy.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wmemcmp.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcscmp.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/bcopy.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/memmem.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wmemchr.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strspn.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcsncasecmp.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strlcat.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strrchr.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/bcmp.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcscpy.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcsstr.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strerror.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/memchr.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/.marker","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/bcopy.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcsncmp.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcswidth.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strtok.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcscspn.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/index.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strlcpy.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/index.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strncpy.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wmemset.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wmemmove.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/memccpy.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strcasestr.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strchr.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strstr.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcpncpy.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strsep.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/bzero.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/memcpy.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcsspn.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strxfrm.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcspbrk.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strsep.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strlwr.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strdup_r.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/bzero.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/mempcpy.o.depend","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strspn.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/wcsncat.o","./armv7/lib/newlib/newlib/libc/string/_for_lib_string/strpbrk.o.depend","./armv7/lib/newlib/newlib/libc/signal/_for_lib_signal/signal.o.depend","./armv7/lib/newlib/newlib/libc/signal/_for_lib_signal/raise.o.depend","./armv7/lib/newlib/newlib/libc/signal/_for_lib_signal/.marker","./armv7/lib/newlib/newlib/libc/misc/_for_lib_misc/__dprintf.o.depend","./armv7/lib/newlib/newlib/libc/misc/_for_lib_misc/fini.o.depend","./armv7/lib/newlib/newlib/libc/misc/_for_lib_misc/unctrl.o.depend","./armv7/lib/newlib/newlib/libc/misc/_for_lib_misc/init.o.depend","./armv7/lib/newlib/newlib/libc/misc/_for_lib_misc/fini.o","./armv7/lib/newlib/newlib/libc/misc/_for_lib_misc/unctrl.o","./armv7/lib/newlib/newlib/libc/misc/_for_lib_misc/ffs.o.depend","./armv7/lib/newlib/newlib/libc/misc/_for_lib_misc/.marker","./armv7/lib/newlib/newlib/libc/misc/_for_lib_misc/init.o","./armv7/lib/newlib/newlib/libc/misc/_for_lib_misc/__dprintf.o","./armv7/lib/newlib/newlib/libc/misc/_for_lib_misc/ffs.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib_cfree/cfreer.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib_cfree/cfreer.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib_cfree/.marker","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib_valloc/vallocr.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib_valloc/vallocr.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib_valloc/.marker","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib_mallopt/malloptr.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib_mallopt/malloptr.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib_mallopt/.marker","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib_mallstats/mallstatsr.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib_mallstats/mallstatsr.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib_mallstats/.marker","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib_free/.marker","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib_free/freer.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib_free/freer.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/mbsinit.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/ldiv.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/wcstoull.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/mprec.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/calloc.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/putenv_r.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/div.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/getsubopt.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/cxa_finalize.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/l64a.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/setenv.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/cxa_atexit.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/rand_r.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/mprec.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/mblen_r.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/malloc.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/wcrtomb.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/__call_atexit.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/lcong48.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/wcsrtombs.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/gdtoa-gethex.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/on_exit.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/strtoll.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/mbsnrtowcs.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/erand48.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/lrand48.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/environ.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/mblen.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/wctob.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/drand48.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/eprintf.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/wcstoull.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/atoll.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/ldiv.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/cxa_finalize.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/ldtoa.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/sb_charsets.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/wcstod.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/srand48.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/div.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/wctomb_r.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/wcstombs.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/sb_charsets.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/mbstowcs.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/mbtowc.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/malloc.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/mbsrtowcs.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/wcstoul.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/wctomb.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/envlock.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/wcstoull_r.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/strtod.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/abs.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/getenv_r.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/mblen.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/atexit.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/strtold.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/strtod.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/mbrlen.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/getenv.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/mbstowcs.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/wcsrtombs.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/wcstol.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/strtoul.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/erand48.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/mtrim.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/setenv_r.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/wctomb_r.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/mbstowcs_r.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/rand_r.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/mbrlen.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/btowc.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/strtold.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/atoff.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/strtoull_r.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/wcsnrtombs.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/strtoull.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/rand.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/wcstol.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/a64l.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/mrand48.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/reallocf.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/dtoa.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/mbrtowc.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/__atexit.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/putenv.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/atoi.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/mstats.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/atexit.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/exit.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/cxa_atexit.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/wctomb.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/gdtoa-hexnan.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/wcrtomb.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/valloc.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/strtol.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/rand48.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/dtoa.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/lldiv.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/realloc.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/a64l.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/gdtoa-hexnan.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/atof.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/strtol.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/getsubopt.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/wcstold.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/ldtoa.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/realloc.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/atol.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/nrand48.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/efgcvt.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/wcstod.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/msize.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/mbrtowc.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/mbtowc.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/envlock.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/strtoul.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/abs.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/labs.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/setenv_r.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/msize.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/wcstoll_r.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/dtoastub.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/rand48.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/wcstoll_r.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/strtoll_r.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/atoi.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/environ.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/jrand48.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/wcstoll.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/__exp10.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/drand48.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/getenv.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/labs.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/mlock.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/jrand48.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/strtoull.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/nrand48.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/dtoastub.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/malign.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/atol.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/__call_atexit.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/wcstoll.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/mbsnrtowcs.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/putenv.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/.marker","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/on_exit.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/strtoll_r.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/wcstoull_r.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/mbsinit.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/strtoll.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/malign.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/wctob.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/mtrim.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/wcstoul.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/__atexit.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/mbtowc_r.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/__adjust.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/wcstold.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/mstats.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/seed48.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/mblen_r.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/gdtoa-gethex.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/reallocf.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/mbtowc_r.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/ecvtbuf.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/setenv.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/btowc.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/__ten_mu.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/__ten_mu.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/assert.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/atoll.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/valloc.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/lldiv.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/seed48.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/getopt.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/atoff.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/l64a.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/lcong48.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/wcstombs_r.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/efgcvt.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/srand48.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/wcstombs_r.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/mbstowcs_r.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/getopt.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/mbsrtowcs.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/putenv_r.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/ecvtbuf.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/__exp10.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/strtoull_r.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/getenv_r.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/calloc.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/exit.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/llabs.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/__adjust.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/wcstombs.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/mrand48.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/assert.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/lrand48.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/llabs.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/wcsnrtombs.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/eprintf.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/atof.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/mlock.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib/rand.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib_calloc/callocr.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib_calloc/callocr.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib_calloc/.marker","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib_malloc/mallocr.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib_malloc/mallocr.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib_malloc/.marker","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib_pvalloc/pvallocr.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib_pvalloc/pvallocr.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib_pvalloc/.marker","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib_msize/msizer.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib_msize/msizer.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib_msize/.marker","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib_realloc/.marker","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib_realloc/reallocr.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib_realloc/reallocr.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib_mallinfo/mallinfor.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib_mallinfo/mallinfor.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib_mallinfo/.marker","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib_malign/malignr.o","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib_malign/malignr.o.depend","./armv7/lib/newlib/newlib/libc/stdlib/_for_lib_stdlib_malign/.marker","./armv7/lib/newlib/newlib/libc/reent/_for_lib_reent/impure.o.depend","./armv7/lib/newlib/newlib/libc/reent/_for_lib_reent/getreent.o.depend","./armv7/lib/newlib/newlib/libc/reent/_for_lib_reent/getreent.o","./armv7/lib/newlib/newlib/libc/reent/_for_lib_reent/reent.o","./armv7/lib/newlib/newlib/libc/reent/_for_lib_reent/impure.o","./armv7/lib/newlib/newlib/libc/reent/_for_lib_reent/.marker","./armv7/lib/newlib/newlib/libc/reent/_for_lib_reent/reent.o.depend","./armv7/lib/newlib/newlib/libc/sys/barrelfish/_for_lib_sys/posix_syscalls.o.depend","./armv7/lib/newlib/newlib/libc/sys/barrelfish/_for_lib_sys/oldrealloc.o.depend","./armv7/lib/newlib/newlib/libc/sys/barrelfish/_for_lib_sys/oldcalloc.o","./armv7/lib/newlib/newlib/libc/sys/barrelfish/_for_lib_sys/oldcalloc.o.depend","./armv7/lib/newlib/newlib/libc/sys/barrelfish/_for_lib_sys/findfp.o","./armv7/lib/newlib/newlib/libc/sys/barrelfish/_for_lib_sys/mallocr.o","./armv7/lib/newlib/newlib/libc/sys/barrelfish/_for_lib_sys/syscalls.o.depend","./armv7/lib/newlib/newlib/libc/sys/barrelfish/_for_lib_sys/posix_syscalls.o","./armv7/lib/newlib/newlib/libc/sys/barrelfish/_for_lib_sys/oldrealloc.o","./armv7/lib/newlib/newlib/libc/sys/barrelfish/_for_lib_sys/mallocr.o.depend","./armv7/lib/newlib/newlib/libc/sys/barrelfish/_for_lib_sys/oldmalloc.o","./armv7/lib/newlib/newlib/libc/sys/barrelfish/_for_lib_sys/.marker","./armv7/lib/newlib/newlib/libc/sys/barrelfish/_for_lib_sys/syscalls.o","./armv7/lib/newlib/newlib/libc/sys/barrelfish/_for_lib_sys/oldmalloc.o.depend","./armv7/lib/newlib/newlib/libc/sys/barrelfish/_for_lib_sys/oldsys_morecore.o.depend","./armv7/lib/newlib/newlib/libc/sys/barrelfish/_for_lib_sys/oldsys_morecore.o","./armv7/lib/newlib/newlib/libc/sys/barrelfish/_for_lib_sys/findfp.o.depend","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/isblank.o.depend","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/towupper.o.depend","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/iswspace.o","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/iswlower.o","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/iswblank.o.depend","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/wctype.o","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/iswcntrl.o.depend","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/iswalnum.o","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/towupper.o","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/iswprint.o.depend","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/iswxdigit.o.depend","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/iswlower.o.depend","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/isprint.o","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/islower.o.depend","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/ispunct.o.depend","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/iswxdigit.o","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/iswcntrl.o","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/wctype.o.depend","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/isascii.o","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/towlower.o","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/isalpha.o","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/isblank.o","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/iswgraph.o.depend","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/iswupper.o","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/toascii.o.depend","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/isupper.o","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/isalnum.o.depend","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/iswpunct.o.depend","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/iswdigit.o.depend","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/iscntrl.o","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/iswspace.o.depend","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/toascii.o","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/iswblank.o","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/ispunct.o","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/towctrans.o.depend","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/isupper.o.depend","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/iswalpha.o.depend","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/isxdigit.o.depend","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/isalpha.o.depend","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/iswalnum.o.depend","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/toupper.o.depend","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/isdigit.o","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/isspace.o.depend","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/jp2uc.o","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/iswctype.o.depend","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/iscntrl.o.depend","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/ctype_.o.depend","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/jp2uc.o.depend","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/.marker","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/iswdigit.o","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/iswctype.o","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/isspace.o","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/iswalpha.o","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/tolower.o","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/isascii.o.depend","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/towctrans.o","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/isalnum.o","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/isxdigit.o","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/wctrans.o","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/iswgraph.o","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/towlower.o.depend","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/tolower.o.depend","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/islower.o","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/ctype_.o","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/iswpunct.o","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/wctrans.o.depend","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/isdigit.o.depend","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/iswupper.o.depend","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/iswprint.o","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/toupper.o","./armv7/lib/newlib/newlib/libc/ctype/_for_lib_ctype/isprint.o.depend","./armv7/lib/newlib/newlib/libc/time/_for_lib_time/lcltime_r.o.depend","./armv7/lib/newlib/newlib/libc/time/_for_lib_time/gettzinfo.o","./armv7/lib/newlib/newlib/libc/time/_for_lib_time/wcsftime.o.depend","./armv7/lib/newlib/newlib/libc/time/_for_lib_time/difftime.o","./armv7/lib/newlib/newlib/libc/time/_for_lib_time/mktime.o.depend","./armv7/lib/newlib/newlib/libc/time/_for_lib_time/mktm_r.o","./armv7/lib/newlib/newlib/libc/time/_for_lib_time/gmtime_r.o","./armv7/lib/newlib/newlib/libc/time/_for_lib_time/tzvars.o.depend","./armv7/lib/newlib/newlib/libc/time/_for_lib_time/lcltime_r.o","./armv7/lib/newlib/newlib/libc/time/_for_lib_time/time.o.depend","./armv7/lib/newlib/newlib/libc/time/_for_lib_time/strftime.o.depend","./armv7/lib/newlib/newlib/libc/time/_for_lib_time/tzlock.o","./armv7/lib/newlib/newlib/libc/time/_for_lib_time/difftime.o.depend","./armv7/lib/newlib/newlib/libc/time/_for_lib_time/asctime_r.o.depend","./armv7/lib/newlib/newlib/libc/time/_for_lib_time/asctime.o.depend","./armv7/lib/newlib/newlib/libc/time/_for_lib_time/ctime.o.depend","./armv7/lib/newlib/newlib/libc/time/_for_lib_time/strftime.o","./armv7/lib/newlib/newlib/libc/time/_for_lib_time/lcltime.o.depend","./armv7/lib/newlib/newlib/libc/time/_for_lib_time/mktm_r.o.depend","./armv7/lib/newlib/newlib/libc/time/_for_lib_time/tzset.o","./armv7/lib/newlib/newlib/libc/time/_for_lib_time/ctime_r.o.depend","./armv7/lib/newlib/newlib/libc/time/_for_lib_time/gmtime.o","./armv7/lib/newlib/newlib/libc/time/_for_lib_time/strptime.o","./armv7/lib/newlib/newlib/libc/time/_for_lib_time/tzset.o.depend","./armv7/lib/newlib/newlib/libc/time/_for_lib_time/clock.o","./armv7/lib/newlib/newlib/libc/time/_for_lib_time/time.o","./armv7/lib/newlib/newlib/libc/time/_for_lib_time/wcsftime.o","./armv7/lib/newlib/newlib/libc/time/_for_lib_time/tzlock.o.depend","./armv7/lib/newlib/newlib/libc/time/_for_lib_time/gmtime.o.depend","./armv7/lib/newlib/newlib/libc/time/_for_lib_time/tzset_r.o.depend","./armv7/lib/newlib/newlib/libc/time/_for_lib_time/clock.o.depend","./armv7/lib/newlib/newlib/libc/time/_for_lib_time/asctime.o","./armv7/lib/newlib/newlib/libc/time/_for_lib_time/strptime.o.depend","./armv7/lib/newlib/newlib/libc/time/_for_lib_time/gettzinfo.o.depend","./armv7/lib/newlib/newlib/libc/time/_for_lib_time/.marker","./armv7/lib/newlib/newlib/libc/time/_for_lib_time/ctime.o","./armv7/lib/newlib/newlib/libc/time/_for_lib_time/tzset_r.o","./armv7/lib/newlib/newlib/libc/time/_for_lib_time/ctime_r.o","./armv7/lib/newlib/newlib/libc/time/_for_lib_time/lcltime.o","./armv7/lib/newlib/newlib/libc/time/_for_lib_time/mktime.o","./armv7/lib/newlib/newlib/libc/time/_for_lib_time/tzvars.o","./armv7/lib/newlib/newlib/libc/time/_for_lib_time/gmtime_r.o.depend","./armv7/lib/newlib/newlib/libc/time/_for_lib_time/asctime_r.o","./armv7/lib/newlib/newlib/libc/search/_for_lib_search/tdelete.o.depend","./armv7/lib/newlib/newlib/libc/search/_for_lib_search/hash_page.o.depend","./armv7/lib/newlib/newlib/libc/search/_for_lib_search/twalk.o.depend","./armv7/lib/newlib/newlib/libc/search/_for_lib_search/hash_page.o","./armv7/lib/newlib/newlib/libc/search/_for_lib_search/hcreate.o.depend","./armv7/lib/newlib/newlib/libc/search/_for_lib_search/hash_buf.o.depend","./armv7/lib/newlib/newlib/libc/search/_for_lib_search/bsearch.o","./armv7/lib/newlib/newlib/libc/search/_for_lib_search/twalk.o","./armv7/lib/newlib/newlib/libc/search/_for_lib_search/tdelete.o","./armv7/lib/newlib/newlib/libc/search/_for_lib_search/tfind.o","./armv7/lib/newlib/newlib/libc/search/_for_lib_search/tsearch.o.depend","./armv7/lib/newlib/newlib/libc/search/_for_lib_search/bsearch.o.depend","./armv7/lib/newlib/newlib/libc/search/_for_lib_search/tsearch.o","./armv7/lib/newlib/newlib/libc/search/_for_lib_search/hash_log2.o","./armv7/lib/newlib/newlib/libc/search/_for_lib_search/tdestroy.o","./armv7/lib/newlib/newlib/libc/search/_for_lib_search/hash_buf.o","./armv7/lib/newlib/newlib/libc/search/_for_lib_search/hash.o.depend","./armv7/lib/newlib/newlib/libc/search/_for_lib_search/qsort.o","./armv7/lib/newlib/newlib/libc/search/_for_lib_search/tfind.o.depend","./armv7/lib/newlib/newlib/libc/search/_for_lib_search/hash_func.o.depend","./armv7/lib/newlib/newlib/libc/search/_for_lib_search/hash.o","./armv7/lib/newlib/newlib/libc/search/_for_lib_search/hcreate_r.o.depend","./armv7/lib/newlib/newlib/libc/search/_for_lib_search/hash_bigkey.o","./armv7/lib/newlib/newlib/libc/search/_for_lib_search/hcreate_r.o","./armv7/lib/newlib/newlib/libc/search/_for_lib_search/hcreate.o","./armv7/lib/newlib/newlib/libc/search/_for_lib_search/hash_log2.o.depend","./armv7/lib/newlib/newlib/libc/search/_for_lib_search/hash_func.o","./armv7/lib/newlib/newlib/libc/search/_for_lib_search/.marker","./armv7/lib/newlib/newlib/libc/search/_for_lib_search/qsort.o.depend","./armv7/lib/newlib/newlib/libc/search/_for_lib_search/hash_bigkey.o.depend","./armv7/lib/newlib/newlib/libc/search/_for_lib_search/tdestroy.o.depend","./armv7/lib/newlib/newlib/libc/errno/_for_lib_errno/errno.o","./armv7/lib/newlib/newlib/libc/errno/_for_lib_errno/.marker","./armv7/lib/newlib/newlib/libc/errno/_for_lib_errno/errno.o.depend","./armv7/lib/newlib/newlib/libc/argz/_for_lib_argz/argz_next.o","./armv7/lib/newlib/newlib/libc/argz/_for_lib_argz/argz_create_sep.o.depend","./armv7/lib/newlib/newlib/libc/argz/_for_lib_argz/argz_add_sep.o","./armv7/lib/newlib/newlib/libc/argz/_for_lib_argz/argz_delete.o.depend","./armv7/lib/newlib/newlib/libc/argz/_for_lib_argz/argz_insert.o","./armv7/lib/newlib/newlib/libc/argz/_for_lib_argz/argz_next.o.depend","./armv7/lib/newlib/newlib/libc/argz/_for_lib_argz/envz_add.o","./armv7/lib/newlib/newlib/libc/argz/_for_lib_argz/argz_replace.o.depend","./armv7/lib/newlib/newlib/libc/argz/_for_lib_argz/argz_extract.o.depend","./armv7/lib/newlib/newlib/libc/argz/_for_lib_argz/dummy.o.depend","./armv7/lib/newlib/newlib/libc/argz/_for_lib_argz/argz_create.o","./armv7/lib/newlib/newlib/libc/argz/_for_lib_argz/argz_create.o.depend","./armv7/lib/newlib/newlib/libc/argz/_for_lib_argz/argz_extract.o","./armv7/lib/newlib/newlib/libc/argz/_for_lib_argz/argz_count.o.depend","./armv7/lib/newlib/newlib/libc/argz/_for_lib_argz/argz_append.o.depend","./armv7/lib/newlib/newlib/libc/argz/_for_lib_argz/argz_insert.o.depend","./armv7/lib/newlib/newlib/libc/argz/_for_lib_argz/argz_stringify.o.depend","./armv7/lib/newlib/newlib/libc/argz/_for_lib_argz/envz_merge.o.depend","./armv7/lib/newlib/newlib/libc/argz/_for_lib_argz/envz_strip.o.depend","./armv7/lib/newlib/newlib/libc/argz/_for_lib_argz/buf_findstr.o.depend","./armv7/lib/newlib/newlib/libc/argz/_for_lib_argz/envz_get.o.depend","./armv7/lib/newlib/newlib/libc/argz/_for_lib_argz/envz_get.o","./armv7/lib/newlib/newlib/libc/argz/_for_lib_argz/argz_count.o","./armv7/lib/newlib/newlib/libc/argz/_for_lib_argz/envz_remove.o.depend","./armv7/lib/newlib/newlib/libc/argz/_for_lib_argz/envz_remove.o","./armv7/lib/newlib/newlib/libc/argz/_for_lib_argz/envz_add.o.depend","./armv7/lib/newlib/newlib/libc/argz/_for_lib_argz/dummy.o","./armv7/lib/newlib/newlib/libc/argz/_for_lib_argz/envz_merge.o","./armv7/lib/newlib/newlib/libc/argz/_for_lib_argz/argz_add_sep.o.depend","./armv7/lib/newlib/newlib/libc/argz/_for_lib_argz/argz_replace.o","./armv7/lib/newlib/newlib/libc/argz/_for_lib_argz/.marker","./armv7/lib/newlib/newlib/libc/argz/_for_lib_argz/envz_entry.o.depend","./armv7/lib/newlib/newlib/libc/argz/_for_lib_argz/argz_append.o","./armv7/lib/newlib/newlib/libc/argz/_for_lib_argz/argz_add.o.depend","./armv7/lib/newlib/newlib/libc/argz/_for_lib_argz/argz_stringify.o","./armv7/lib/newlib/newlib/libc/argz/_for_lib_argz/envz_entry.o","./armv7/lib/newlib/newlib/libc/argz/_for_lib_argz/argz_create_sep.o","./armv7/lib/newlib/newlib/libc/argz/_for_lib_argz/envz_strip.o","./armv7/lib/newlib/newlib/libc/argz/_for_lib_argz/argz_add.o","./armv7/lib/newlib/newlib/libc/argz/_for_lib_argz/argz_delete.o","./armv7/lib/newlib/newlib/libc/argz/_for_lib_argz/buf_findstr.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_finite.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_infinity.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/lrintl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_nan.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/scalblnl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/truncl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sqrtl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_log1p.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/fabsl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_infinity.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sinl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_expm1.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/nanl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/logl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/fmal.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_copysign.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_isnan.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_fdim.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/acosl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_fdim.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/ldexpl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/atanl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_remquo.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_nearbyint.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/cbrtl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/fmal.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/floorl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_infconst.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_matherr.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/llrintl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_finite.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_pow10.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/remainderl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_fma.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_nextafter.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_scalbln.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/expm1l.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_llrint.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_rint.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/lgammal.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/hypotl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/copysignl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_copysign.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/nextafterl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/roundl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/llroundl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_round.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/coshl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_scalbln.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_logb.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_lib_ver.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/fabsl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/scalbnl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_rint.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/lrintl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_finite.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_ilogb.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_infinity.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/log10l.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/llroundl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_fdim.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_fmin.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_isinfd.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/ilogbl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/floorl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/acoshl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_round.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_modf.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_log1p.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/exp2l.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_isnanf.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/tanhl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/frexpl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_isinf.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/remainderl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_pow10.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_llround.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/erfl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_fpclassify.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/fmodl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_nextafter.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_llrint.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/fdiml.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sinl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_cbrt.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_trunc.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/tanhl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_fma.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/modfl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_isnanf.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_fmax.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_trunc.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_exp10.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_llrint.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_fmax.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/powl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_isnan.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_isnand.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_finite.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_fmax.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_trunc.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/frexpl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/powl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_llround.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_lrint.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sqrtl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_lround.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_isinfd.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/nanl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/copysignl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_round.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/atanhl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_fdim.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_rint.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_nan.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_scalbn.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/tanl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_exp10.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/nearbyintl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_scalbn.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/lroundl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/asinl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_isnan.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_isinff.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_ilogb.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_llround.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/lgammal.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_nextafter.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_logb.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/fminl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/scalbnl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_llround.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/log10l.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/atan2l.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_nan.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_isinf.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_remquo.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_isinff.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_remquo.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_log1p.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_fpclassify.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/cosl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_matherr.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_scalbln.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/coshl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/rintl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_log2.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/cosl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_cbrt.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_log2.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_log2.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_lib_ver.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_log2.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_signbit.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/fmaxl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/truncl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_lrint.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/acosl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/modfl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/scalblnl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_exp10.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_modf.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/nextafterl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_fpclassify.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_expm1.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_copysign.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_isnand.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/log1pl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/llrintl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_nan.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_fmax.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_expm1.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_lround.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/nearbyintl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/tanl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_scalbn.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_infinity.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_infconst.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/atanhl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_lrint.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_nextafter.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_scalbln.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_logb.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_isinf.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_rint.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_remquo.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/hypotl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/fmaxl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/tgammal.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_pow10.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/fminl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/acoshl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/exp2l.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/rintl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_signbit.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/ilogbl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/.marker","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_fma.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_ilogb.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/fmodl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/asinl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/expl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_round.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_log1p.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_logb.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/fdiml.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/ceill.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/expl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_isnan.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/ceill.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sinhl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/tgammal.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/atanl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/ldexpl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_trunc.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/erfl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/expm1l.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/erfcl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_fmin.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_modf.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_scalbn.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/remquol.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_lround.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_pow10.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_fmin.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_cbrt.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_nearbyint.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/logl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_copysign.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sinhl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_llrint.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_ilogb.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/cbrtl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_lround.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_nearbyint.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_cbrt.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/log1pl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_nearbyint.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/erfcl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_fma.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/asinhl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/atan2l.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/remquol.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/asinhl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/lroundl.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/roundl.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_fpclassify.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_fmin.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_lrint.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_modf.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_expm1.o.depend","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/sf_exp10.o","./armv7/lib/newlib/newlib/libm/common/_for_lib_common/s_isinf.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/cacos.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/cprojf.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/clogf.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/ctanh.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/catanh.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/cexp.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/ctanf.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/cephes_subrf.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/casinf.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/cexpf.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/carg.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/cpow.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/cephes_subrf.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/casin.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/csqrt.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/cacosf.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/catanf.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/cproj.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/ccos.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/cexp.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/csinhf.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/clogf.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/casinhf.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/clog.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/catanhf.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/cabsf.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/ccosh.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/cpowf.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/catanh.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/crealf.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/ctanh.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/cephes_subr.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/casinf.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/cproj.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/crealf.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/ctanhf.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/catanhf.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/cimag.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/ctan.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/ccosh.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/cargf.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/casinhf.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/casin.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/cephes_subr.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/cacoshf.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/ccosf.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/csinh.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/conjf.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/csinf.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/casinh.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/ccoshf.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/cacosh.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/cargf.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/ctanf.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/ctan.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/cimag.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/csqrtf.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/cpow.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/csin.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/conjf.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/cacosf.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/ctanhf.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/cacos.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/conj.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/cexpf.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/cacoshf.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/creal.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/cacosh.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/casinh.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/.marker","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/cprojf.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/csqrtf.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/cabsf.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/catan.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/csin.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/csinhf.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/csinf.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/cimagf.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/csqrt.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/cabs.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/ccoshf.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/conj.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/cpowf.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/creal.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/ccosf.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/cabs.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/clog.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/ccos.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/csinh.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/catanf.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/cimagf.o.depend","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/carg.o","./armv7/lib/newlib/newlib/libm/complex/_for_lib_complex/catan.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_exp2.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_j0.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/ef_acos.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_lgamma.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/e_hypot.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/s_ldexp.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/s_sin.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/e_rem_pio2.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/ef_fmod.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_log10.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/k_cos.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/ef_scalb.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/ef_sqrt.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_log10.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/e_acosh.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/k_standard.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/k_sin.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_acosh.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/ef_sqrt.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wr_gamma.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wr_lgamma.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_acos.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_scalb.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_tgamma.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/k_rem_pio2.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/k_tan.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/e_fmod.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_sinh.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_tgamma.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_atan2.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/ef_log.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_cosh.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/s_frexp.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_sincos.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_scalb.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_atan2.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/ef_j1.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_cosh.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/e_atanh.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/e_j0.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/ef_pow.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/e_log10.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_j1.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/sf_ldexp.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/sf_asinh.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/ef_remainder.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/e_acosh.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/sf_ceil.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_sinh.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/ef_sinh.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/sf_frexp.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/e_pow.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_log.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/s_fabs.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/k_cos.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wr_lgamma.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_remainder.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/sf_ldexp.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_hypot.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/ef_hypot.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_acos.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/ef_acos.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/er_lgamma.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_drem.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/ef_cosh.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/erf_lgamma.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/e_atan2.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/ef_cosh.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/ef_remainder.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_lgamma.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wrf_gamma.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/s_tan.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_jn.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/e_j0.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/s_tanh.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_exp.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/s_asinh.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_fmod.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wrf_gamma.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/sf_ceil.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/e_exp.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_j1.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/sf_tan.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_acosh.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/kf_tan.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/e_cosh.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_pow.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_remainder.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/k_tan.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_exp.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_j0.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_sqrt.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/e_remainder.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/s_atan.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_scalb.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/sf_erf.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_log10.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_gamma.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_asin.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_log.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/s_ceil.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/er_lgamma.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/kf_cos.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_log10.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/sf_atan.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_atanh.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/ef_asin.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_fmod.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_tgamma.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/ef_jn.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/erf_gamma.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_j1.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/e_sqrt.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/sf_floor.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/ef_log.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/ef_j0.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/sf_tanh.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_acos.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_hypot.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/k_standard.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/ef_acosh.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_acos.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/s_signif.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/sf_atan.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_sincos.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/sf_signif.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/e_asin.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_jn.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wrf_lgamma.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_j0.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_asin.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_log.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_jn.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_cosh.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/ef_atanh.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/sf_floor.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_tgamma.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/er_gamma.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_exp2.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/s_asinh.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/e_acos.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/sf_frexp.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/e_j1.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_remainder.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_sqrt.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/sf_fabs.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_asin.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_j1.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/e_cosh.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_hypot.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/s_cos.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/kf_rem_pio2.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/ef_j0.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_jn.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/e_atan2.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_exp.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_gamma.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/ef_sinh.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/k_sin.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/sf_asinh.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_pow.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/s_erf.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/kf_tan.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/ef_rem_pio2.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/kf_cos.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/ef_pow.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/e_sinh.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/e_sqrt.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/k_rem_pio2.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_sincos.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_sinh.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/e_j1.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/e_pow.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_drem.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/sf_cos.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_exp2.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/ef_asin.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_sinh.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/e_log10.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/sf_tan.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/s_sin.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/sf_sin.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/e_jn.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/ef_log10.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_gamma.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_remainder.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/sf_sin.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/sf_erf.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/s_frexp.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/erf_gamma.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/s_cos.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/e_sinh.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_hypot.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_gamma.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/e_rem_pio2.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/er_gamma.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/ef_rem_pio2.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_atan2.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_exp2.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/ef_exp.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/e_log.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/erf_lgamma.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_cosh.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/kf_sin.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_pow.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/e_log.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/e_fmod.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_atan2.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/s_floor.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/ef_fmod.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/ef_atan2.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/.marker","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/e_hypot.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/e_jn.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_drem.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_j0.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_atanh.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/s_tan.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_pow.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/e_scalb.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_exp.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/ef_log10.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_sqrt.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/e_acos.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_atanh.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/ef_atanh.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_atanh.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/ef_atan2.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_sqrt.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_drem.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_acosh.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/s_tanh.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wr_gamma.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/s_signif.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/s_erf.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/ef_acosh.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/sf_signif.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_scalb.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_acosh.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_lgamma.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/s_atan.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/s_ceil.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_fmod.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/s_fabs.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/ef_j1.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/sf_tanh.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/e_exp.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/ef_hypot.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/ef_scalb.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wrf_lgamma.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_asin.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_lgamma.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/kf_sin.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/w_fmod.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/ef_exp.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/s_ldexp.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/e_atanh.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/sf_fabs.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/e_remainder.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_log.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/wf_sincos.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/ef_jn.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/e_asin.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/s_floor.o","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/kf_rem_pio2.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/e_scalb.o.depend","./armv7/lib/newlib/newlib/libm/math/_for_lib_math/sf_cos.o","./armv7/lib/getopt/_for_lib_getopt/.marker","./armv7/lib/getopt/_for_lib_getopt/getopt.o.depend","./armv7/lib/zlib/_for_lib_zlib/adler32.o.depend","./armv7/lib/zlib/_for_lib_zlib/inflate.o.depend","./armv7/lib/zlib/_for_lib_zlib/trees.o.depend","./armv7/lib/zlib/_for_lib_zlib/infback.o.depend","./armv7/lib/zlib/_for_lib_zlib/compress.o.depend","./armv7/lib/zlib/_for_lib_zlib/inffast.o.depend","./armv7/lib/zlib/_for_lib_zlib/deflate.o.depend","./armv7/lib/zlib/_for_lib_zlib/zutil.o.depend","./armv7/lib/zlib/_for_lib_zlib/uncompr.o.depend","./armv7/lib/zlib/_for_lib_zlib/.marker","./armv7/lib/zlib/_for_lib_zlib/inftrees.o.depend","./armv7/lib/zlib/_for_lib_zlib/crc32.o.depend","./armv7/lib/elf/_for_lib_elf/elf.o","./armv7/lib/elf/_for_lib_elf/elf64.o.depend","./armv7/lib/elf/_for_lib_elf/elf32.o.depend","./armv7/lib/elf/_for_lib_elf/.marker","./armv7/lib/elf/_for_lib_elf/elf32.o","./armv7/lib/elf/_for_lib_elf/elf64.o","./armv7/lib/elf/_for_lib_elf/elf.o.depend","./armv7/lib/crt/crtbegin.o.depend","./armv7/lib/crt/crtend.o","./armv7/lib/crt/crtbegin.o","./armv7/lib/crt/.marker","./armv7/lib/crt/crtend.o.depend","./armv7/lib/crt/arch/arm/crt0.o","./armv7/lib/crt/arch/arm/.marker","./armv7/lib/crt/arch/arm/crt0.o.depend","./armv7/kernel/memset.o","./armv7/kernel/stdlib.o.depend","./armv7/kernel/memmove.o","./armv7/kernel/string.o","./armv7/kernel/startup.o.depend","./armv7/kernel/cpu_omap44xx.map","./armv7/kernel/dispatch.o","./armv7/kernel/stdlib.o","./armv7/kernel/memset.o.depend","./armv7/kernel/memmove.o.depend","./armv7/kernel/startup.o","./armv7/kernel/.marker","./armv7/kernel/printf.o","./armv7/kernel/dispatch.o.depend","./armv7/kernel/string.o.depend","./armv7/kernel/cpu_omap44xx.lds","./armv7/kernel/printf.o.depend","./armv7/kernel/arch/armv7/kludges.o.depend","./armv7/kernel/arch/armv7/kputchar.o.depend","./armv7/kernel/arch/armv7/kputchar.o","./armv7/kernel/arch/armv7/exceptions.o","./armv7/kernel/arch/armv7/kludges.o","./armv7/kernel/arch/armv7/exceptions.o.depend","./armv7/kernel/arch/armv7/.marker","./armv7/kernel/arch/armv7/cp15.o","./armv7/kernel/arch/armv7/cp15.o.depend","./armv7/kernel/arch/arm/exn.o","./armv7/kernel/arch/arm/exn.o.depend","./armv7/kernel/arch/arm/misc.o","./armv7/kernel/arch/arm/.marker","./armv7/kernel/arch/arm/misc.o.depend","./armv7/kernel/arch/omap44xx/paging.o.depend","./armv7/kernel/arch/omap44xx/boot.o","./armv7/kernel/arch/omap44xx/omap_led.o.depend","./armv7/kernel/arch/omap44xx/multiboot.o","./armv7/kernel/arch/omap44xx/startup_helpers.o","./armv7/kernel/arch/omap44xx/omap_uart.o.depend","./armv7/kernel/arch/omap44xx/boot.o.depend","./armv7/kernel/arch/omap44xx/init.o.depend","./armv7/kernel/arch/omap44xx/omap_led.o","./armv7/kernel/arch/omap44xx/startup_arch.o","./armv7/kernel/arch/omap44xx/startup_helpers.o.depend","./armv7/kernel/arch/omap44xx/omap_gic.o.depend","./armv7/kernel/arch/omap44xx/.marker","./armv7/kernel/arch/omap44xx/init.o","./armv7/kernel/arch/omap44xx/omap_uart.o","./armv7/kernel/arch/omap44xx/paging.o","./armv7/kernel/arch/omap44xx/omap_gic.o","./armv7/kernel/arch/omap44xx/multiboot.o.depend","./armv7/kernel/arch/omap44xx/startup_arch.o.depend","./armv7/tools/asmoffsets/asmoffsets.s","./armv7/tools/asmoffsets/asmoffsets.s.depend","./armv7/tools/asmoffsets/.marker","./armv7/errors/errno.o","./armv7/errors/errno.c","./armv7/errors/.marker","./armv7/errors/errno.o.depend","./hake/ArchDefaults.hs","./hake/menu.lst.xscale","./hake/x86_64-dM.txt","./hake/X86_32.hi","./hake/RuleDefs.o","./hake/menu.lst.x86_32","./hake/menu.lst.aos","./hake/XScale.o","./hake/XScale.hi","./hake/HakeTypes.hs","./hake/menu.lst.arm_gem5","./hake/X86_64.o","./hake/RuleDefs.hs","./hake/RuleDefs.hi","./hake/Config.hs","./hake/ARM11MP.o","./hake/menu.lst.arm_gem5_mc","./hake/hake","./hake/Main.o","./hake/x86_32-dM.txt","./hake/Hakefile","./hake/X86_64.hi","./hake/Main.hs","./hake/ARMv7.hi","./hake/menu.lst.scc","./hake/ArchDefaults.hi","./hake/XScale.hs","./hake/Path.o","./hake/ARMv7.hs","./hake/Config.hi","./hake/menu.lst.pandaboard","./hake/arm-mpcore-dM.txt","./hake/ARM11MP.hs","./hake/arm926ej-s-dM.txt","./hake/SCC.o","./hake/menu.lst.armv5","./hake/ARMv5.hs","./hake/ARM11MP.hi","./hake/Args.o","./hake/ArchDefaults.o","./hake/Main.hi","./hake/menu.lst.m5","./hake/SCC.hi","./hake/HakeTypes.o","./hake/X86_32.o","./hake/Args.hi","./hake/ARMv5.o","./hake/SCC.hs","./hake/menu.lst.arm_gem5_panda","./hake/Path.hi","./hake/hake.sh","./hake/Config.o","./hake/X86_64.hs","./hake/.marker","./hake/Config.hs.template","./hake/X86_32.hs","./hake/ARMv5.hi","./hake/Path.hs","./hake/Args.hs","./hake/ARMv7.o","./hake/menu.lst.x86_64","./hake/notes.txt","./hake/symbolic_targets.mk","./hake/Hakefiles.o","./hake/Hakefiles.hi","./hake/arm11mpcore-dM.txt","./hake/HakeTypes.hi","./doc/Doxyfile.cmake","./doc/008-tracing/Hakefile","./doc/008-tracing/Tracing.tex","./doc/008-tracing/images/aquarium-activities.png","./doc/008-tracing/images/pleco-process.pdf","./doc/008-tracing/images/flush.pdf","./doc/008-tracing/images/aquarium.png","./doc/008-tracing/images/ntp.pdf","./doc/008-tracing/images/aquarium-filters.png","./doc/008-tracing/images/boxplot.pdf","./doc/008-tracing/images/classdiag-input.png","./doc/008-tracing/images/classdiag-output.png","./doc/002-mackerel/Hakefile","./doc/002-mackerel/Mackerel.tex","./doc/style/bfish-logo.pdf","./doc/style/barrelfish.bib","./doc/style/bftn-template.tex","./doc/style/bfish-logo.png","./doc/style/defs.bib","./doc/style/bftn.sty","./doc/011-idc/Hakefile","./doc/011-idc/IDC.tex","./doc/011-idc/figures/ump_bind.pdf","./doc/011-idc/figures/ump_bind.svg","./doc/010-spec/Spec.tex","./doc/010-spec/cap_types.dot","./doc/010-spec/disp_states_simple_save_area_analysis.dot","./doc/010-spec/Hakefile","./doc/010-spec/app_cspace.dot","./doc/010-spec/disp_states_simple.circo","./doc/010-spec/init_cspace.dot","./doc/000-overview/os-arch.pdf","./doc/000-overview/UMP.pdf","./doc/000-overview/cap_translation.pdf","./doc/000-overview/cap_heirarchy.pdf","./doc/000-overview/Hakefile","./doc/000-overview/Overview.tex","./doc/000-overview/dcb.pdf","./doc/000-overview/LMP.pdf","./doc/000-overview/graffle/Overview.graffle","./doc/000-overview/graffle/LMP.graffle","./doc/000-overview/graffle/Capabilities.graffle","./doc/000-overview/graffle/Capabilities_Addr.graffle","./doc/000-overview/graffle/Dispatcher.graffle","./doc/000-overview/graffle/UMP.graffle","./doc/003-hake/Hakefile","./doc/003-hake/Hake.tex","./doc/009-notifications/Hakefile","./doc/009-notifications/umpnotify.svg","./doc/009-notifications/umpnotify.pdf","./doc/009-notifications/Notify.tex","./doc/013-capability-mgmt/acks-problem.pdf","./doc/013-capability-mgmt/causal-problem.vsd","./doc/013-capability-mgmt/CapMgmt.tex","./doc/013-capability-mgmt/cap_types.dot","./doc/013-capability-mgmt/Hakefile","./doc/013-capability-mgmt/type_system.tex","./doc/013-capability-mgmt/acks-problem.vsd","./doc/013-capability-mgmt/causal-problem.pdf","./doc/014-bulk-transfer/bulk-transfer.tex","./doc/014-bulk-transfer/Hakefile","./doc/005-scc/Hakefile","./doc/005-scc/sloccount.txt","./doc/005-scc/SCC.tex","./doc/005-scc/figures/exp2.pdf","./doc/005-scc/figures/exp1.svg","./doc/005-scc/figures/exp1.pdf","./doc/005-scc/figures/exp2.svg","./doc/005-scc/plots/header.gnuplot","./doc/005-scc/plots/mpbbench/mpbbench_recv.dat","./doc/005-scc/plots/mpbbench/Makefile","./doc/005-scc/plots/mpbbench/mpbbench_oneway.pdf","./doc/005-scc/plots/mpbbench/plot-line.sh","./doc/005-scc/plots/mpbbench/mpbbench_oneway.dat","./doc/005-scc/plots/mpbbench/mpbbench_send.dat","./doc/005-scc/plots/rcce_bench/rcce_bt.pdf","./doc/005-scc/plots/rcce_bench/Makefile","./doc/005-scc/plots/rcce_bench/rcce_lu_speedup.pdf","./doc/005-scc/plots/rcce_bench/lu.dat","./doc/005-scc/plots/rcce_bench/rcce_lu.pdf","./doc/005-scc/plots/rcce_bench/rcce_bt_speedup.pdf","./doc/005-scc/plots/rcce_bench/plot-rcce.sh","./doc/005-scc/plots/rcce_bench/plot-rcce-speedup.sh","./doc/005-scc/plots/rcce_bench/bt.dat","./doc/015-disk-driver-arch/disk-driver-report.tex","./doc/015-disk-driver-arch/future.tex","./doc/015-disk-driver-arch/intro.tex","./doc/015-disk-driver-arch/running.tex","./doc/015-disk-driver-arch/related.tex","./doc/015-disk-driver-arch/usage.tex","./doc/015-disk-driver-arch/Hakefile","./doc/015-disk-driver-arch/conclusion.tex","./doc/015-disk-driver-arch/flounder-ahci.tex","./doc/015-disk-driver-arch/blockdevfs.tex","./doc/015-disk-driver-arch/references.bib","./doc/015-disk-driver-arch/title-settings.tex","./doc/015-disk-driver-arch/abstract.tex","./doc/015-disk-driver-arch/glossary.tex","./doc/015-disk-driver-arch/libahci.tex","./doc/015-disk-driver-arch/xahcid.tex","./doc/015-disk-driver-arch/design.tex","./doc/015-disk-driver-arch/fat.tex","./doc/015-disk-driver-arch/figures/h2d_fis.svg","./doc/015-disk-driver-arch/figures/fat32_layout.svg","./doc/015-disk-driver-arch/figures/blockdevfs_list.svg","./doc/015-disk-driver-arch/figures/mmap.svg","./doc/015-disk-driver-arch/figures/architecture.svg","./doc/015-disk-driver-arch/figures/pmem_overview.svg","./doc/015-disk-driver-arch/figures/command_table.png","./doc/015-disk-driver-arch/figures/command_list_structure.png","./doc/015-disk-driver-arch/figures/fat16_layout.svg","./doc/015-disk-driver-arch/figures/cache_design.svg","./doc/015-disk-driver-arch/figures/hba_mem.png","./doc/015-disk-driver-arch/figures/fillbench.svg","./doc/015-disk-driver-arch/figures/rfis_area.svg","./doc/015-disk-driver-arch/figures/dma_pool_design.svg","./doc/001-glossary/Hakefile","./doc/001-glossary/Main.hs","./doc/001-glossary/Glossary.tex","./doc/004-virtual_memory/Hakefile","./doc/004-virtual_memory/VirtualMemory.tex","./doc/016-serial-ports/Hakefile","./doc/016-serial-ports/Serial.tex","./doc/012-services/dep2-b-dot.pdf","./doc/012-services/deptree.py","./doc/012-services/status.txt","./doc/012-services/dep2-a-dot.pdf","./doc/012-services/services.txt","./doc/012-services/Hakefile","./doc/012-services/dep2-f-dot","./doc/012-services/dep2-b-dot","./doc/012-services/dep2-f-dot.pdf","./doc/012-services/dep.txt","./doc/012-services/layers.txt","./doc/012-services/categories.txt","./doc/012-services/makedeptxt.sh","./doc/012-services/Services.tex","./doc/012-services/dep2-a-dot","./doc/012-services/dep2-i-dot","./doc/012-services/questions.txt","./doc/012-services/dependencies.txt","./doc/012-services/services-desc.txt","./doc/012-services/README.txt","./doc/012-services/deptree2.py","./doc/012-services/priorities.txt","./doc/012-services/dep2-i-dot.pdf","./doc/006-routing/many-to-many.pdf","./doc/006-routing/Hakefile","./doc/006-routing/many-to-many.vsd","./doc/006-routing/client-server.pdf","./doc/006-routing/client-monitor.pdf","./doc/006-routing/overview_multihop_channel.dia","./doc/006-routing/vcis.dia","./doc/006-routing/client-server.vsd","./doc/006-routing/overview_multihop_channel.pdf","./doc/006-routing/api.h","./doc/006-routing/vcis.pdf","./doc/006-routing/Routing.tex","./doc/006-routing/client-monitor.vsd","./usr/init/Hakefile","./usr/init/main.c","./usr/init/init.c","./usr/init/include/debug.h","./usr/init/include/syscall_arch.h","./usr/init/include/helpers.h","./usr/init/include/morecore.h","./usr/init/include/syscalls.h","./usr/init/include/init.h","./usr/init/include/static_assert.h","./usr/init/syscall/syscalls.c","./usr/init/syscall/syscall.S","./usr/init/libc_glue/debug_printf.c","./usr/init/libc_glue/morecore.c","./lib/collections/hash_table.c","./lib/collections/Hakefile","./lib/collections/flipbuffer.c","./lib/collections/stack.c","./lib/collections/list.c","./lib/procon/Hakefile","./lib/procon/procon.c","./lib/newlib/mkdep","./lib/newlib/ltoptions.m4","./lib/newlib/makefile.vms","./lib/newlib/ltsugar.m4","./lib/newlib/lt~obsolete.m4","./lib/newlib/Hakefile","./lib/newlib/move-if-change","./lib/newlib/install-sh","./lib/newlib/configure","./lib/newlib/ltversion.m4","./lib/newlib/setup.com","./lib/newlib/README-maintainer-mode","./lib/newlib/mkinstalldirs","./lib/newlib/MAINTAINERS","./lib/newlib/ltgcc.m4","./lib/newlib/newlib/newlib.hin","./lib/newlib/newlib/stamp-h.in","./lib/newlib/newlib/Makefile.in","./lib/newlib/newlib/Hakefile","./lib/newlib/newlib/aclocal.m4","./lib/newlib/newlib/configure.in","./lib/newlib/newlib/acconfig.h","./lib/newlib/newlib/confsubdir.m4","./lib/newlib/newlib/NEWS","./lib/newlib/newlib/Makefile.am","./lib/newlib/newlib/HOWTO","./lib/newlib/newlib/acinclude.m4","./lib/newlib/newlib/configure.host","./lib/newlib/newlib/MAINTAINERS","./lib/newlib/newlib/Makefile.shared","./lib/newlib/newlib/libc/sys.tex","./lib/newlib/newlib/libc/Makefile.in","./lib/newlib/newlib/libc/Hakefile","./lib/newlib/newlib/libc/aclocal.m4","./lib/newlib/newlib/libc/configure.in","./lib/newlib/newlib/libc/Makefile.am","./lib/newlib/newlib/libc/saber","./lib/newlib/newlib/libc/iconv/iconv.tex","./lib/newlib/newlib/libc/iconv/Makefile.in","./lib/newlib/newlib/libc/iconv/Makefile.am","./lib/newlib/newlib/libc/iconv/encoding.aliases","./lib/newlib/newlib/libc/iconv/ces/utf-8.c","./lib/newlib/newlib/libc/iconv/ces/cesbi.h","./lib/newlib/newlib/libc/iconv/ces/table.c","./lib/newlib/newlib/libc/iconv/ces/cesbi.c","./lib/newlib/newlib/libc/iconv/ces/ucs-2-internal.c","./lib/newlib/newlib/libc/iconv/ces/cesdeps.h","./lib/newlib/newlib/libc/iconv/ces/Makefile.in","./lib/newlib/newlib/libc/iconv/ces/euc.c","./lib/newlib/newlib/libc/iconv/ces/ucs-2.c","./lib/newlib/newlib/libc/iconv/ces/ucs-4-internal.c","./lib/newlib/newlib/libc/iconv/ces/table-pcs.c","./lib/newlib/newlib/libc/iconv/ces/utf-16.c","./lib/newlib/newlib/libc/iconv/ces/us-ascii.c","./lib/newlib/newlib/libc/iconv/ces/ucs-4.c","./lib/newlib/newlib/libc/iconv/ces/Makefile.am","./lib/newlib/newlib/libc/iconv/ces/mkdeps.pl","./lib/newlib/newlib/libc/iconv/lib/local.h","./lib/newlib/newlib/libc/iconv/lib/iconvnls.h","./lib/newlib/newlib/libc/iconv/lib/encnames.h","./lib/newlib/newlib/libc/iconv/lib/iconvnls.c","./lib/newlib/newlib/libc/iconv/lib/aliasesbi.c","./lib/newlib/newlib/libc/iconv/lib/iconv.c","./lib/newlib/newlib/libc/iconv/lib/Makefile.in","./lib/newlib/newlib/libc/iconv/lib/aliasesi.c","./lib/newlib/newlib/libc/iconv/lib/encoding.deps","./lib/newlib/newlib/libc/iconv/lib/ucsconv.h","./lib/newlib/newlib/libc/iconv/lib/nullconv.c","./lib/newlib/newlib/libc/iconv/lib/endian.h","./lib/newlib/newlib/libc/iconv/lib/Makefile.am","./lib/newlib/newlib/libc/iconv/lib/conv.h","./lib/newlib/newlib/libc/iconv/lib/ucsconv.c","./lib/newlib/newlib/libc/iconv/ccs/mktbl.pl","./lib/newlib/newlib/libc/iconv/ccs/win_1256.c","./lib/newlib/newlib/libc/iconv/ccs/ccsbi.h","./lib/newlib/newlib/libc/iconv/ccs/iso_8859_11.c","./lib/newlib/newlib/libc/iconv/ccs/iso_8859_15.c","./lib/newlib/newlib/libc/iconv/ccs/cns11643_plane14.c","./lib/newlib/newlib/libc/iconv/ccs/big5.c","./lib/newlib/newlib/libc/iconv/ccs/ccsbi.c","./lib/newlib/newlib/libc/iconv/ccs/win_1255.c","./lib/newlib/newlib/libc/iconv/ccs/ccsnames.h","./lib/newlib/newlib/libc/iconv/ccs/iso_8859_4.c","./lib/newlib/newlib/libc/iconv/ccs/cp850.c","./lib/newlib/newlib/libc/iconv/ccs/win_1252.c","./lib/newlib/newlib/libc/iconv/ccs/Makefile.in","./lib/newlib/newlib/libc/iconv/ccs/jis_x0208_1990.c","./lib/newlib/newlib/libc/iconv/ccs/cp852.c","./lib/newlib/newlib/libc/iconv/ccs/iso_8859_1.c","./lib/newlib/newlib/libc/iconv/ccs/iso_8859_7.c","./lib/newlib/newlib/libc/iconv/ccs/win_1254.c","./lib/newlib/newlib/libc/iconv/ccs/win_1257.c","./lib/newlib/newlib/libc/iconv/ccs/iso_8859_6.c","./lib/newlib/newlib/libc/iconv/ccs/iso_8859_5.c","./lib/newlib/newlib/libc/iconv/ccs/cp855.c","./lib/newlib/newlib/libc/iconv/ccs/ksx1001.c","./lib/newlib/newlib/libc/iconv/ccs/win_1258.c","./lib/newlib/newlib/libc/iconv/ccs/iso_8859_2.c","./lib/newlib/newlib/libc/iconv/ccs/win_1253.c","./lib/newlib/newlib/libc/iconv/ccs/koi8_ru.c","./lib/newlib/newlib/libc/iconv/ccs/jis_x0212_1990.c","./lib/newlib/newlib/libc/iconv/ccs/cns11643_plane1.c","./lib/newlib/newlib/libc/iconv/ccs/iso_8859_9.c","./lib/newlib/newlib/libc/iconv/ccs/koi8_uni.c","./lib/newlib/newlib/libc/iconv/ccs/win_1250.c","./lib/newlib/newlib/libc/iconv/ccs/jis_x0201_1976.c","./lib/newlib/newlib/libc/iconv/ccs/cp866.c","./lib/newlib/newlib/libc/iconv/ccs/koi8_r.c","./lib/newlib/newlib/libc/iconv/ccs/iso_8859_13.c","./lib/newlib/newlib/libc/iconv/ccs/iso_8859_8.c","./lib/newlib/newlib/libc/iconv/ccs/Makefile.am","./lib/newlib/newlib/libc/iconv/ccs/iso_8859_3.c","./lib/newlib/newlib/libc/iconv/ccs/cns11643_plane2.c","./lib/newlib/newlib/libc/iconv/ccs/koi8_u.c","./lib/newlib/newlib/libc/iconv/ccs/iso_ir_111.c","./lib/newlib/newlib/libc/iconv/ccs/iso_8859_14.c","./lib/newlib/newlib/libc/iconv/ccs/cp775.c","./lib/newlib/newlib/libc/iconv/ccs/iso_8859_10.c","./lib/newlib/newlib/libc/iconv/ccs/win_1251.c","./lib/newlib/newlib/libc/iconv/ccs/ccs.h","./lib/newlib/newlib/libc/iconv/ccs/binary/Makefile.in","./lib/newlib/newlib/libc/iconv/ccs/binary/Makefile.am","./lib/newlib/newlib/libc/machine/Makefile.in","./lib/newlib/newlib/libc/machine/aclocal.m4","./lib/newlib/newlib/libc/machine/configure.in","./lib/newlib/newlib/libc/machine/Makefile.am","./lib/newlib/newlib/libc/machine/w65/udivhi3.S","./lib/newlib/newlib/libc/machine/w65/smulhi3.S","./lib/newlib/newlib/libc/machine/w65/Makefile.in","./lib/newlib/newlib/libc/machine/w65/lshrhi.S","./lib/newlib/newlib/libc/machine/w65/cmpsi.c","./lib/newlib/newlib/libc/machine/w65/aclocal.m4","./lib/newlib/newlib/libc/machine/w65/configure","./lib/newlib/newlib/libc/machine/w65/configure.in","./lib/newlib/newlib/libc/machine/w65/sdivhi3.S","./lib/newlib/newlib/libc/machine/w65/umodhi3.S","./lib/newlib/newlib/libc/machine/w65/divsi3.c","./lib/newlib/newlib/libc/machine/w65/Makefile.am","./lib/newlib/newlib/libc/machine/w65/mulsi3.c","./lib/newlib/newlib/libc/machine/h8300/strcmp.S","./lib/newlib/newlib/libc/machine/h8300/memcpy.S","./lib/newlib/newlib/libc/machine/h8300/reg_memset.S","./lib/newlib/newlib/libc/machine/h8300/memset.S","./lib/newlib/newlib/libc/machine/h8300/setjmp.S","./lib/newlib/newlib/libc/machine/h8300/defines.h","./lib/newlib/newlib/libc/machine/h8300/h8sx_strcpy.S","./lib/newlib/newlib/libc/machine/h8300/Makefile.in","./lib/newlib/newlib/libc/machine/h8300/reg_memcpy.S","./lib/newlib/newlib/libc/machine/h8300/aclocal.m4","./lib/newlib/newlib/libc/machine/h8300/setarch.h","./lib/newlib/newlib/libc/machine/h8300/configure","./lib/newlib/newlib/libc/machine/h8300/configure.in","./lib/newlib/newlib/libc/machine/h8300/Makefile.am","./lib/newlib/newlib/libc/machine/a29k/Makefile.in","./lib/newlib/newlib/libc/machine/a29k/aclocal.m4","./lib/newlib/newlib/libc/machine/a29k/configure","./lib/newlib/newlib/libc/machine/a29k/configure.in","./lib/newlib/newlib/libc/machine/a29k/Makefile.am","./lib/newlib/newlib/libc/machine/h8500/divhi3.S","./lib/newlib/newlib/libc/machine/h8500/psi.S","./lib/newlib/newlib/libc/machine/h8500/setjmp.S","./lib/newlib/newlib/libc/machine/h8500/mulhi3.c","./lib/newlib/newlib/libc/machine/h8500/negsi2.c","./lib/newlib/newlib/libc/machine/h8500/Makefile.in","./lib/newlib/newlib/libc/machine/h8500/cmpsi.c","./lib/newlib/newlib/libc/machine/h8500/aclocal.m4","./lib/newlib/newlib/libc/machine/h8500/configure","./lib/newlib/newlib/libc/machine/h8500/configure.in","./lib/newlib/newlib/libc/machine/h8500/divsi3.c","./lib/newlib/newlib/libc/machine/h8500/Makefile.am","./lib/newlib/newlib/libc/machine/h8500/shifts.c","./lib/newlib/newlib/libc/machine/h8500/mulsi3.c","./lib/newlib/newlib/libc/machine/xscale/memchr.c","./lib/newlib/newlib/libc/machine/xscale/memmove.c","./lib/newlib/newlib/libc/machine/xscale/strchr.c","./lib/newlib/newlib/libc/machine/xscale/xscale.h","./lib/newlib/newlib/libc/machine/xscale/setjmp.S","./lib/newlib/newlib/libc/machine/xscale/memcmp.c","./lib/newlib/newlib/libc/machine/xscale/memcpy.c","./lib/newlib/newlib/libc/machine/xscale/Makefile.in","./lib/newlib/newlib/libc/machine/xscale/aclocal.m4","./lib/newlib/newlib/libc/machine/xscale/strlen.c","./lib/newlib/newlib/libc/machine/xscale/configure","./lib/newlib/newlib/libc/machine/xscale/memset.c","./lib/newlib/newlib/libc/machine/xscale/configure.in","./lib/newlib/newlib/libc/machine/xscale/strcpy.c","./lib/newlib/newlib/libc/machine/xscale/Makefile.am","./lib/newlib/newlib/libc/machine/xscale/strcmp.c","./lib/newlib/newlib/libc/machine/xscale/machine/profile.h","./lib/newlib/newlib/libc/machine/tic80/setjmp.S","./lib/newlib/newlib/libc/machine/tic80/Makefile.in","./lib/newlib/newlib/libc/machine/tic80/aclocal.m4","./lib/newlib/newlib/libc/machine/tic80/configure","./lib/newlib/newlib/libc/machine/tic80/configure.in","./lib/newlib/newlib/libc/machine/tic80/Makefile.am","./lib/newlib/newlib/libc/machine/powerpc/strtoufix64.c","./lib/newlib/newlib/libc/machine/powerpc/vec_calloc.c","./lib/newlib/newlib/libc/machine/powerpc/ufix64toa.c","./lib/newlib/newlib/libc/machine/powerpc/setjmp.S","./lib/newlib/newlib/libc/machine/powerpc/atosfix16.c","./lib/newlib/newlib/libc/machine/powerpc/strtosfix64.c","./lib/newlib/newlib/libc/machine/powerpc/Makefile.in","./lib/newlib/newlib/libc/machine/powerpc/atoufix64.c","./lib/newlib/newlib/libc/machine/powerpc/strtoufix32.c","./lib/newlib/newlib/libc/machine/powerpc/strtosfix32.c","./lib/newlib/newlib/libc/machine/powerpc/strtosfix16.c","./lib/newlib/newlib/libc/machine/powerpc/aclocal.m4","./lib/newlib/newlib/libc/machine/powerpc/atosfix32.c","./lib/newlib/newlib/libc/machine/powerpc/vec_realloc.c","./lib/newlib/newlib/libc/machine/powerpc/vfprintf.c","./lib/newlib/newlib/libc/machine/powerpc/vec_malloc.c","./lib/newlib/newlib/libc/machine/powerpc/vfscanf.c","./lib/newlib/newlib/libc/machine/powerpc/configure","./lib/newlib/newlib/libc/machine/powerpc/atoufix16.c","./lib/newlib/newlib/libc/machine/powerpc/configure.in","./lib/newlib/newlib/libc/machine/powerpc/vec_mallocr.c","./lib/newlib/newlib/libc/machine/powerpc/strtoufix16.c","./lib/newlib/newlib/libc/machine/powerpc/vec_free.c","./lib/newlib/newlib/libc/machine/powerpc/simdldtoa.c","./lib/newlib/newlib/libc/machine/powerpc/Makefile.am","./lib/newlib/newlib/libc/machine/powerpc/fix64.h","./lib/newlib/newlib/libc/machine/powerpc/times.c","./lib/newlib/newlib/libc/machine/powerpc/atoufix32.c","./lib/newlib/newlib/libc/machine/powerpc/atosfix64.c","./lib/newlib/newlib/libc/machine/powerpc/machine/malloc.h","./lib/newlib/newlib/libc/machine/powerpc/machine/stdlib.h","./lib/newlib/newlib/libc/machine/sparc/setjmp.S","./lib/newlib/newlib/libc/machine/sparc/Makefile.in","./lib/newlib/newlib/libc/machine/sparc/aclocal.m4","./lib/newlib/newlib/libc/machine/sparc/scan.c","./lib/newlib/newlib/libc/machine/sparc/configure","./lib/newlib/newlib/libc/machine/sparc/configure.in","./lib/newlib/newlib/libc/machine/sparc/Makefile.am","./lib/newlib/newlib/libc/machine/sparc/shuffle.c","./lib/newlib/newlib/libc/machine/sparc/machine/sparclet.h","./lib/newlib/newlib/libc/machine/cr16/setjmp.S","./lib/newlib/newlib/libc/machine/cr16/Makefile.in","./lib/newlib/newlib/libc/machine/cr16/aclocal.m4","./lib/newlib/newlib/libc/machine/cr16/configure","./lib/newlib/newlib/libc/machine/cr16/configure.in","./lib/newlib/newlib/libc/machine/cr16/Makefile.am","./lib/newlib/newlib/libc/machine/cr16/getenv.c","./lib/newlib/newlib/libc/machine/cr16/sys/libh.h","./lib/newlib/newlib/libc/machine/cr16/sys/syscall.h","./lib/newlib/newlib/libc/machine/cr16/sys/asm.h","./lib/newlib/newlib/libc/machine/crx/setjmp.S","./lib/newlib/newlib/libc/machine/crx/Makefile.in","./lib/newlib/newlib/libc/machine/crx/aclocal.m4","./lib/newlib/newlib/libc/machine/crx/configure","./lib/newlib/newlib/libc/machine/crx/configure.in","./lib/newlib/newlib/libc/machine/crx/Makefile.am","./lib/newlib/newlib/libc/machine/crx/getenv.c","./lib/newlib/newlib/libc/machine/crx/sys/libh.h","./lib/newlib/newlib/libc/machine/crx/sys/syscall.h","./lib/newlib/newlib/libc/machine/crx/sys/asm.h","./lib/newlib/newlib/libc/machine/microblaze/longjmp.S","./lib/newlib/newlib/libc/machine/microblaze/abort.c","./lib/newlib/newlib/libc/machine/microblaze/setjmp.S","./lib/newlib/newlib/libc/machine/microblaze/Makefile.in","./lib/newlib/newlib/libc/machine/microblaze/aclocal.m4","./lib/newlib/newlib/libc/machine/microblaze/strlen.c","./lib/newlib/newlib/libc/machine/microblaze/configure","./lib/newlib/newlib/libc/machine/microblaze/configure.in","./lib/newlib/newlib/libc/machine/microblaze/strcpy.c","./lib/newlib/newlib/libc/machine/microblaze/Makefile.am","./lib/newlib/newlib/libc/machine/microblaze/strcmp.c","./lib/newlib/newlib/libc/machine/mt/setjmp.S","./lib/newlib/newlib/libc/machine/mt/Makefile.in","./lib/newlib/newlib/libc/machine/mt/aclocal.m4","./lib/newlib/newlib/libc/machine/mt/configure","./lib/newlib/newlib/libc/machine/mt/configure.in","./lib/newlib/newlib/libc/machine/mt/Makefile.am","./lib/newlib/newlib/libc/machine/d30v/setjmp.S","./lib/newlib/newlib/libc/machine/d30v/Makefile.in","./lib/newlib/newlib/libc/machine/d30v/aclocal.m4","./lib/newlib/newlib/libc/machine/d30v/configure","./lib/newlib/newlib/libc/machine/d30v/configure.in","./lib/newlib/newlib/libc/machine/d30v/Makefile.am","./lib/newlib/newlib/libc/machine/xstormy16/tiny-malloc.c","./lib/newlib/newlib/libc/machine/xstormy16/setjmp.S","./lib/newlib/newlib/libc/machine/xstormy16/Makefile.in","./lib/newlib/newlib/libc/machine/xstormy16/aclocal.m4","./lib/newlib/newlib/libc/machine/xstormy16/configure","./lib/newlib/newlib/libc/machine/xstormy16/mallocr.c","./lib/newlib/newlib/libc/machine/xstormy16/configure.in","./lib/newlib/newlib/libc/machine/xstormy16/Makefile.am","./lib/newlib/newlib/libc/machine/xc16x/setjmp.S","./lib/newlib/newlib/libc/machine/xc16x/Makefile.in","./lib/newlib/newlib/libc/machine/xc16x/puts.c","./lib/newlib/newlib/libc/machine/xc16x/aclocal.m4","./lib/newlib/newlib/libc/machine/xc16x/configure","./lib/newlib/newlib/libc/machine/xc16x/configure.in","./lib/newlib/newlib/libc/machine/xc16x/Makefile.am","./lib/newlib/newlib/libc/machine/xc16x/putchar.c","./lib/newlib/newlib/libc/machine/cris/memmove.c","./lib/newlib/newlib/libc/machine/cris/memcpy.c","./lib/newlib/newlib/libc/machine/cris/Makefile.in","./lib/newlib/newlib/libc/machine/cris/setjmp.c","./lib/newlib/newlib/libc/machine/cris/aclocal.m4","./lib/newlib/newlib/libc/machine/cris/configure","./lib/newlib/newlib/libc/machine/cris/memset.c","./lib/newlib/newlib/libc/machine/cris/configure.in","./lib/newlib/newlib/libc/machine/cris/libcdtor.c","./lib/newlib/newlib/libc/machine/cris/Makefile.am","./lib/newlib/newlib/libc/machine/cris/include/pthread.h","./lib/newlib/newlib/libc/machine/cris/sys/fcntl.h","./lib/newlib/newlib/libc/machine/cris/sys/errno.h","./lib/newlib/newlib/libc/machine/cris/sys/signal.h","./lib/newlib/newlib/libc/machine/m68hc11/setjmp.S","./lib/newlib/newlib/libc/machine/m68hc11/Makefile.in","./lib/newlib/newlib/libc/machine/m68hc11/aclocal.m4","./lib/newlib/newlib/libc/machine/m68hc11/configure","./lib/newlib/newlib/libc/machine/m68hc11/configure.in","./lib/newlib/newlib/libc/machine/m68hc11/Makefile.am","./lib/newlib/newlib/libc/machine/mn10300/strcmp.S","./lib/newlib/newlib/libc/machine/mn10300/memcpy.S","./lib/newlib/newlib/libc/machine/mn10300/strchr.S","./lib/newlib/newlib/libc/machine/mn10300/memset.S","./lib/newlib/newlib/libc/machine/mn10300/setjmp.S","./lib/newlib/newlib/libc/machine/mn10300/Makefile.in","./lib/newlib/newlib/libc/machine/mn10300/strlen.S","./lib/newlib/newlib/libc/machine/mn10300/aclocal.m4","./lib/newlib/newlib/libc/machine/mn10300/memchr.S","./lib/newlib/newlib/libc/machine/mn10300/configure","./lib/newlib/newlib/libc/machine/mn10300/configure.in","./lib/newlib/newlib/libc/machine/mn10300/Makefile.am","./lib/newlib/newlib/libc/machine/mn10300/strcpy.S","./lib/newlib/newlib/libc/machine/mn10300/memcmp.S","./lib/newlib/newlib/libc/machine/m88k/setjmp.S","./lib/newlib/newlib/libc/machine/m88k/Makefile.in","./lib/newlib/newlib/libc/machine/m88k/aclocal.m4","./lib/newlib/newlib/libc/machine/m88k/configure","./lib/newlib/newlib/libc/machine/m88k/configure.in","./lib/newlib/newlib/libc/machine/m88k/Makefile.am","./lib/newlib/newlib/libc/machine/mn10200/setjmp.S","./lib/newlib/newlib/libc/machine/mn10200/Makefile.in","./lib/newlib/newlib/libc/machine/mn10200/aclocal.m4","./lib/newlib/newlib/libc/machine/mn10200/configure","./lib/newlib/newlib/libc/machine/mn10200/configure.in","./lib/newlib/newlib/libc/machine/mn10200/Makefile.am","./lib/newlib/newlib/libc/machine/hppa/strcmp.S","./lib/newlib/newlib/libc/machine/hppa/memcpy.S","./lib/newlib/newlib/libc/machine/hppa/strcat.S","./lib/newlib/newlib/libc/machine/hppa/memset.S","./lib/newlib/newlib/libc/machine/hppa/pcc_prefix.s","./lib/newlib/newlib/libc/machine/hppa/setjmp.S","./lib/newlib/newlib/libc/machine/hppa/DEFS.h","./lib/newlib/newlib/libc/machine/hppa/Makefile.in","./lib/newlib/newlib/libc/machine/hppa/strlen.S","./lib/newlib/newlib/libc/machine/hppa/aclocal.m4","./lib/newlib/newlib/libc/machine/hppa/memchr.S","./lib/newlib/newlib/libc/machine/hppa/configure","./lib/newlib/newlib/libc/machine/hppa/configure.in","./lib/newlib/newlib/libc/machine/hppa/strncat.S","./lib/newlib/newlib/libc/machine/hppa/strncpy.S","./lib/newlib/newlib/libc/machine/hppa/Makefile.am","./lib/newlib/newlib/libc/machine/hppa/strcpy.S","./lib/newlib/newlib/libc/machine/hppa/memcmp.S","./lib/newlib/newlib/libc/machine/hppa/strncmp.S","./lib/newlib/newlib/libc/machine/lm32/setjmp.S","./lib/newlib/newlib/libc/machine/lm32/Makefile.in","./lib/newlib/newlib/libc/machine/lm32/aclocal.m4","./lib/newlib/newlib/libc/machine/lm32/configure","./lib/newlib/newlib/libc/machine/lm32/configure.in","./lib/newlib/newlib/libc/machine/lm32/Makefile.am","./lib/newlib/newlib/libc/machine/m32c/setjmp.S","./lib/newlib/newlib/libc/machine/m32c/Makefile.in","./lib/newlib/newlib/libc/machine/m32c/aclocal.m4","./lib/newlib/newlib/libc/machine/m32c/configure","./lib/newlib/newlib/libc/machine/m32c/configure.in","./lib/newlib/newlib/libc/machine/m32c/Makefile.am","./lib/newlib/newlib/libc/machine/arm/setjmp.S","./lib/newlib/newlib/libc/machine/arm/Makefile.in","./lib/newlib/newlib/libc/machine/arm/arm_asm.h","./lib/newlib/newlib/libc/machine/arm/aclocal.m4","./lib/newlib/newlib/libc/machine/arm/strlen.c","./lib/newlib/newlib/libc/machine/arm/configure","./lib/newlib/newlib/libc/machine/arm/access.c","./lib/newlib/newlib/libc/machine/arm/configure.in","./lib/newlib/newlib/libc/machine/arm/strcpy.c","./lib/newlib/newlib/libc/machine/arm/Makefile.am","./lib/newlib/newlib/libc/machine/arm/strcmp.c","./lib/newlib/newlib/libc/machine/arm/machine/param.h","./lib/newlib/newlib/libc/machine/v850/setjmp.S","./lib/newlib/newlib/libc/machine/v850/Makefile.in","./lib/newlib/newlib/libc/machine/v850/aclocal.m4","./lib/newlib/newlib/libc/machine/v850/configure","./lib/newlib/newlib/libc/machine/v850/configure.in","./lib/newlib/newlib/libc/machine/v850/Makefile.am","./lib/newlib/newlib/libc/machine/z8k/memcpy.S","./lib/newlib/newlib/libc/machine/z8k/memset.S","./lib/newlib/newlib/libc/machine/z8k/setjmp.S","./lib/newlib/newlib/libc/machine/z8k/args.h","./lib/newlib/newlib/libc/machine/z8k/Makefile.in","./lib/newlib/newlib/libc/machine/z8k/aclocal.m4","./lib/newlib/newlib/libc/machine/z8k/configure","./lib/newlib/newlib/libc/machine/z8k/configure.in","./lib/newlib/newlib/libc/machine/z8k/memmove.S","./lib/newlib/newlib/libc/machine/z8k/Makefile.am","./lib/newlib/newlib/libc/machine/z8k/memcmp.S","./lib/newlib/newlib/libc/machine/i386/i386mach.h","./lib/newlib/newlib/libc/machine/i386/memcpy.S","./lib/newlib/newlib/libc/machine/i386/f_logf.S","./lib/newlib/newlib/libc/machine/i386/f_log.S","./lib/newlib/newlib/libc/machine/i386/strchr.S","./lib/newlib/newlib/libc/machine/i386/memset.S","./lib/newlib/newlib/libc/machine/i386/f_frexpf.S","./lib/newlib/newlib/libc/machine/i386/setjmp.S","./lib/newlib/newlib/libc/machine/i386/f_exp.c","./lib/newlib/newlib/libc/machine/i386/Makefile.in","./lib/newlib/newlib/libc/machine/i386/strlen.S","./lib/newlib/newlib/libc/machine/i386/f_atan2.S","./lib/newlib/newlib/libc/machine/i386/aclocal.m4","./lib/newlib/newlib/libc/machine/i386/memchr.S","./lib/newlib/newlib/libc/machine/i386/f_tanf.S","./lib/newlib/newlib/libc/machine/i386/f_math.h","./lib/newlib/newlib/libc/machine/i386/f_pow.c","./lib/newlib/newlib/libc/machine/i386/configure.in","./lib/newlib/newlib/libc/machine/i386/f_atan2f.S","./lib/newlib/newlib/libc/machine/i386/f_ldexp.S","./lib/newlib/newlib/libc/machine/i386/memmove.S","./lib/newlib/newlib/libc/machine/i386/f_frexp.S","./lib/newlib/newlib/libc/machine/i386/f_log10.S","./lib/newlib/newlib/libc/machine/i386/f_ldexpf.S","./lib/newlib/newlib/libc/machine/i386/f_tan.S","./lib/newlib/newlib/libc/machine/i386/Makefile.am","./lib/newlib/newlib/libc/machine/i386/f_powf.c","./lib/newlib/newlib/libc/machine/i386/memcmp.S","./lib/newlib/newlib/libc/machine/i386/f_log10f.S","./lib/newlib/newlib/libc/machine/i386/f_expf.c","./lib/newlib/newlib/libc/machine/i386/machine/fastmath.h","./lib/newlib/newlib/libc/machine/moxie/setjmp.S","./lib/newlib/newlib/libc/machine/moxie/Makefile.in","./lib/newlib/newlib/libc/machine/moxie/aclocal.m4","./lib/newlib/newlib/libc/machine/moxie/configure","./lib/newlib/newlib/libc/machine/moxie/configure.in","./lib/newlib/newlib/libc/machine/moxie/Makefile.am","./lib/newlib/newlib/libc/machine/m68k/memcpy.S","./lib/newlib/newlib/libc/machine/m68k/memset.S","./lib/newlib/newlib/libc/machine/m68k/setjmp.S","./lib/newlib/newlib/libc/machine/m68k/Makefile.in","./lib/newlib/newlib/libc/machine/m68k/aclocal.m4","./lib/newlib/newlib/libc/machine/m68k/m68kasm.h","./lib/newlib/newlib/libc/machine/m68k/strlen.c","./lib/newlib/newlib/libc/machine/m68k/configure","./lib/newlib/newlib/libc/machine/m68k/configure.in","./lib/newlib/newlib/libc/machine/m68k/strcpy.c","./lib/newlib/newlib/libc/machine/m68k/Makefile.am","./lib/newlib/newlib/libc/machine/x86_64/memcpy.S","./lib/newlib/newlib/libc/machine/x86_64/x86_64mach.h","./lib/newlib/newlib/libc/machine/x86_64/memset.S","./lib/newlib/newlib/libc/machine/x86_64/setjmp.S","./lib/newlib/newlib/libc/machine/x86_64/Makefile.in","./lib/newlib/newlib/libc/machine/x86_64/aclocal.m4","./lib/newlib/newlib/libc/machine/x86_64/configure","./lib/newlib/newlib/libc/machine/x86_64/configure.in","./lib/newlib/newlib/libc/machine/x86_64/Makefile.am","./lib/newlib/newlib/libc/machine/mips/setjmp.S","./lib/newlib/newlib/libc/machine/mips/memcpy.c","./lib/newlib/newlib/libc/machine/mips/Makefile.in","./lib/newlib/newlib/libc/machine/mips/strncpy.c","./lib/newlib/newlib/libc/machine/mips/aclocal.m4","./lib/newlib/newlib/libc/machine/mips/strlen.c","./lib/newlib/newlib/libc/machine/mips/configure","./lib/newlib/newlib/libc/machine/mips/memset.c","./lib/newlib/newlib/libc/machine/mips/configure.in","./lib/newlib/newlib/libc/machine/mips/Makefile.am","./lib/newlib/newlib/libc/machine/mips/strcmp.c","./lib/newlib/newlib/libc/machine/mips/machine/regdef.h","./lib/newlib/newlib/libc/machine/m32r/setjmp.S","./lib/newlib/newlib/libc/machine/m32r/Makefile.in","./lib/newlib/newlib/libc/machine/m32r/aclocal.m4","./lib/newlib/newlib/libc/machine/m32r/configure","./lib/newlib/newlib/libc/machine/m32r/configure.in","./lib/newlib/newlib/libc/machine/m32r/Makefile.am","./lib/newlib/newlib/libc/machine/tic4x/setjmp.S","./lib/newlib/newlib/libc/machine/tic4x/Makefile.in","./lib/newlib/newlib/libc/machine/tic4x/aclocal.m4","./lib/newlib/newlib/libc/machine/tic4x/configure","./lib/newlib/newlib/libc/machine/tic4x/configure.in","./lib/newlib/newlib/libc/machine/tic4x/Makefile.am","./lib/newlib/newlib/libc/machine/necv70/necv70.tex","./lib/newlib/newlib/libc/machine/necv70/setjmp.S","./lib/newlib/newlib/libc/machine/necv70/Makefile.in","./lib/newlib/newlib/libc/machine/necv70/aclocal.m4","./lib/newlib/newlib/libc/machine/necv70/configure","./lib/newlib/newlib/libc/machine/necv70/configure.in","./lib/newlib/newlib/libc/machine/necv70/fastmath.S","./lib/newlib/newlib/libc/machine/necv70/Makefile.am","./lib/newlib/newlib/libc/machine/necv70/machine/registers.h","./lib/newlib/newlib/libc/machine/fr30/setjmp.S","./lib/newlib/newlib/libc/machine/fr30/Makefile.in","./lib/newlib/newlib/libc/machine/fr30/aclocal.m4","./lib/newlib/newlib/libc/machine/fr30/configure","./lib/newlib/newlib/libc/machine/fr30/configure.in","./lib/newlib/newlib/libc/machine/fr30/Makefile.am","./lib/newlib/newlib/libc/machine/rx/strcmp.S","./lib/newlib/newlib/libc/machine/rx/memcpy.S","./lib/newlib/newlib/libc/machine/rx/mempcpy.S","./lib/newlib/newlib/libc/machine/rx/strcat.S","./lib/newlib/newlib/libc/machine/rx/memset.S","./lib/newlib/newlib/libc/machine/rx/setjmp.S","./lib/newlib/newlib/libc/machine/rx/Makefile.in","./lib/newlib/newlib/libc/machine/rx/strlen.S","./lib/newlib/newlib/libc/machine/rx/aclocal.m4","./lib/newlib/newlib/libc/machine/rx/memchr.S","./lib/newlib/newlib/libc/machine/rx/configure","./lib/newlib/newlib/libc/machine/rx/configure.in","./lib/newlib/newlib/libc/machine/rx/strncat.S","./lib/newlib/newlib/libc/machine/rx/memmove.S","./lib/newlib/newlib/libc/machine/rx/strncpy.S","./lib/newlib/newlib/libc/machine/rx/Makefile.am","./lib/newlib/newlib/libc/machine/rx/strcpy.S","./lib/newlib/newlib/libc/machine/rx/strncmp.S","./lib/newlib/newlib/libc/machine/iq2000/setjmp.S","./lib/newlib/newlib/libc/machine/iq2000/Makefile.in","./lib/newlib/newlib/libc/machine/iq2000/aclocal.m4","./lib/newlib/newlib/libc/machine/iq2000/configure","./lib/newlib/newlib/libc/machine/iq2000/configure.in","./lib/newlib/newlib/libc/machine/iq2000/Makefile.am","./lib/newlib/newlib/libc/machine/i960/strcmp.S","./lib/newlib/newlib/libc/machine/i960/memcpy.S","./lib/newlib/newlib/libc/machine/i960/strchr.S","./lib/newlib/newlib/libc/machine/i960/memset.S","./lib/newlib/newlib/libc/machine/i960/setjmp.S","./lib/newlib/newlib/libc/machine/i960/Makefile.in","./lib/newlib/newlib/libc/machine/i960/memcpy_ca.S","./lib/newlib/newlib/libc/machine/i960/memchr_ca.S","./lib/newlib/newlib/libc/machine/i960/strncpy_ca.S","./lib/newlib/newlib/libc/machine/i960/strlen.S","./lib/newlib/newlib/libc/machine/i960/strrchr.S","./lib/newlib/newlib/libc/machine/i960/memccpy_ca.S","./lib/newlib/newlib/libc/machine/i960/strlen_ca.S","./lib/newlib/newlib/libc/machine/i960/aclocal.m4","./lib/newlib/newlib/libc/machine/i960/memchr.S","./lib/newlib/newlib/libc/machine/i960/strchr_ca.S","./lib/newlib/newlib/libc/machine/i960/strncmp_ca.S","./lib/newlib/newlib/libc/machine/i960/strncat_ca.S","./lib/newlib/newlib/libc/machine/i960/configure","./lib/newlib/newlib/libc/machine/i960/strcpy_ca.S","./lib/newlib/newlib/libc/machine/i960/configure.in","./lib/newlib/newlib/libc/machine/i960/strncat.S","./lib/newlib/newlib/libc/machine/i960/strcmp_ca.S","./lib/newlib/newlib/libc/machine/i960/strcspn.S","./lib/newlib/newlib/libc/machine/i960/memccpy.S","./lib/newlib/newlib/libc/machine/i960/memcmp_ca.S","./lib/newlib/newlib/libc/machine/i960/strncpy.S","./lib/newlib/newlib/libc/machine/i960/Makefile.am","./lib/newlib/newlib/libc/machine/i960/strcpy.S","./lib/newlib/newlib/libc/machine/i960/strpbrk.S","./lib/newlib/newlib/libc/machine/i960/memcmp.S","./lib/newlib/newlib/libc/machine/i960/strdup.S","./lib/newlib/newlib/libc/machine/i960/strncmp.S","./lib/newlib/newlib/libc/machine/bfin/longjmp.S","./lib/newlib/newlib/libc/machine/bfin/setjmp.S","./lib/newlib/newlib/libc/machine/bfin/Makefile.in","./lib/newlib/newlib/libc/machine/bfin/aclocal.m4","./lib/newlib/newlib/libc/machine/bfin/configure","./lib/newlib/newlib/libc/machine/bfin/configure.in","./lib/newlib/newlib/libc/machine/bfin/Makefile.am","./lib/newlib/newlib/libc/machine/tic6x/setjmp.S","./lib/newlib/newlib/libc/machine/tic6x/Makefile.in","./lib/newlib/newlib/libc/machine/tic6x/aclocal.m4","./lib/newlib/newlib/libc/machine/tic6x/configure","./lib/newlib/newlib/libc/machine/tic6x/configure.in","./lib/newlib/newlib/libc/machine/tic6x/Makefile.am","./lib/newlib/newlib/libc/machine/spu/vsiscanf.c","./lib/newlib/newlib/libc/machine/spu/ferror.c","./lib/newlib/newlib/libc/machine/spu/fsetpos.c","./lib/newlib/newlib/libc/machine/spu/spu-mcount.S","./lib/newlib/newlib/libc/machine/spu/vscanf.c","./lib/newlib/newlib/libc/machine/spu/assert.c","./lib/newlib/newlib/libc/machine/spu/pwrite_ea.c","./lib/newlib/newlib/libc/machine/spu/ungetc.c","./lib/newlib/newlib/libc/machine/spu/fiscanf.S","./lib/newlib/newlib/libc/machine/spu/strstr_ea.c","./lib/newlib/newlib/libc/machine/spu/getchar.c","./lib/newlib/newlib/libc/machine/spu/memmove.c","./lib/newlib/newlib/libc/machine/spu/fread.c","./lib/newlib/newlib/libc/machine/spu/tmpfile.c","./lib/newlib/newlib/libc/machine/spu/fputs.c","./lib/newlib/newlib/libc/machine/spu/strncpy_ea.c","./lib/newlib/newlib/libc/machine/spu/spu_timer_slih.c","./lib/newlib/newlib/libc/machine/spu/munmap_ea.c","./lib/newlib/newlib/libc/machine/spu/mk_syscalls","./lib/newlib/newlib/libc/machine/spu/strchr.c","./lib/newlib/newlib/libc/machine/spu/stack_reg_va.S","./lib/newlib/newlib/libc/machine/spu/memcpy_ea.c","./lib/newlib/newlib/libc/machine/spu/remove.c","./lib/newlib/newlib/libc/machine/spu/scanf.S","./lib/newlib/newlib/libc/machine/spu/sscanf.S","./lib/newlib/newlib/libc/machine/spu/spu_timer_free.c","./lib/newlib/newlib/libc/machine/spu/tmpnam.c","./lib/newlib/newlib/libc/machine/spu/realloc_ea.c","./lib/newlib/newlib/libc/machine/spu/memcmp_ea.c","./lib/newlib/newlib/libc/machine/spu/rename.c","./lib/newlib/newlib/libc/machine/spu/gets.c","./lib/newlib/newlib/libc/machine/spu/read_ea.c","./lib/newlib/newlib/libc/machine/spu/fprintf.S","./lib/newlib/newlib/libc/machine/spu/setjmp.S","./lib/newlib/newlib/libc/machine/spu/memcmp.c","./lib/newlib/newlib/libc/machine/spu/fclose.c","./lib/newlib/newlib/libc/machine/spu/vsiprintf.c","./lib/newlib/newlib/libc/machine/spu/pread_ea.c","./lib/newlib/newlib/libc/machine/spu/memcpy.c","./lib/newlib/newlib/libc/machine/spu/strrchr.c","./lib/newlib/newlib/libc/machine/spu/write_ea.c","./lib/newlib/newlib/libc/machine/spu/viprintf.c","./lib/newlib/newlib/libc/machine/spu/strcspn.c","./lib/newlib/newlib/libc/machine/spu/spu_timer_flih.S","./lib/newlib/newlib/libc/machine/spu/Makefile.in","./lib/newlib/newlib/libc/machine/spu/strncpy.c","./lib/newlib/newlib/libc/machine/spu/sleep.c","./lib/newlib/newlib/libc/machine/spu/fiprintf.S","./lib/newlib/newlib/libc/machine/spu/fscanf.S","./lib/newlib/newlib/libc/machine/spu/perror.c","./lib/newlib/newlib/libc/machine/spu/mmap_ea.c","./lib/newlib/newlib/libc/machine/spu/spu-gmon.c","./lib/newlib/newlib/libc/machine/spu/fgetc.c","./lib/newlib/newlib/libc/machine/spu/printf.S","./lib/newlib/newlib/libc/machine/spu/strncmp.h","./lib/newlib/newlib/libc/machine/spu/spu_clock_svcs.c","./lib/newlib/newlib/libc/machine/spu/puts.c","./lib/newlib/newlib/libc/machine/spu/writev_ea.c","./lib/newlib/newlib/libc/machine/spu/vfiprintf.c","./lib/newlib/newlib/libc/machine/spu/spu_timer_stop.c","./lib/newlib/newlib/libc/machine/spu/strchr_ea.c","./lib/newlib/newlib/libc/machine/spu/setvbuf.c","./lib/newlib/newlib/libc/machine/spu/strcmp_ea.c","./lib/newlib/newlib/libc/machine/spu/aclocal.m4","./lib/newlib/newlib/libc/machine/spu/strcat.c","./lib/newlib/newlib/libc/machine/spu/stdio.c","./lib/newlib/newlib/libc/machine/spu/strpbrk_ea.c","./lib/newlib/newlib/libc/machine/spu/spu_clock_stop.c","./lib/newlib/newlib/libc/machine/spu/strrchr_ea.c","./lib/newlib/newlib/libc/machine/spu/siprintf.S","./lib/newlib/newlib/libc/machine/spu/iprintf.S","./lib/newlib/newlib/libc/machine/spu/viscanf.c","./lib/newlib/newlib/libc/machine/spu/vsniprintf.c","./lib/newlib/newlib/libc/machine/spu/straddr.h","./lib/newlib/newlib/libc/machine/spu/fputc.c","./lib/newlib/newlib/libc/machine/spu/ftell.c","./lib/newlib/newlib/libc/machine/spu/strlen_ea.c","./lib/newlib/newlib/libc/machine/spu/strncmp.c","./lib/newlib/newlib/libc/machine/spu/strlen.c","./lib/newlib/newlib/libc/machine/spu/impure.c","./lib/newlib/newlib/libc/machine/spu/vfprintf.c","./lib/newlib/newlib/libc/machine/spu/spu_timebase.c","./lib/newlib/newlib/libc/machine/spu/vfscanf.c","./lib/newlib/newlib/libc/machine/spu/configure","./lib/newlib/newlib/libc/machine/spu/usleep.c","./lib/newlib/newlib/libc/machine/spu/fflush.c","./lib/newlib/newlib/libc/machine/spu/memmove_ea.c","./lib/newlib/newlib/libc/machine/spu/strcat_ea.c","./lib/newlib/newlib/libc/machine/spu/vsprintf.c","./lib/newlib/newlib/libc/machine/spu/calloc_ea.c","./lib/newlib/newlib/libc/machine/spu/free_ea.c","./lib/newlib/newlib/libc/machine/spu/memchr_ea.c","./lib/newlib/newlib/libc/machine/spu/c99ppe.h","./lib/newlib/newlib/libc/machine/spu/memset.c","./lib/newlib/newlib/libc/machine/spu/strncmp_ea.c","./lib/newlib/newlib/libc/machine/spu/configure.in","./lib/newlib/newlib/libc/machine/spu/rewind.c","./lib/newlib/newlib/libc/machine/spu/strcpy_ea.c","./lib/newlib/newlib/libc/machine/spu/vec_literal.h","./lib/newlib/newlib/libc/machine/spu/syscall.def","./lib/newlib/newlib/libc/machine/spu/snprintf.S","./lib/newlib/newlib/libc/machine/spu/fseek.c","./lib/newlib/newlib/libc/machine/spu/vfiscanf.c","./lib/newlib/newlib/libc/machine/spu/strcpy.h","./lib/newlib/newlib/libc/machine/spu/sniprintf.S","./lib/newlib/newlib/libc/machine/spu/getc.c","./lib/newlib/newlib/libc/machine/spu/posix_memalign_ea.c","./lib/newlib/newlib/libc/machine/spu/strcpy.c","./lib/newlib/newlib/libc/machine/spu/mremap_ea.c","./lib/newlib/newlib/libc/machine/spu/malloc_ea.c","./lib/newlib/newlib/libc/machine/spu/putc.c","./lib/newlib/newlib/libc/machine/spu/strncat.c","./lib/newlib/newlib/libc/machine/spu/strspn.c","./lib/newlib/newlib/libc/machine/spu/iscanf.S","./lib/newlib/newlib/libc/machine/spu/ea_internal.h","./lib/newlib/newlib/libc/machine/spu/strpbrk.c","./lib/newlib/newlib/libc/machine/spu/fgetpos.c","./lib/newlib/newlib/libc/machine/spu/fdopen.c","./lib/newlib/newlib/libc/machine/spu/strspn_ea.c","./lib/newlib/newlib/libc/machine/spu/fgets.c","./lib/newlib/newlib/libc/machine/spu/strncat_ea.c","./lib/newlib/newlib/libc/machine/spu/siscanf.S","./lib/newlib/newlib/libc/machine/spu/vsscanf.c","./lib/newlib/newlib/libc/machine/spu/freopen.c","./lib/newlib/newlib/libc/machine/spu/spu_timer_svcs.c","./lib/newlib/newlib/libc/machine/spu/msync_ea.c","./lib/newlib/newlib/libc/machine/spu/clearerr.c","./lib/newlib/newlib/libc/machine/spu/Makefile.am","./lib/newlib/newlib/libc/machine/spu/spu_timer_slih_reg.c","./lib/newlib/newlib/libc/machine/spu/spu_timer_internal.h","./lib/newlib/newlib/libc/machine/spu/vprintf.c","./lib/newlib/newlib/libc/machine/spu/strcmp.c","./lib/newlib/newlib/libc/machine/spu/strxfrm.c","./lib/newlib/newlib/libc/machine/spu/feof.c","./lib/newlib/newlib/libc/machine/spu/putchar.c","./lib/newlib/newlib/libc/machine/spu/creat.c","./lib/newlib/newlib/libc/machine/spu/strcspn_ea.c","./lib/newlib/newlib/libc/machine/spu/memset_ea.c","./lib/newlib/newlib/libc/machine/spu/fileno.c","./lib/newlib/newlib/libc/machine/spu/sprintf.S","./lib/newlib/newlib/libc/machine/spu/setbuf.c","./lib/newlib/newlib/libc/machine/spu/fopen.c","./lib/newlib/newlib/libc/machine/spu/readv_ea.c","./lib/newlib/newlib/libc/machine/spu/vsnprintf.c","./lib/newlib/newlib/libc/machine/spu/fwrite.c","./lib/newlib/newlib/libc/machine/spu/machine/_types.h","./lib/newlib/newlib/libc/machine/spu/include/spu_timer.h","./lib/newlib/newlib/libc/machine/spu/include/fenv.h","./lib/newlib/newlib/libc/machine/spu/include/ea.h","./lib/newlib/newlib/libc/machine/spu/sys/linux_syscalls.h","./lib/newlib/newlib/libc/machine/spu/sys/dirent.h","./lib/newlib/newlib/libc/machine/spu/sys/sched.h","./lib/newlib/newlib/libc/machine/spu/sys/errno.h","./lib/newlib/newlib/libc/machine/spu/sys/utime.h","./lib/newlib/newlib/libc/machine/spu/sys/syscall.h","./lib/newlib/newlib/libc/machine/spu/sys/uio.h","./lib/newlib/newlib/libc/machine/spu/sys/mman.h","./lib/newlib/newlib/libc/machine/spu/sys/fenv.h","./lib/newlib/newlib/libc/machine/spu/sys/custom_file.h","./lib/newlib/newlib/libc/machine/frv/setjmp.S","./lib/newlib/newlib/libc/machine/frv/Makefile.in","./lib/newlib/newlib/libc/machine/frv/aclocal.m4","./lib/newlib/newlib/libc/machine/frv/configure","./lib/newlib/newlib/libc/machine/frv/configure.in","./lib/newlib/newlib/libc/machine/frv/Makefile.am","./lib/newlib/newlib/libc/machine/sh/strcmp.S","./lib/newlib/newlib/libc/machine/sh/memcpy.S","./lib/newlib/newlib/libc/machine/sh/memset.S","./lib/newlib/newlib/libc/machine/sh/setjmp.S","./lib/newlib/newlib/libc/machine/sh/Makefile.in","./lib/newlib/newlib/libc/machine/sh/strlen.S","./lib/newlib/newlib/libc/machine/sh/aclocal.m4","./lib/newlib/newlib/libc/machine/sh/configure","./lib/newlib/newlib/libc/machine/sh/configure.in","./lib/newlib/newlib/libc/machine/sh/strncpy.S","./lib/newlib/newlib/libc/machine/sh/Makefile.am","./lib/newlib/newlib/libc/machine/sh/strcpy.S","./lib/newlib/newlib/libc/machine/sh/asm.h","./lib/newlib/newlib/libc/machine/mep/setjmp.S","./lib/newlib/newlib/libc/machine/mep/Makefile.in","./lib/newlib/newlib/libc/machine/mep/aclocal.m4","./lib/newlib/newlib/libc/machine/mep/configure","./lib/newlib/newlib/libc/machine/mep/configure.in","./lib/newlib/newlib/libc/machine/mep/Makefile.am","./lib/newlib/newlib/libc/machine/d10v/setjmp.S","./lib/newlib/newlib/libc/machine/d10v/Makefile.in","./lib/newlib/newlib/libc/machine/d10v/aclocal.m4","./lib/newlib/newlib/libc/machine/d10v/configure","./lib/newlib/newlib/libc/machine/d10v/configure.in","./lib/newlib/newlib/libc/machine/d10v/Makefile.am","./lib/newlib/newlib/libc/locale/lmessages.c","./lib/newlib/newlib/libc/locale/lmonetary.c","./lib/newlib/newlib/libc/locale/lmessages.h","./lib/newlib/newlib/libc/locale/fix_grouping.c","./lib/newlib/newlib/libc/locale/timelocal.c","./lib/newlib/newlib/libc/locale/setlocale.h","./lib/newlib/newlib/libc/locale/timelocal.h","./lib/newlib/newlib/libc/locale/Makefile.in","./lib/newlib/newlib/libc/locale/Hakefile","./lib/newlib/newlib/libc/locale/nl_langinfo.3","./lib/newlib/newlib/libc/locale/nl_langinfo.c","./lib/newlib/newlib/libc/locale/locale.c","./lib/newlib/newlib/libc/locale/lctype.c","./lib/newlib/newlib/libc/locale/lnumeric.h","./lib/newlib/newlib/libc/locale/ldpart.h","./lib/newlib/newlib/libc/locale/lmonetary.h","./lib/newlib/newlib/libc/locale/ldpart.c","./lib/newlib/newlib/libc/locale/locale.tex","./lib/newlib/newlib/libc/locale/lnumeric.c","./lib/newlib/newlib/libc/locale/Makefile.am","./lib/newlib/newlib/libc/locale/lctype.h","./lib/newlib/newlib/libc/unix/basename.c","./lib/newlib/newlib/libc/unix/ttyname_r.c","./lib/newlib/newlib/libc/unix/pread.c","./lib/newlib/newlib/libc/unix/getpwent.c","./lib/newlib/newlib/libc/unix/dirname.c","./lib/newlib/newlib/libc/unix/getlogin.c","./lib/newlib/newlib/libc/unix/ttyname.h","./lib/newlib/newlib/libc/unix/Makefile.in","./lib/newlib/newlib/libc/unix/ttyname.c","./lib/newlib/newlib/libc/unix/getut.c","./lib/newlib/newlib/libc/unix/sigset.c","./lib/newlib/newlib/libc/unix/getcwd.c","./lib/newlib/newlib/libc/unix/getpass.c","./lib/newlib/newlib/libc/unix/Makefile.am","./lib/newlib/newlib/libc/unix/pwrite.c","./lib/newlib/newlib/libc/stdio/vsiscanf.c","./lib/newlib/newlib/libc/stdio/ferror.c","./lib/newlib/newlib/libc/stdio/fsetpos.c","./lib/newlib/newlib/libc/stdio/setlinebuf.c","./lib/newlib/newlib/libc/stdio/vscanf.c","./lib/newlib/newlib/libc/stdio/findfp.c","./lib/newlib/newlib/libc/stdio/wprintf.c","./lib/newlib/newlib/libc/stdio/ungetc.c","./lib/newlib/newlib/libc/stdio/wsetup.c","./lib/newlib/newlib/libc/stdio/getchar.c","./lib/newlib/newlib/libc/stdio/makebuf.c","./lib/newlib/newlib/libc/stdio/fread.c","./lib/newlib/newlib/libc/stdio/tmpfile.c","./lib/newlib/newlib/libc/stdio/putwc.c","./lib/newlib/newlib/libc/stdio/fputs.c","./lib/newlib/newlib/libc/stdio/vasiprintf.c","./lib/newlib/newlib/libc/stdio/local.h","./lib/newlib/newlib/libc/stdio/svfscanf.c","./lib/newlib/newlib/libc/stdio/asnprintf.c","./lib/newlib/newlib/libc/stdio/remove.c","./lib/newlib/newlib/libc/stdio/svfwscanf.c","./lib/newlib/newlib/libc/stdio/tmpnam.c","./lib/newlib/newlib/libc/stdio/asprintf.c","./lib/newlib/newlib/libc/stdio/putwchar.c","./lib/newlib/newlib/libc/stdio/floatio.h","./lib/newlib/newlib/libc/stdio/rename.c","./lib/newlib/newlib/libc/stdio/gets.c","./lib/newlib/newlib/libc/stdio/getwchar.c","./lib/newlib/newlib/libc/stdio/fgetws.c","./lib/newlib/newlib/libc/stdio/wbuf.c","./lib/newlib/newlib/libc/stdio/svfiscanf.c","./lib/newlib/newlib/libc/stdio/fclose.c","./lib/newlib/newlib/libc/stdio/vsiprintf.c","./lib/newlib/newlib/libc/stdio/vwprintf.c","./lib/newlib/newlib/libc/stdio/fwalk.c","./lib/newlib/newlib/libc/stdio/dprintf.c","./lib/newlib/newlib/libc/stdio/viprintf.c","./lib/newlib/newlib/libc/stdio/Makefile.in","./lib/newlib/newlib/libc/stdio/getline.c","./lib/newlib/newlib/libc/stdio/fgetwc.c","./lib/newlib/newlib/libc/stdio/Hakefile","./lib/newlib/newlib/libc/stdio/vasniprintf.c","./lib/newlib/newlib/libc/stdio/mktemp.c","./lib/newlib/newlib/libc/stdio/snprintf.c","./lib/newlib/newlib/libc/stdio/perror.c","./lib/newlib/newlib/libc/stdio/vdprintf.c","./lib/newlib/newlib/libc/stdio/svfiprintf.c","./lib/newlib/newlib/libc/stdio/ungetwc.c","./lib/newlib/newlib/libc/stdio/sccl.c","./lib/newlib/newlib/libc/stdio/vdiprintf.c","./lib/newlib/newlib/libc/stdio/iscanf.c","./lib/newlib/newlib/libc/stdio/sprintf.c","./lib/newlib/newlib/libc/stdio/fgetc.c","./lib/newlib/newlib/libc/stdio/fopencookie.c","./lib/newlib/newlib/libc/stdio/svfwprintf.c","./lib/newlib/newlib/libc/stdio/stdio.tex","./lib/newlib/newlib/libc/stdio/puts.c","./lib/newlib/newlib/libc/stdio/fwide.c","./lib/newlib/newlib/libc/stdio/vfiprintf.c","./lib/newlib/newlib/libc/stdio/asniprintf.c","./lib/newlib/newlib/libc/stdio/vfwprintf.c","./lib/newlib/newlib/libc/stdio/svfiwprintf.c","./lib/newlib/newlib/libc/stdio/setvbuf.c","./lib/newlib/newlib/libc/stdio/putchar_u.c","./lib/newlib/newlib/libc/stdio/stdio.c","./lib/newlib/newlib/libc/stdio/open_memstream.c","./lib/newlib/newlib/libc/stdio/swscanf.c","./lib/newlib/newlib/libc/stdio/viscanf.c","./lib/newlib/newlib/libc/stdio/vswprintf.c","./lib/newlib/newlib/libc/stdio/vsniprintf.c","./lib/newlib/newlib/libc/stdio/vasnprintf.c","./lib/newlib/newlib/libc/stdio/asiprintf.c","./lib/newlib/newlib/libc/stdio/fputc.c","./lib/newlib/newlib/libc/stdio/funopen.c","./lib/newlib/newlib/libc/stdio/diprintf.c","./lib/newlib/newlib/libc/stdio/ftell.c","./lib/newlib/newlib/libc/stdio/vfprintf.c","./lib/newlib/newlib/libc/stdio/fprintf.c","./lib/newlib/newlib/libc/stdio/getc_u.c","./lib/newlib/newlib/libc/stdio/scanf.c","./lib/newlib/newlib/libc/stdio/vfscanf.c","./lib/newlib/newlib/libc/stdio/putw.c","./lib/newlib/newlib/libc/stdio/svfprintf.c","./lib/newlib/newlib/libc/stdio/fflush.c","./lib/newlib/newlib/libc/stdio/vsprintf.c","./lib/newlib/newlib/libc/stdio/fcloseall.c","./lib/newlib/newlib/libc/stdio/fvwrite.c","./lib/newlib/newlib/libc/stdio/fputws.c","./lib/newlib/newlib/libc/stdio/fvwrite.h","./lib/newlib/newlib/libc/stdio/vfiwprintf.c","./lib/newlib/newlib/libc/stdio/fscanf.c","./lib/newlib/newlib/libc/stdio/rewind.c","./lib/newlib/newlib/libc/stdio/fwscanf.c","./lib/newlib/newlib/libc/stdio/vfwscanf.c","./lib/newlib/newlib/libc/stdio/fwprintf.c","./lib/newlib/newlib/libc/stdio/siscanf.c","./lib/newlib/newlib/libc/stdio/fputwc.c","./lib/newlib/newlib/libc/stdio/fseek.c","./lib/newlib/newlib/libc/stdio/vfiscanf.c","./lib/newlib/newlib/libc/stdio/getc.c","./lib/newlib/newlib/libc/stdio/getchar_u.c","./lib/newlib/newlib/libc/stdio/swprintf.c","./lib/newlib/newlib/libc/stdio/vfieeefp.h","./lib/newlib/newlib/libc/stdio/sscanf.c","./lib/newlib/newlib/libc/stdio/wscanf.c","./lib/newlib/newlib/libc/stdio/fiscanf.c","./lib/newlib/newlib/libc/stdio/putc.c","./lib/newlib/newlib/libc/stdio/rget.c","./lib/newlib/newlib/libc/stdio/siprintf.c","./lib/newlib/newlib/libc/stdio/fgetpos.c","./lib/newlib/newlib/libc/stdio/ftello.c","./lib/newlib/newlib/libc/stdio/fdopen.c","./lib/newlib/newlib/libc/stdio/fgets.c","./lib/newlib/newlib/libc/stdio/sniprintf.c","./lib/newlib/newlib/libc/stdio/vsscanf.c","./lib/newlib/newlib/libc/stdio/setbuffer.c","./lib/newlib/newlib/libc/stdio/fpurge.c","./lib/newlib/newlib/libc/stdio/freopen.c","./lib/newlib/newlib/libc/stdio/getwc.c","./lib/newlib/newlib/libc/stdio/clearerr.c","./lib/newlib/newlib/libc/stdio/Makefile.am","./lib/newlib/newlib/libc/stdio/svfiwscanf.c","./lib/newlib/newlib/libc/stdio/fiprintf.c","./lib/newlib/newlib/libc/stdio/fseeko.c","./lib/newlib/newlib/libc/stdio/vprintf.c","./lib/newlib/newlib/libc/stdio/getdelim.c","./lib/newlib/newlib/libc/stdio/vswscanf.c","./lib/newlib/newlib/libc/stdio/feof.c","./lib/newlib/newlib/libc/stdio/iprintf.c","./lib/newlib/newlib/libc/stdio/putchar.c","./lib/newlib/newlib/libc/stdio/fmemopen.c","./lib/newlib/newlib/libc/stdio/getw.c","./lib/newlib/newlib/libc/stdio/vwscanf.c","./lib/newlib/newlib/libc/stdio/fileno.c","./lib/newlib/newlib/libc/stdio/setbuf.c","./lib/newlib/newlib/libc/stdio/vasprintf.c","./lib/newlib/newlib/libc/stdio/flags.c","./lib/newlib/newlib/libc/stdio/fopen.c","./lib/newlib/newlib/libc/stdio/refill.c","./lib/newlib/newlib/libc/stdio/vsnprintf.c","./lib/newlib/newlib/libc/stdio/putc_u.c","./lib/newlib/newlib/libc/stdio/printf.c","./lib/newlib/newlib/libc/stdio/vfiwscanf.c","./lib/newlib/newlib/libc/stdio/fwrite.c","./lib/newlib/newlib/libc/include/limits.h","./lib/newlib/newlib/libc/include/dirent.h","./lib/newlib/newlib/libc/include/math.h","./lib/newlib/newlib/libc/include/time.h","./lib/newlib/newlib/libc/include/pwd.h","./lib/newlib/newlib/libc/include/iconv.h","./lib/newlib/newlib/libc/include/search.h","./lib/newlib/newlib/libc/include/_ansi.h","./lib/newlib/newlib/libc/include/tar.h","./lib/newlib/newlib/libc/include/ctype.h","./lib/newlib/newlib/libc/include/malloc.h","./lib/newlib/newlib/libc/include/unctrl.h","./lib/newlib/newlib/libc/include/newlib.h","./lib/newlib/newlib/libc/include/stdlib.h","./lib/newlib/newlib/libc/include/sched.h","./lib/newlib/newlib/libc/include/reent.h","./lib/newlib/newlib/libc/include/fnmatch.h","./lib/newlib/newlib/libc/include/wordexp.h","./lib/newlib/newlib/libc/include/ar.h","./lib/newlib/newlib/libc/include/fcntl.h","./lib/newlib/newlib/libc/include/locale.h","./lib/newlib/newlib/libc/include/regex.h","./lib/newlib/newlib/libc/include/stdio.h","./lib/newlib/newlib/libc/include/argz.h","./lib/newlib/newlib/libc/include/errno.h","./lib/newlib/newlib/libc/include/fastmath.h","./lib/newlib/newlib/libc/include/unistd.h","./lib/newlib/newlib/libc/include/complex.h","./lib/newlib/newlib/libc/include/stdint.h","./lib/newlib/newlib/libc/include/wctype.h","./lib/newlib/newlib/libc/include/_syslist.h","./lib/newlib/newlib/libc/include/termios.h","./lib/newlib/newlib/libc/include/paths.h","./lib/newlib/newlib/libc/include/utime.h","./lib/newlib/newlib/libc/include/alloca.h","./lib/newlib/newlib/libc/include/getopt.h","./lib/newlib/newlib/libc/include/regdef.h","./lib/newlib/newlib/libc/include/envlock.h","./lib/newlib/newlib/libc/include/inttypes.h","./lib/newlib/newlib/libc/include/assert.h","./lib/newlib/newlib/libc/include/setjmp.h","./lib/newlib/newlib/libc/include/ieeefp.h","./lib/newlib/newlib/libc/include/glob.h","./lib/newlib/newlib/libc/include/string.h","./lib/newlib/newlib/libc/include/strings.h","./lib/newlib/newlib/libc/include/libgen.h","./lib/newlib/newlib/libc/include/envz.h","./lib/newlib/newlib/libc/include/pthread.h","./lib/newlib/newlib/libc/include/process.h","./lib/newlib/newlib/libc/include/grp.h","./lib/newlib/newlib/libc/include/utmp.h","./lib/newlib/newlib/libc/include/wchar.h","./lib/newlib/newlib/libc/include/signal__.h","./lib/newlib/newlib/libc/include/langinfo.h","./lib/newlib/newlib/libc/include/rpc/types.h","./lib/newlib/newlib/libc/include/rpc/xdr.h","./lib/newlib/newlib/libc/include/machine/time.h","./lib/newlib/newlib/libc/include/machine/malloc.h","./lib/newlib/newlib/libc/include/machine/param.h","./lib/newlib/newlib/libc/include/machine/stdlib.h","./lib/newlib/newlib/libc/include/machine/_types.h","./lib/newlib/newlib/libc/include/machine/types.h","./lib/newlib/newlib/libc/include/machine/setjmp-dj.h","./lib/newlib/newlib/libc/include/machine/fastmath.h","./lib/newlib/newlib/libc/include/machine/_default_types.h","./lib/newlib/newlib/libc/include/machine/termios.h","./lib/newlib/newlib/libc/include/machine/endian.h","./lib/newlib/newlib/libc/include/machine/setjmp.h","./lib/newlib/newlib/libc/include/machine/ieeefp.h","./lib/newlib/newlib/libc/include/machine/ansi.h","./lib/newlib/newlib/libc/include/sys/lock.h","./lib/newlib/newlib/libc/include/sys/dirent.h","./lib/newlib/newlib/libc/include/sys/features.h","./lib/newlib/newlib/libc/include/sys/cdefs.h","./lib/newlib/newlib/libc/include/sys/time.h","./lib/newlib/newlib/libc/include/sys/iconvnls.h","./lib/newlib/newlib/libc/include/sys/timeb.h","./lib/newlib/newlib/libc/include/sys/queue.h","./lib/newlib/newlib/libc/include/sys/_default_fcntl.h","./lib/newlib/newlib/libc/include/sys/param.h","./lib/newlib/newlib/libc/include/sys/sched.h","./lib/newlib/newlib/libc/include/sys/reent.h","./lib/newlib/newlib/libc/include/sys/fcntl.h","./lib/newlib/newlib/libc/include/sys/_types.h","./lib/newlib/newlib/libc/include/sys/types.h","./lib/newlib/newlib/libc/include/sys/stdio.h","./lib/newlib/newlib/libc/include/sys/errno.h","./lib/newlib/newlib/libc/include/sys/unistd.h","./lib/newlib/newlib/libc/include/sys/syslimits.h","./lib/newlib/newlib/libc/include/sys/dir.h","./lib/newlib/newlib/libc/include/sys/utime.h","./lib/newlib/newlib/libc/include/sys/stat.h","./lib/newlib/newlib/libc/include/sys/string.h","./lib/newlib/newlib/libc/include/sys/wait.h","./lib/newlib/newlib/libc/include/sys/file.h","./lib/newlib/newlib/libc/include/sys/config.h","./lib/newlib/newlib/libc/include/sys/custom_file.h","./lib/newlib/newlib/libc/include/sys/signal.h","./lib/newlib/newlib/libc/include/sys/times.h","./lib/newlib/newlib/libc/posix/telldir.c","./lib/newlib/newlib/libc/posix/readdir_r.c","./lib/newlib/newlib/libc/posix/posix.tex","./lib/newlib/newlib/libc/posix/cclass.h","./lib/newlib/newlib/libc/posix/un-namespace.h","./lib/newlib/newlib/libc/posix/rune.h","./lib/newlib/newlib/libc/posix/opendir.c","./lib/newlib/newlib/libc/posix/runetype.h","./lib/newlib/newlib/libc/posix/Makefile.in","./lib/newlib/newlib/libc/posix/sleep.c","./lib/newlib/newlib/libc/posix/wordexp.c","./lib/newlib/newlib/libc/posix/fnmatch.3","./lib/newlib/newlib/libc/posix/execle.c","./lib/newlib/newlib/libc/posix/seekdir.c","./lib/newlib/newlib/libc/posix/collcmp.c","./lib/newlib/newlib/libc/posix/execlp.c","./lib/newlib/newlib/libc/posix/isatty.c","./lib/newlib/newlib/libc/posix/regerror.c","./lib/newlib/newlib/libc/posix/regex2.h","./lib/newlib/newlib/libc/posix/execl.c","./lib/newlib/newlib/libc/posix/collate.h","./lib/newlib/newlib/libc/posix/sysexits.h","./lib/newlib/newlib/libc/posix/_isatty.c","./lib/newlib/newlib/libc/posix/usleep.c","./lib/newlib/newlib/libc/posix/regexec.c","./lib/newlib/newlib/libc/posix/collate.c","./lib/newlib/newlib/libc/posix/regcomp.c","./lib/newlib/newlib/libc/posix/namespace.h","./lib/newlib/newlib/libc/posix/glob.c","./lib/newlib/newlib/libc/posix/execv.c","./lib/newlib/newlib/libc/posix/scandir.c","./lib/newlib/newlib/libc/posix/execvp.c","./lib/newlib/newlib/libc/posix/regex.3","./lib/newlib/newlib/libc/posix/utils.h","./lib/newlib/newlib/libc/posix/glob.3","./lib/newlib/newlib/libc/posix/fnmatch.c","./lib/newlib/newlib/libc/posix/readdir.c","./lib/newlib/newlib/libc/posix/rewinddir.c","./lib/newlib/newlib/libc/posix/popen.c","./lib/newlib/newlib/libc/posix/execve.c","./lib/newlib/newlib/libc/posix/wordfree.c","./lib/newlib/newlib/libc/posix/Makefile.am","./lib/newlib/newlib/libc/posix/cname.h","./lib/newlib/newlib/libc/posix/regfree.c","./lib/newlib/newlib/libc/posix/engine.c","./lib/newlib/newlib/libc/posix/creat.c","./lib/newlib/newlib/libc/posix/COPYRIGHT","./lib/newlib/newlib/libc/posix/closedir.c","./lib/newlib/newlib/libc/string/memchr.c","./lib/newlib/newlib/libc/string/wcstrings.tex","./lib/newlib/newlib/libc/string/strdup_r.c","./lib/newlib/newlib/libc/string/rindex.c","./lib/newlib/newlib/libc/string/memmove.c","./lib/newlib/newlib/libc/string/wcswidth.c","./lib/newlib/newlib/libc/string/wmemcpy.c","./lib/newlib/newlib/libc/string/wmemcmp.c","./lib/newlib/newlib/libc/string/local.h","./lib/newlib/newlib/libc/string/wcsncasecmp.c","./lib/newlib/newlib/libc/string/strchr.c","./lib/newlib/newlib/libc/string/strnlen.c","./lib/newlib/newlib/libc/string/wcsstr.c","./lib/newlib/newlib/libc/string/wcsncmp.c","./lib/newlib/newlib/libc/string/wcslcpy.c","./lib/newlib/newlib/libc/string/stpcpy.c","./lib/newlib/newlib/libc/string/strndup_r.c","./lib/newlib/newlib/libc/string/memcmp.c","./lib/newlib/newlib/libc/string/bcmp.c","./lib/newlib/newlib/libc/string/strcoll.c","./lib/newlib/newlib/libc/string/wcspbrk.c","./lib/newlib/newlib/libc/string/memcpy.c","./lib/newlib/newlib/libc/string/strerror.c","./lib/newlib/newlib/libc/string/strrchr.c","./lib/newlib/newlib/libc/string/wcsrchr.c","./lib/newlib/newlib/libc/string/strcspn.c","./lib/newlib/newlib/libc/string/Makefile.in","./lib/newlib/newlib/libc/string/swab.c","./lib/newlib/newlib/libc/string/Hakefile","./lib/newlib/newlib/libc/string/strncpy.c","./lib/newlib/newlib/libc/string/wcscpy.c","./lib/newlib/newlib/libc/string/strsignal.c","./lib/newlib/newlib/libc/string/wmemset.c","./lib/newlib/newlib/libc/string/stpncpy.c","./lib/newlib/newlib/libc/string/index.c","./lib/newlib/newlib/libc/string/u_strerr.c","./lib/newlib/newlib/libc/string/strcat.c","./lib/newlib/newlib/libc/string/strdup.c","./lib/newlib/newlib/libc/string/strncasecmp.c","./lib/newlib/newlib/libc/string/strtok_r.c","./lib/newlib/newlib/libc/string/strncmp.c","./lib/newlib/newlib/libc/string/strlen.c","./lib/newlib/newlib/libc/string/wcscasecmp.c","./lib/newlib/newlib/libc/string/strtok.c","./lib/newlib/newlib/libc/string/strndup.c","./lib/newlib/newlib/libc/string/strcasestr.c","./lib/newlib/newlib/libc/string/wcpncpy.c","./lib/newlib/newlib/libc/string/mempcpy.c","./lib/newlib/newlib/libc/string/wcsncpy.c","./lib/newlib/newlib/libc/string/wcstok.c","./lib/newlib/newlib/libc/string/memset.c","./lib/newlib/newlib/libc/string/wcpcpy.c","./lib/newlib/newlib/libc/string/strupr.c","./lib/newlib/newlib/libc/string/wcscat.c","./lib/newlib/newlib/libc/string/wcschr.c","./lib/newlib/newlib/libc/string/strsep.c","./lib/newlib/newlib/libc/string/bcopy.c","./lib/newlib/newlib/libc/string/strstr.c","./lib/newlib/newlib/libc/string/wcsncat.c","./lib/newlib/newlib/libc/string/strcpy.c","./lib/newlib/newlib/libc/string/strings.tex","./lib/newlib/newlib/libc/string/strcasecmp.c","./lib/newlib/newlib/libc/string/wmemchr.c","./lib/newlib/newlib/libc/string/wcslcat.c","./lib/newlib/newlib/libc/string/strncat.c","./lib/newlib/newlib/libc/string/wcsdup.c","./lib/newlib/newlib/libc/string/strspn.c","./lib/newlib/newlib/libc/string/strlcat.c","./lib/newlib/newlib/libc/string/wcscmp.c","./lib/newlib/newlib/libc/string/bzero.c","./lib/newlib/newlib/libc/string/strpbrk.c","./lib/newlib/newlib/libc/string/strlcpy.c","./lib/newlib/newlib/libc/string/wcscspn.c","./lib/newlib/newlib/libc/string/wcscoll.c","./lib/newlib/newlib/libc/string/strlwr.c","./lib/newlib/newlib/libc/string/Makefile.am","./lib/newlib/newlib/libc/string/memmem.c","./lib/newlib/newlib/libc/string/str-two-way.h","./lib/newlib/newlib/libc/string/strcmp.c","./lib/newlib/newlib/libc/string/strxfrm.c","./lib/newlib/newlib/libc/string/wcsnlen.c","./lib/newlib/newlib/libc/string/strerror_r.c","./lib/newlib/newlib/libc/string/wcsspn.c","./lib/newlib/newlib/libc/string/wmemmove.c","./lib/newlib/newlib/libc/string/memccpy.c","./lib/newlib/newlib/libc/string/wcsxfrm.c","./lib/newlib/newlib/libc/string/wcwidth.c","./lib/newlib/newlib/libc/string/wcslen.c","./lib/newlib/newlib/libc/signal/Makefile.in","./lib/newlib/newlib/libc/signal/Hakefile","./lib/newlib/newlib/libc/signal/raise.c","./lib/newlib/newlib/libc/signal/signal.tex","./lib/newlib/newlib/libc/signal/Makefile.am","./lib/newlib/newlib/libc/signal/signal.c","./lib/newlib/newlib/libc/misc/ffs.c","./lib/newlib/newlib/libc/misc/Makefile.in","./lib/newlib/newlib/libc/misc/Hakefile","./lib/newlib/newlib/libc/misc/fini.c","./lib/newlib/newlib/libc/misc/unctrl.c","./lib/newlib/newlib/libc/misc/misc.tex","./lib/newlib/newlib/libc/misc/Makefile.am","./lib/newlib/newlib/libc/misc/__dprintf.c","./lib/newlib/newlib/libc/misc/init.c","./lib/newlib/newlib/libc/syscalls/sysexecve.c","./lib/newlib/newlib/libc/syscalls/sysclose.c","./lib/newlib/newlib/libc/syscalls/sysgettod.c","./lib/newlib/newlib/libc/syscalls/syskill.c","./lib/newlib/newlib/libc/syscalls/syslink.c","./lib/newlib/newlib/libc/syscalls/sysfcntl.c","./lib/newlib/newlib/libc/syscalls/sysopen.c","./lib/newlib/newlib/libc/syscalls/Makefile.in","./lib/newlib/newlib/libc/syscalls/sysunlink.c","./lib/newlib/newlib/libc/syscalls/sysstat.c","./lib/newlib/newlib/libc/syscalls/sysfstat.c","./lib/newlib/newlib/libc/syscalls/sysisatty.c","./lib/newlib/newlib/libc/syscalls/systimes.c","./lib/newlib/newlib/libc/syscalls/sysread.c","./lib/newlib/newlib/libc/syscalls/sysfork.c","./lib/newlib/newlib/libc/syscalls/sysgetpid.c","./lib/newlib/newlib/libc/syscalls/syswrite.c","./lib/newlib/newlib/libc/syscalls/syssbrk.c","./lib/newlib/newlib/libc/syscalls/Makefile.am","./lib/newlib/newlib/libc/syscalls/syswait.c","./lib/newlib/newlib/libc/syscalls/syslseek.c","./lib/newlib/newlib/libc/stdlib/lcong48.c","./lib/newlib/newlib/libc/stdlib/stdlib.tex","./lib/newlib/newlib/libc/stdlib/getsubopt.3","./lib/newlib/newlib/libc/stdlib/llabs.c","./lib/newlib/newlib/libc/stdlib/mtrim.c","./lib/newlib/newlib/libc/stdlib/drand48.c","./lib/newlib/newlib/libc/stdlib/mbstowcs_r.c","./lib/newlib/newlib/libc/stdlib/seed48.c","./lib/newlib/newlib/libc/stdlib/assert.c","./lib/newlib/newlib/libc/stdlib/cfreer.c","./lib/newlib/newlib/libc/stdlib/strtoull_r.c","./lib/newlib/newlib/libc/stdlib/mbsrtowcs.c","./lib/newlib/newlib/libc/stdlib/abort.c","./lib/newlib/newlib/libc/stdlib/strtold.c","./lib/newlib/newlib/libc/stdlib/atexit.c","./lib/newlib/newlib/libc/stdlib/local.h","./lib/newlib/newlib/libc/stdlib/ldtoa.c","./lib/newlib/newlib/libc/stdlib/mallstatsr.c","./lib/newlib/newlib/libc/stdlib/strtod.c","./lib/newlib/newlib/libc/stdlib/getsubopt.c","./lib/newlib/newlib/libc/stdlib/mbsnrtowcs.c","./lib/newlib/newlib/libc/stdlib/nrand48.c","./lib/newlib/newlib/libc/stdlib/malloptr.c","./lib/newlib/newlib/libc/stdlib/realloc.c","./lib/newlib/newlib/libc/stdlib/mallinfor.c","./lib/newlib/newlib/libc/stdlib/wcstol.c","./lib/newlib/newlib/libc/stdlib/strtoll.c","./lib/newlib/newlib/libc/stdlib/jrand48.c","./lib/newlib/newlib/libc/stdlib/mbtowc.c","./lib/newlib/newlib/libc/stdlib/strtoul.c","./lib/newlib/newlib/libc/stdlib/valloc.c","./lib/newlib/newlib/libc/stdlib/lldiv.c","./lib/newlib/newlib/libc/stdlib/calloc.c","./lib/newlib/newlib/libc/stdlib/getopt.c","./lib/newlib/newlib/libc/stdlib/mbstowcs.c","./lib/newlib/newlib/libc/stdlib/wctomb_r.c","./lib/newlib/newlib/libc/stdlib/atoll.c","./lib/newlib/newlib/libc/stdlib/reallocf.c","./lib/newlib/newlib/libc/stdlib/__exp10.c","./lib/newlib/newlib/libc/stdlib/setenv.c","./lib/newlib/newlib/libc/stdlib/pvallocr.c","./lib/newlib/newlib/libc/stdlib/_Exit.c","./lib/newlib/newlib/libc/stdlib/Makefile.in","./lib/newlib/newlib/libc/stdlib/Hakefile","./lib/newlib/newlib/libc/stdlib/gdtoa.h","./lib/newlib/newlib/libc/stdlib/mrand48.c","./lib/newlib/newlib/libc/stdlib/efgcvt.c","./lib/newlib/newlib/libc/stdlib/__ten_mu.c","./lib/newlib/newlib/libc/stdlib/__adjust.c","./lib/newlib/newlib/libc/stdlib/setenv_r.c","./lib/newlib/newlib/libc/stdlib/rand.c","./lib/newlib/newlib/libc/stdlib/div.c","./lib/newlib/newlib/libc/stdlib/wcstoul.c","./lib/newlib/newlib/libc/stdlib/exit.c","./lib/newlib/newlib/libc/stdlib/wcsnrtombs.c","./lib/newlib/newlib/libc/stdlib/__atexit.c","./lib/newlib/newlib/libc/stdlib/wcsrtombs.c","./lib/newlib/newlib/libc/stdlib/std.h","./lib/newlib/newlib/libc/stdlib/wcstoull.c","./lib/newlib/newlib/libc/stdlib/wcstold.c","./lib/newlib/newlib/libc/stdlib/mprec.h","./lib/newlib/newlib/libc/stdlib/a64l.c","./lib/newlib/newlib/libc/stdlib/atoi.c","./lib/newlib/newlib/libc/stdlib/wcstoull_r.c","./lib/newlib/newlib/libc/stdlib/putenv_r.c","./lib/newlib/newlib/libc/stdlib/wcstoll_r.c","./lib/newlib/newlib/libc/stdlib/ldiv.c","./lib/newlib/newlib/libc/stdlib/callocr.c","./lib/newlib/newlib/libc/stdlib/reallocr.c","./lib/newlib/newlib/libc/stdlib/srand48.c","./lib/newlib/newlib/libc/stdlib/abs.c","./lib/newlib/newlib/libc/stdlib/gdtoa-hexnan.c","./lib/newlib/newlib/libc/stdlib/atof.c","./lib/newlib/newlib/libc/stdlib/mblen.c","./lib/newlib/newlib/libc/stdlib/mblen_r.c","./lib/newlib/newlib/libc/stdlib/atoff.c","./lib/newlib/newlib/libc/stdlib/mallocr.c","./lib/newlib/newlib/libc/stdlib/erand48.c","./lib/newlib/newlib/libc/stdlib/msizer.c","./lib/newlib/newlib/libc/stdlib/wcrtomb.c","./lib/newlib/newlib/libc/stdlib/wctomb.c","./lib/newlib/newlib/libc/stdlib/vallocr.c","./lib/newlib/newlib/libc/stdlib/mbrtowc.c","./lib/newlib/newlib/libc/stdlib/wcstod.c","./lib/newlib/newlib/libc/stdlib/environ.c","./lib/newlib/newlib/libc/stdlib/eprintf.c","./lib/newlib/newlib/libc/stdlib/mbrlen.c","./lib/newlib/newlib/libc/stdlib/cxa_finalize.c","./lib/newlib/newlib/libc/stdlib/strtoll_r.c","./lib/newlib/newlib/libc/stdlib/wcstombs_r.c","./lib/newlib/newlib/libc/stdlib/gd_qnan.h","./lib/newlib/newlib/libc/stdlib/strtol.c","./lib/newlib/newlib/libc/stdlib/mbctype.h","./lib/newlib/newlib/libc/stdlib/malign.c","./lib/newlib/newlib/libc/stdlib/l64a.c","./lib/newlib/newlib/libc/stdlib/ecvtbuf.c","./lib/newlib/newlib/libc/stdlib/gdtoa-gethex.c","./lib/newlib/newlib/libc/stdlib/cxa_atexit.c","./lib/newlib/newlib/libc/stdlib/btowc.c","./lib/newlib/newlib/libc/stdlib/on_exit.c","./lib/newlib/newlib/libc/stdlib/rand48.c","./lib/newlib/newlib/libc/stdlib/dtoa.c","./lib/newlib/newlib/libc/stdlib/system.c","./lib/newlib/newlib/libc/stdlib/wctob.c","./lib/newlib/newlib/libc/stdlib/dtoastub.c","./lib/newlib/newlib/libc/stdlib/msize.c","./lib/newlib/newlib/libc/stdlib/envlock.c","./lib/newlib/newlib/libc/stdlib/strtoull.c","./lib/newlib/newlib/libc/stdlib/mprec.c","./lib/newlib/newlib/libc/stdlib/mbsinit.c","./lib/newlib/newlib/libc/stdlib/rand48.h","./lib/newlib/newlib/libc/stdlib/lrand48.c","./lib/newlib/newlib/libc/stdlib/malloc.c","./lib/newlib/newlib/libc/stdlib/putenv.c","./lib/newlib/newlib/libc/stdlib/Makefile.am","./lib/newlib/newlib/libc/stdlib/wcstoll.c","./lib/newlib/newlib/libc/stdlib/labs.c","./lib/newlib/newlib/libc/stdlib/getenv.c","./lib/newlib/newlib/libc/stdlib/rand_r.c","./lib/newlib/newlib/libc/stdlib/__call_atexit.c","./lib/newlib/newlib/libc/stdlib/getenv_r.c","./lib/newlib/newlib/libc/stdlib/mstats.c","./lib/newlib/newlib/libc/stdlib/sb_charsets.c","./lib/newlib/newlib/libc/stdlib/mbtowc_r.c","./lib/newlib/newlib/libc/stdlib/malignr.c","./lib/newlib/newlib/libc/stdlib/wcstombs.c","./lib/newlib/newlib/libc/stdlib/atol.c","./lib/newlib/newlib/libc/stdlib/mlock.c","./lib/newlib/newlib/libc/stdlib/atexit.h","./lib/newlib/newlib/libc/stdlib/freer.c","./lib/newlib/newlib/libc/reent/lseekr.c","./lib/newlib/newlib/libc/reent/lseek64r.c","./lib/newlib/newlib/libc/reent/fstat64r.c","./lib/newlib/newlib/libc/reent/readr.c","./lib/newlib/newlib/libc/reent/gettimeofdayr.c","./lib/newlib/newlib/libc/reent/Makefile.in","./lib/newlib/newlib/libc/reent/Hakefile","./lib/newlib/newlib/libc/reent/signalr.c","./lib/newlib/newlib/libc/reent/signgam.c","./lib/newlib/newlib/libc/reent/reent.c","./lib/newlib/newlib/libc/reent/sbrkr.c","./lib/newlib/newlib/libc/reent/impure.c","./lib/newlib/newlib/libc/reent/open64r.c","./lib/newlib/newlib/libc/reent/reent.tex","./lib/newlib/newlib/libc/reent/openr.c","./lib/newlib/newlib/libc/reent/unlinkr.c","./lib/newlib/newlib/libc/reent/timesr.c","./lib/newlib/newlib/libc/reent/mkdirr.c","./lib/newlib/newlib/libc/reent/fstatr.c","./lib/newlib/newlib/libc/reent/getreent.c","./lib/newlib/newlib/libc/reent/execr.c","./lib/newlib/newlib/libc/reent/fcntlr.c","./lib/newlib/newlib/libc/reent/closer.c","./lib/newlib/newlib/libc/reent/statr.c","./lib/newlib/newlib/libc/reent/writer.c","./lib/newlib/newlib/libc/reent/Makefile.am","./lib/newlib/newlib/libc/reent/isattyr.c","./lib/newlib/newlib/libc/reent/renamer.c","./lib/newlib/newlib/libc/reent/stat64r.c","./lib/newlib/newlib/libc/reent/linkr.c","./lib/newlib/newlib/libc/sys/barrelfish/findfp.c","./lib/newlib/newlib/libc/sys/barrelfish/oldsys_morecore.c","./lib/newlib/newlib/libc/sys/barrelfish/syscalls.c","./lib/newlib/newlib/libc/sys/barrelfish/dlmalloc.c","./lib/newlib/newlib/libc/sys/barrelfish/oldcalloc.c","./lib/newlib/newlib/libc/sys/barrelfish/Hakefile","./lib/newlib/newlib/libc/sys/barrelfish/posix_syscalls.c","./lib/newlib/newlib/libc/sys/barrelfish/mallocr.c","./lib/newlib/newlib/libc/sys/barrelfish/oldrealloc.c","./lib/newlib/newlib/libc/sys/barrelfish/sbrk.c","./lib/newlib/newlib/libc/sys/barrelfish/oldmalloc.c","./lib/newlib/newlib/libc/ctype/jp2uc.c","./lib/newlib/newlib/libc/ctype/isascii.c","./lib/newlib/newlib/libc/ctype/iswprint.c","./lib/newlib/newlib/libc/ctype/towupper.c","./lib/newlib/newlib/libc/ctype/wctype.c","./lib/newlib/newlib/libc/ctype/iswdigit.c","./lib/newlib/newlib/libc/ctype/iswspace.c","./lib/newlib/newlib/libc/ctype/local.h","./lib/newlib/newlib/libc/ctype/isupper.c","./lib/newlib/newlib/libc/ctype/iswalpha.c","./lib/newlib/newlib/libc/ctype/toupper.c","./lib/newlib/newlib/libc/ctype/isspace.c","./lib/newlib/newlib/libc/ctype/ctype_cp.h","./lib/newlib/newlib/libc/ctype/utf8print.h","./lib/newlib/newlib/libc/ctype/iswblank.c","./lib/newlib/newlib/libc/ctype/iswpunct.c","./lib/newlib/newlib/libc/ctype/ctype.tex","./lib/newlib/newlib/libc/ctype/iswlower.c","./lib/newlib/newlib/libc/ctype/towlower.c","./lib/newlib/newlib/libc/ctype/ispunct.c","./lib/newlib/newlib/libc/ctype/iscntrl.c","./lib/newlib/newlib/libc/ctype/Makefile.in","./lib/newlib/newlib/libc/ctype/isxdigit.c","./lib/newlib/newlib/libc/ctype/Hakefile","./lib/newlib/newlib/libc/ctype/isblank.c","./lib/newlib/newlib/libc/ctype/iswctype.c","./lib/newlib/newlib/libc/ctype/isalpha.c","./lib/newlib/newlib/libc/ctype/tolower.c","./lib/newlib/newlib/libc/ctype/towctrans.c","./lib/newlib/newlib/libc/ctype/jp2uc.h","./lib/newlib/newlib/libc/ctype/ctype_iso.h","./lib/newlib/newlib/libc/ctype/iswupper.c","./lib/newlib/newlib/libc/ctype/iswcntrl.c","./lib/newlib/newlib/libc/ctype/iswalnum.c","./lib/newlib/newlib/libc/ctype/wctrans.c","./lib/newlib/newlib/libc/ctype/ctype_.c","./lib/newlib/newlib/libc/ctype/toascii.c","./lib/newlib/newlib/libc/ctype/islower.c","./lib/newlib/newlib/libc/ctype/iswxdigit.c","./lib/newlib/newlib/libc/ctype/isprint.c","./lib/newlib/newlib/libc/ctype/iswgraph.c","./lib/newlib/newlib/libc/ctype/Makefile.am","./lib/newlib/newlib/libc/ctype/utf8alpha.h","./lib/newlib/newlib/libc/ctype/isalnum.c","./lib/newlib/newlib/libc/ctype/isdigit.c","./lib/newlib/newlib/libc/time/mktime.c","./lib/newlib/newlib/libc/time/lcltime_r.c","./lib/newlib/newlib/libc/time/strftime.c","./lib/newlib/newlib/libc/time/gettzinfo.c","./lib/newlib/newlib/libc/time/mktm_r.c","./lib/newlib/newlib/libc/time/local.h","./lib/newlib/newlib/libc/time/tzvars.c","./lib/newlib/newlib/libc/time/time.c","./lib/newlib/newlib/libc/time/ctime_r.c","./lib/newlib/newlib/libc/time/Makefile.in","./lib/newlib/newlib/libc/time/Hakefile","./lib/newlib/newlib/libc/time/asctime.c","./lib/newlib/newlib/libc/time/lcltime.c","./lib/newlib/newlib/libc/time/tzset_r.c","./lib/newlib/newlib/libc/time/ctime.c","./lib/newlib/newlib/libc/time/asctime_r.c","./lib/newlib/newlib/libc/time/wcsftime.c","./lib/newlib/newlib/libc/time/gmtime.c","./lib/newlib/newlib/libc/time/difftime.c","./lib/newlib/newlib/libc/time/tzset.c","./lib/newlib/newlib/libc/time/strptime.c","./lib/newlib/newlib/libc/time/gmtime_r.c","./lib/newlib/newlib/libc/time/tzlock.c","./lib/newlib/newlib/libc/time/Makefile.am","./lib/newlib/newlib/libc/time/time.tex","./lib/newlib/newlib/libc/time/clock.c","./lib/newlib/newlib/libc/search/qsort.c","./lib/newlib/newlib/libc/search/tsearch.3","./lib/newlib/newlib/libc/search/hash.c","./lib/newlib/newlib/libc/search/hcreate.3","./lib/newlib/newlib/libc/search/page.h","./lib/newlib/newlib/libc/search/hash.h","./lib/newlib/newlib/libc/search/Makefile.in","./lib/newlib/newlib/libc/search/Hakefile","./lib/newlib/newlib/libc/search/bsearch.c","./lib/newlib/newlib/libc/search/db_local.h","./lib/newlib/newlib/libc/search/hash_bigkey.c","./lib/newlib/newlib/libc/search/hash_log2.c","./lib/newlib/newlib/libc/search/tdelete.c","./lib/newlib/newlib/libc/search/hash_page.c","./lib/newlib/newlib/libc/search/hcreate.c","./lib/newlib/newlib/libc/search/tfind.c","./lib/newlib/newlib/libc/search/tsearch.c","./lib/newlib/newlib/libc/search/hcreate_r.c","./lib/newlib/newlib/libc/search/extern.h","./lib/newlib/newlib/libc/search/Makefile.am","./lib/newlib/newlib/libc/search/tdestroy.c","./lib/newlib/newlib/libc/search/hash_buf.c","./lib/newlib/newlib/libc/search/twalk.c","./lib/newlib/newlib/libc/search/hash_func.c","./lib/newlib/newlib/libc/stdio64/stdio64.tex","./lib/newlib/newlib/libc/stdio64/fgetpos64.c","./lib/newlib/newlib/libc/stdio64/stdio64.c","./lib/newlib/newlib/libc/stdio64/fseeko64.c","./lib/newlib/newlib/libc/stdio64/Makefile.in","./lib/newlib/newlib/libc/stdio64/fsetpos64.c","./lib/newlib/newlib/libc/stdio64/fdopen64.c","./lib/newlib/newlib/libc/stdio64/fopen64.c","./lib/newlib/newlib/libc/stdio64/freopen64.c","./lib/newlib/newlib/libc/stdio64/ftello64.c","./lib/newlib/newlib/libc/stdio64/dummy.c","./lib/newlib/newlib/libc/stdio64/Makefile.am","./lib/newlib/newlib/libc/stdio64/tmpfile64.c","./lib/newlib/newlib/libc/xdr/xdr_reference.c","./lib/newlib/newlib/libc/xdr/xdr_sizeof.c","./lib/newlib/newlib/libc/xdr/xdr_mem.c","./lib/newlib/newlib/libc/xdr/xdr.c","./lib/newlib/newlib/libc/xdr/xdr_array.c","./lib/newlib/newlib/libc/xdr/Makefile.in","./lib/newlib/newlib/libc/xdr/xdr_rec.c","./lib/newlib/newlib/libc/xdr/xdr_float_vax.c","./lib/newlib/newlib/libc/xdr/xdr_stdio.c","./lib/newlib/newlib/libc/xdr/xdr_private.c","./lib/newlib/newlib/libc/xdr/dummy.c","./lib/newlib/newlib/libc/xdr/Makefile.am","./lib/newlib/newlib/libc/xdr/xdr_private.h","./lib/newlib/newlib/libc/xdr/xdr_float.c","./lib/newlib/newlib/libc/errno/Makefile.in","./lib/newlib/newlib/libc/errno/Hakefile","./lib/newlib/newlib/libc/errno/errno.c","./lib/newlib/newlib/libc/errno/Makefile.am","./lib/newlib/newlib/libc/argz/envz_add.c","./lib/newlib/newlib/libc/argz/argz_create_sep.c","./lib/newlib/newlib/libc/argz/envz_entry.c","./lib/newlib/newlib/libc/argz/argz_extract.c","./lib/newlib/newlib/libc/argz/buf_findstr.c","./lib/newlib/newlib/libc/argz/Makefile.in","./lib/newlib/newlib/libc/argz/Hakefile","./lib/newlib/newlib/libc/argz/argz_insert.c","./lib/newlib/newlib/libc/argz/argz_stringify.c","./lib/newlib/newlib/libc/argz/envz_remove.c","./lib/newlib/newlib/libc/argz/buf_findstr.h","./lib/newlib/newlib/libc/argz/envz_strip.c","./lib/newlib/newlib/libc/argz/argz_replace.c","./lib/newlib/newlib/libc/argz/argz_append.c","./lib/newlib/newlib/libc/argz/argz_add.c","./lib/newlib/newlib/libc/argz/argz_create.c","./lib/newlib/newlib/libc/argz/envz_merge.c","./lib/newlib/newlib/libc/argz/argz_add_sep.c","./lib/newlib/newlib/libc/argz/argz_count.c","./lib/newlib/newlib/libc/argz/dummy.c","./lib/newlib/newlib/libc/argz/Makefile.am","./lib/newlib/newlib/libc/argz/envz_get.c","./lib/newlib/newlib/libc/argz/argz_next.c","./lib/newlib/newlib/libc/argz/argz_delete.c","./lib/newlib/newlib/doc/Makefile.in","./lib/newlib/newlib/doc/aclocal.m4","./lib/newlib/newlib/doc/configure","./lib/newlib/newlib/doc/configure.in","./lib/newlib/newlib/doc/doc.str","./lib/newlib/newlib/doc/Makefile.am","./lib/newlib/newlib/libm/Makefile.in","./lib/newlib/newlib/libm/Hakefile","./lib/newlib/newlib/libm/config.h.in","./lib/newlib/newlib/libm/aclocal.m4","./lib/newlib/newlib/libm/configure.in","./lib/newlib/newlib/libm/Makefile.am","./lib/newlib/newlib/libm/mathfp/s_atan2.c","./lib/newlib/newlib/libm/mathfp/w_jn.c","./lib/newlib/newlib/libm/mathfp/s_acos.c","./lib/newlib/newlib/libm/mathfp/w_drem.c","./lib/newlib/newlib/libm/mathfp/ef_hypot.c","./lib/newlib/newlib/libm/mathfp/e_atanh.c","./lib/newlib/newlib/libm/mathfp/ef_acosh.c","./lib/newlib/newlib/libm/mathfp/s_atan.c","./lib/newlib/newlib/libm/mathfp/sf_exp.c","./lib/newlib/newlib/libm/mathfp/ef_j0.c","./lib/newlib/newlib/libm/mathfp/sf_log.c","./lib/newlib/newlib/libm/mathfp/erf_lgamma.c","./lib/newlib/newlib/libm/mathfp/wf_drem.c","./lib/newlib/newlib/libm/mathfp/e_hypot.c","./lib/newlib/newlib/libm/mathfp/sf_atan.c","./lib/newlib/newlib/libm/mathfp/sf_cos.c","./lib/newlib/newlib/libm/mathfp/mathfp.tex","./lib/newlib/newlib/libm/mathfp/sf_sine.c","./lib/newlib/newlib/libm/mathfp/Makefile.in","./lib/newlib/newlib/libm/mathfp/sf_asine.c","./lib/newlib/newlib/libm/mathfp/er_gamma.c","./lib/newlib/newlib/libm/mathfp/sf_numtest.c","./lib/newlib/newlib/libm/mathfp/e_j0.c","./lib/newlib/newlib/libm/mathfp/s_ceil.c","./lib/newlib/newlib/libm/mathfp/sf_exp2.c","./lib/newlib/newlib/libm/mathfp/ef_remainder.c","./lib/newlib/newlib/libm/mathfp/s_pow.c","./lib/newlib/newlib/libm/mathfp/sf_acos.c","./lib/newlib/newlib/libm/mathfp/e_j1.c","./lib/newlib/newlib/libm/mathfp/e_scalb.c","./lib/newlib/newlib/libm/mathfp/sf_ldexp.c","./lib/newlib/newlib/libm/mathfp/s_exp.c","./lib/newlib/newlib/libm/mathfp/sf_erf.c","./lib/newlib/newlib/libm/mathfp/s_floor.c","./lib/newlib/newlib/libm/mathfp/e_acosh.c","./lib/newlib/newlib/libm/mathfp/e_remainder.c","./lib/newlib/newlib/libm/mathfp/sf_log10.c","./lib/newlib/newlib/libm/mathfp/s_sinh.c","./lib/newlib/newlib/libm/mathfp/s_asinh.c","./lib/newlib/newlib/libm/mathfp/sf_asinh.c","./lib/newlib/newlib/libm/mathfp/s_tan.c","./lib/newlib/newlib/libm/mathfp/sf_tgamma.c","./lib/newlib/newlib/libm/mathfp/sf_ispos.c","./lib/newlib/newlib/libm/mathfp/sf_floor.c","./lib/newlib/newlib/libm/mathfp/wf_cabs.c","./lib/newlib/newlib/libm/mathfp/s_sin.c","./lib/newlib/newlib/libm/mathfp/s_sincos.c","./lib/newlib/newlib/libm/mathfp/sf_cosh.c","./lib/newlib/newlib/libm/mathfp/sf_logarithm.c","./lib/newlib/newlib/libm/mathfp/s_fabs.c","./lib/newlib/newlib/libm/mathfp/sf_tan.c","./lib/newlib/newlib/libm/mathfp/er_lgamma.c","./lib/newlib/newlib/libm/mathfp/ef_j1.c","./lib/newlib/newlib/libm/mathfp/erf_gamma.c","./lib/newlib/newlib/libm/mathfp/sf_sin.c","./lib/newlib/newlib/libm/mathfp/ef_atanh.c","./lib/newlib/newlib/libm/mathfp/s_sinf.c","./lib/newlib/newlib/libm/mathfp/s_exp2.c","./lib/newlib/newlib/libm/mathfp/s_numtest.c","./lib/newlib/newlib/libm/mathfp/s_signif.c","./lib/newlib/newlib/libm/mathfp/s_logarithm.c","./lib/newlib/newlib/libm/mathfp/ef_scalb.c","./lib/newlib/newlib/libm/mathfp/s_sineh.c","./lib/newlib/newlib/libm/mathfp/wf_jn.c","./lib/newlib/newlib/libm/mathfp/sf_sqrt.c","./lib/newlib/newlib/libm/mathfp/s_log.c","./lib/newlib/newlib/libm/mathfp/s_cosh.c","./lib/newlib/newlib/libm/mathfp/s_erf.c","./lib/newlib/newlib/libm/mathfp/sf_sinh.c","./lib/newlib/newlib/libm/mathfp/sf_fmod.c","./lib/newlib/newlib/libm/mathfp/s_frexp.c","./lib/newlib/newlib/libm/mathfp/sf_tanh.c","./lib/newlib/newlib/libm/mathfp/sf_pow.c","./lib/newlib/newlib/libm/mathfp/sf_ceil.c","./lib/newlib/newlib/libm/mathfp/s_mathcnst.c","./lib/newlib/newlib/libm/mathfp/s_tgamma.c","./lib/newlib/newlib/libm/mathfp/s_cos.c","./lib/newlib/newlib/libm/mathfp/s_asin.c","./lib/newlib/newlib/libm/mathfp/sf_fabs.c","./lib/newlib/newlib/libm/mathfp/s_log10.c","./lib/newlib/newlib/libm/mathfp/s_sine.c","./lib/newlib/newlib/libm/mathfp/sf_sineh.c","./lib/newlib/newlib/libm/mathfp/Makefile.am","./lib/newlib/newlib/libm/mathfp/sf_frexp.c","./lib/newlib/newlib/libm/mathfp/s_tanh.c","./lib/newlib/newlib/libm/mathfp/s_ldexp.c","./lib/newlib/newlib/libm/mathfp/sf_atan2.c","./lib/newlib/newlib/libm/mathfp/s_asine.c","./lib/newlib/newlib/libm/mathfp/sf_signif.c","./lib/newlib/newlib/libm/mathfp/s_fmod.c","./lib/newlib/newlib/libm/mathfp/zmath.h","./lib/newlib/newlib/libm/mathfp/sf_atangent.c","./lib/newlib/newlib/libm/mathfp/w_cabs.c","./lib/newlib/newlib/libm/mathfp/s_atangent.c","./lib/newlib/newlib/libm/mathfp/sf_sincos.c","./lib/newlib/newlib/libm/mathfp/sf_asin.c","./lib/newlib/newlib/libm/mathfp/s_sqrt.c","./lib/newlib/newlib/libm/mathfp/s_ispos.c","./lib/newlib/newlib/libm/common/remainderl.c","./lib/newlib/newlib/libm/common/s_log2.c","./lib/newlib/newlib/libm/common/s_log1p.c","./lib/newlib/newlib/libm/common/sf_nan.c","./lib/newlib/newlib/libm/common/erfl.c","./lib/newlib/newlib/libm/common/sf_isnanf.c","./lib/newlib/newlib/libm/common/fdiml.c","./lib/newlib/newlib/libm/common/sf_fdim.c","./lib/newlib/newlib/libm/common/truncl.c","./lib/newlib/newlib/libm/common/s_isinf.c","./lib/newlib/newlib/libm/common/local.h","./lib/newlib/newlib/libm/common/sf_fma.c","./lib/newlib/newlib/libm/common/nanl.c","./lib/newlib/newlib/libm/common/sf_llrint.c","./lib/newlib/newlib/libm/common/frexpl.c","./lib/newlib/newlib/libm/common/s_exp10.c","./lib/newlib/newlib/libm/common/sf_trunc.c","./lib/newlib/newlib/libm/common/s_trunc.c","./lib/newlib/newlib/libm/common/coshl.c","./lib/newlib/newlib/libm/common/s_nextafter.c","./lib/newlib/newlib/libm/common/s_scalbln.c","./lib/newlib/newlib/libm/common/sf_infinity.c","./lib/newlib/newlib/libm/common/s_ilogb.c","./lib/newlib/newlib/libm/common/atanhl.c","./lib/newlib/newlib/libm/common/s_isnand.c","./lib/newlib/newlib/libm/common/s_nearbyint.c","./lib/newlib/newlib/libm/common/fmaxl.c","./lib/newlib/newlib/libm/common/hypotl.c","./lib/newlib/newlib/libm/common/tanl.c","./lib/newlib/newlib/libm/common/scalblnl.c","./lib/newlib/newlib/libm/common/s_logb.c","./lib/newlib/newlib/libm/common/sf_exp10.c","./lib/newlib/newlib/libm/common/s_rint.c","./lib/newlib/newlib/libm/common/exp2l.c","./lib/newlib/newlib/libm/common/lrintl.c","./lib/newlib/newlib/libm/common/s_llround.c","./lib/newlib/newlib/libm/common/asinhl.c","./lib/newlib/newlib/libm/common/sf_fmin.c","./lib/newlib/newlib/libm/common/sf_lrint.c","./lib/newlib/newlib/libm/common/s_llrint.c","./lib/newlib/newlib/libm/common/s_finite.c","./lib/newlib/newlib/libm/common/Makefile.in","./lib/newlib/newlib/libm/common/expm1l.c","./lib/newlib/newlib/libm/common/Hakefile","./lib/newlib/newlib/libm/common/sinl.c","./lib/newlib/newlib/libm/common/tanhl.c","./lib/newlib/newlib/libm/common/ceill.c","./lib/newlib/newlib/libm/common/fminl.c","./lib/newlib/newlib/libm/common/llroundl.c","./lib/newlib/newlib/libm/common/sf_scalbn.c","./lib/newlib/newlib/libm/common/sf_cbrt.c","./lib/newlib/newlib/libm/common/sf_nextafter.c","./lib/newlib/newlib/libm/common/sf_expm1.c","./lib/newlib/newlib/libm/common/sf_remquo.c","./lib/newlib/newlib/libm/common/sf_round.c","./lib/newlib/newlib/libm/common/sf_finite.c","./lib/newlib/newlib/libm/common/log10l.c","./lib/newlib/newlib/libm/common/sf_lround.c","./lib/newlib/newlib/libm/common/sf_nearbyint.c","./lib/newlib/newlib/libm/common/copysignl.c","./lib/newlib/newlib/libm/common/sinhl.c","./lib/newlib/newlib/libm/common/atanl.c","./lib/newlib/newlib/libm/common/s_remquo.c","./lib/newlib/newlib/libm/common/s_nan.c","./lib/newlib/newlib/libm/common/s_fdim.c","./lib/newlib/newlib/libm/common/s_isnan.c","./lib/newlib/newlib/libm/common/expl.c","./lib/newlib/newlib/libm/common/s_modf.c","./lib/newlib/newlib/libm/common/sqrtl.c","./lib/newlib/newlib/libm/common/fmodl.c","./lib/newlib/newlib/libm/common/acoshl.c","./lib/newlib/newlib/libm/common/s_fmin.c","./lib/newlib/newlib/libm/common/s_cbrt.c","./lib/newlib/newlib/libm/common/sf_modf.c","./lib/newlib/newlib/libm/common/s_matherr.c","./lib/newlib/newlib/libm/common/sf_copysign.c","./lib/newlib/newlib/libm/common/s_pow10.c","./lib/newlib/newlib/libm/common/ilogbl.c","./lib/newlib/newlib/libm/common/s_infconst.c","./lib/newlib/newlib/libm/common/powl.c","./lib/newlib/newlib/libm/common/s_infinity.c","./lib/newlib/newlib/libm/common/s_expm1.c","./lib/newlib/newlib/libm/common/s_lrint.c","./lib/newlib/newlib/libm/common/isgreater.c","./lib/newlib/newlib/libm/common/sf_isnan.c","./lib/newlib/newlib/libm/common/sf_isinff.c","./lib/newlib/newlib/libm/common/s_copysign.c","./lib/newlib/newlib/libm/common/sf_ilogb.c","./lib/newlib/newlib/libm/common/cbrtl.c","./lib/newlib/newlib/libm/common/asinl.c","./lib/newlib/newlib/libm/common/sf_isinf.c","./lib/newlib/newlib/libm/common/llrintl.c","./lib/newlib/newlib/libm/common/lroundl.c","./lib/newlib/newlib/libm/common/cosl.c","./lib/newlib/newlib/libm/common/s_fma.c","./lib/newlib/newlib/libm/common/s_lround.c","./lib/newlib/newlib/libm/common/sf_pow10.c","./lib/newlib/newlib/libm/common/scalbnl.c","./lib/newlib/newlib/libm/common/remquol.c","./lib/newlib/newlib/libm/common/ldexpl.c","./lib/newlib/newlib/libm/common/lgammal.c","./lib/newlib/newlib/libm/common/sf_scalbln.c","./lib/newlib/newlib/libm/common/nearbyintl.c","./lib/newlib/newlib/libm/common/fabsl.c","./lib/newlib/newlib/libm/common/s_scalbn.c","./lib/newlib/newlib/libm/common/sf_rint.c","./lib/newlib/newlib/libm/common/roundl.c","./lib/newlib/newlib/libm/common/atan2l.c","./lib/newlib/newlib/libm/common/nextafterl.c","./lib/newlib/newlib/libm/common/sf_llround.c","./lib/newlib/newlib/libm/common/sf_fmax.c","./lib/newlib/newlib/libm/common/s_lib_ver.c","./lib/newlib/newlib/libm/common/Makefile.am","./lib/newlib/newlib/libm/common/logl.c","./lib/newlib/newlib/libm/common/floorl.c","./lib/newlib/newlib/libm/common/s_isinfd.c","./lib/newlib/newlib/libm/common/tgammal.c","./lib/newlib/newlib/libm/common/erfcl.c","./lib/newlib/newlib/libm/common/s_fmax.c","./lib/newlib/newlib/libm/common/sf_log2.c","./lib/newlib/newlib/libm/common/sf_log1p.c","./lib/newlib/newlib/libm/common/rintl.c","./lib/newlib/newlib/libm/common/sf_logb.c","./lib/newlib/newlib/libm/common/sf_fpclassify.c","./lib/newlib/newlib/libm/common/acosl.c","./lib/newlib/newlib/libm/common/log1pl.c","./lib/newlib/newlib/libm/common/fmal.c","./lib/newlib/newlib/libm/common/modfl.c","./lib/newlib/newlib/libm/common/s_fpclassify.c","./lib/newlib/newlib/libm/common/fdlibm.h","./lib/newlib/newlib/libm/common/s_round.c","./lib/newlib/newlib/libm/common/s_signbit.c","./lib/newlib/newlib/libm/machine/Makefile.in","./lib/newlib/newlib/libm/machine/aclocal.m4","./lib/newlib/newlib/libm/machine/configure.in","./lib/newlib/newlib/libm/machine/Makefile.am","./lib/newlib/newlib/libm/machine/i386/i386mach.h","./lib/newlib/newlib/libm/machine/i386/f_logf.S","./lib/newlib/newlib/libm/machine/i386/f_log.S","./lib/newlib/newlib/libm/machine/i386/f_frexpf.S","./lib/newlib/newlib/libm/machine/i386/f_exp.c","./lib/newlib/newlib/libm/machine/i386/Makefile.in","./lib/newlib/newlib/libm/machine/i386/f_llrint.c","./lib/newlib/newlib/libm/machine/i386/f_llrintf.c","./lib/newlib/newlib/libm/machine/i386/f_rintl.c","./lib/newlib/newlib/libm/machine/i386/f_atan2.S","./lib/newlib/newlib/libm/machine/i386/aclocal.m4","./lib/newlib/newlib/libm/machine/i386/f_lrintl.c","./lib/newlib/newlib/libm/machine/i386/f_tanf.S","./lib/newlib/newlib/libm/machine/i386/f_math.h","./lib/newlib/newlib/libm/machine/i386/f_pow.c","./lib/newlib/newlib/libm/machine/i386/f_rintf.c","./lib/newlib/newlib/libm/machine/i386/configure.in","./lib/newlib/newlib/libm/machine/i386/f_atan2f.S","./lib/newlib/newlib/libm/machine/i386/f_ldexp.S","./lib/newlib/newlib/libm/machine/i386/f_frexp.S","./lib/newlib/newlib/libm/machine/i386/f_log10.S","./lib/newlib/newlib/libm/machine/i386/f_rint.c","./lib/newlib/newlib/libm/machine/i386/f_ldexpf.S","./lib/newlib/newlib/libm/machine/i386/f_tan.S","./lib/newlib/newlib/libm/machine/i386/f_llrintl.c","./lib/newlib/newlib/libm/machine/i386/f_lrintf.c","./lib/newlib/newlib/libm/machine/i386/Makefile.am","./lib/newlib/newlib/libm/machine/i386/f_powf.c","./lib/newlib/newlib/libm/machine/i386/f_log10f.S","./lib/newlib/newlib/libm/machine/i386/f_lrint.c","./lib/newlib/newlib/libm/machine/i386/f_expf.c","./lib/newlib/newlib/libm/machine/spu/w_atanh.c","./lib/newlib/newlib/libm/machine/spu/wf_cosh.c","./lib/newlib/newlib/libm/machine/spu/wf_sincos.c","./lib/newlib/newlib/libm/machine/spu/s_log1p.c","./lib/newlib/newlib/libm/machine/spu/fegetround.c","./lib/newlib/newlib/libm/machine/spu/sf_nan.c","./lib/newlib/newlib/libm/machine/spu/sf_isnanf.c","./lib/newlib/newlib/libm/machine/spu/llroundf.c","./lib/newlib/newlib/libm/machine/spu/w_log.c","./lib/newlib/newlib/libm/machine/spu/sf_fdim.c","./lib/newlib/newlib/libm/machine/spu/feraiseexcept.c","./lib/newlib/newlib/libm/machine/spu/w_fmod.c","./lib/newlib/newlib/libm/machine/spu/sf_fma.c","./lib/newlib/newlib/libm/machine/spu/s_atan.c","./lib/newlib/newlib/libm/machine/spu/sf_trunc.c","./lib/newlib/newlib/libm/machine/spu/s_trunc.c","./lib/newlib/newlib/libm/machine/spu/s_nextafter.c","./lib/newlib/newlib/libm/machine/spu/s_ilogb.c","./lib/newlib/newlib/libm/machine/spu/wf_exp.c","./lib/newlib/newlib/libm/machine/spu/s_nearbyint.c","./lib/newlib/newlib/libm/machine/spu/fesetenv.c","./lib/newlib/newlib/libm/machine/spu/w_lgamma.c","./lib/newlib/newlib/libm/machine/spu/wf_atanh.c","./lib/newlib/newlib/libm/machine/spu/w_atan2.c","./lib/newlib/newlib/libm/machine/spu/wf_acosh.c","./lib/newlib/newlib/libm/machine/spu/s_rint.c","./lib/newlib/newlib/libm/machine/spu/feupdateenv.c","./lib/newlib/newlib/libm/machine/spu/sf_atan.c","./lib/newlib/newlib/libm/machine/spu/sf_cos.c","./lib/newlib/newlib/libm/machine/spu/sf_fmin.c","./lib/newlib/newlib/libm/machine/spu/sf_lrint.c","./lib/newlib/newlib/libm/machine/spu/w_cosh.c","./lib/newlib/newlib/libm/machine/spu/llrintf.c","./lib/newlib/newlib/libm/machine/spu/wf_log.c","./lib/newlib/newlib/libm/machine/spu/Makefile.in","./lib/newlib/newlib/libm/machine/spu/s_ceil.c","./lib/newlib/newlib/libm/machine/spu/w_tgamma.c","./lib/newlib/newlib/libm/machine/spu/sf_scalbn.c","./lib/newlib/newlib/libm/machine/spu/wf_exp2.c","./lib/newlib/newlib/libm/machine/spu/sf_cbrt.c","./lib/newlib/newlib/libm/machine/spu/w_acosh.c","./lib/newlib/newlib/libm/machine/spu/log2.c","./lib/newlib/newlib/libm/machine/spu/sf_nextafter.c","./lib/newlib/newlib/libm/machine/spu/sf_expm1.c","./lib/newlib/newlib/libm/machine/spu/wf_pow.c","./lib/newlib/newlib/libm/machine/spu/sf_remquo.c","./lib/newlib/newlib/libm/machine/spu/sf_round.c","./lib/newlib/newlib/libm/machine/spu/sf_ldexp.c","./lib/newlib/newlib/libm/machine/spu/sf_finite.c","./lib/newlib/newlib/libm/machine/spu/w_sincos.c","./lib/newlib/newlib/libm/machine/spu/sf_erf.c","./lib/newlib/newlib/libm/machine/spu/wf_hypot.c","./lib/newlib/newlib/libm/machine/spu/sf_lround.c","./lib/newlib/newlib/libm/machine/spu/s_floor.c","./lib/newlib/newlib/libm/machine/spu/aclocal.m4","./lib/newlib/newlib/libm/machine/spu/sf_nearbyint.c","./lib/newlib/newlib/libm/machine/spu/w_asin.c","./lib/newlib/newlib/libm/machine/spu/wf_atan2.c","./lib/newlib/newlib/libm/machine/spu/s_asinh.c","./lib/newlib/newlib/libm/machine/spu/sf_asinh.c","./lib/newlib/newlib/libm/machine/spu/wf_sinh.c","./lib/newlib/newlib/libm/machine/spu/s_tan.c","./lib/newlib/newlib/libm/machine/spu/wf_lgamma.c","./lib/newlib/newlib/libm/machine/spu/s_remquo.c","./lib/newlib/newlib/libm/machine/spu/s_fdim.c","./lib/newlib/newlib/libm/machine/spu/wf_log10.c","./lib/newlib/newlib/libm/machine/spu/wf_asin.c","./lib/newlib/newlib/libm/machine/spu/w_sqrt.c","./lib/newlib/newlib/libm/machine/spu/s_isnan.c","./lib/newlib/newlib/libm/machine/spu/sf_floor.c","./lib/newlib/newlib/libm/machine/spu/wf_acos.c","./lib/newlib/newlib/libm/machine/spu/s_sin.c","./lib/newlib/newlib/libm/machine/spu/s_fabs.c","./lib/newlib/newlib/libm/machine/spu/sf_tan.c","./lib/newlib/newlib/libm/machine/spu/s_fmin.c","./lib/newlib/newlib/libm/machine/spu/configure","./lib/newlib/newlib/libm/machine/spu/s_cbrt.c","./lib/newlib/newlib/libm/machine/spu/sf_copysign.c","./lib/newlib/newlib/libm/machine/spu/sf_sin.c","./lib/newlib/newlib/libm/machine/spu/w_sinh.c","./lib/newlib/newlib/libm/machine/spu/configure.in","./lib/newlib/newlib/libm/machine/spu/s_expm1.c","./lib/newlib/newlib/libm/machine/spu/fegetexceptflag.c","./lib/newlib/newlib/libm/machine/spu/s_lrint.c","./lib/newlib/newlib/libm/machine/spu/sf_isnan.c","./lib/newlib/newlib/libm/machine/spu/wf_remainder.c","./lib/newlib/newlib/libm/machine/spu/sf_isinff.c","./lib/newlib/newlib/libm/machine/spu/w_remainder.c","./lib/newlib/newlib/libm/machine/spu/s_copysign.c","./lib/newlib/newlib/libm/machine/spu/w_exp.c","./lib/newlib/newlib/libm/machine/spu/wf_fmod.c","./lib/newlib/newlib/libm/machine/spu/sf_ilogb.c","./lib/newlib/newlib/libm/machine/spu/log2f.c","./lib/newlib/newlib/libm/machine/spu/sf_isinf.c","./lib/newlib/newlib/libm/machine/spu/fe_dfl_env.c","./lib/newlib/newlib/libm/machine/spu/w_log10.c","./lib/newlib/newlib/libm/machine/spu/fetestexcept.c","./lib/newlib/newlib/libm/machine/spu/wf_tgamma.c","./lib/newlib/newlib/libm/machine/spu/feholdexcept.c","./lib/newlib/newlib/libm/machine/spu/w_acos.c","./lib/newlib/newlib/libm/machine/spu/s_erf.c","./lib/newlib/newlib/libm/machine/spu/llround.c","./lib/newlib/newlib/libm/machine/spu/s_frexp.c","./lib/newlib/newlib/libm/machine/spu/sf_tanh.c","./lib/newlib/newlib/libm/machine/spu/s_fma.c","./lib/newlib/newlib/libm/machine/spu/wf_sqrt.c","./lib/newlib/newlib/libm/machine/spu/s_lround.c","./lib/newlib/newlib/libm/machine/spu/fesetexceptflag.c","./lib/newlib/newlib/libm/machine/spu/sf_ceil.c","./lib/newlib/newlib/libm/machine/spu/w_hypot.c","./lib/newlib/newlib/libm/machine/spu/s_cos.c","./lib/newlib/newlib/libm/machine/spu/llrint.c","./lib/newlib/newlib/libm/machine/spu/s_scalbn.c","./lib/newlib/newlib/libm/machine/spu/sf_rint.c","./lib/newlib/newlib/libm/machine/spu/sf_fabs.c","./lib/newlib/newlib/libm/machine/spu/w_pow.c","./lib/newlib/newlib/libm/machine/spu/sf_fmax.c","./lib/newlib/newlib/libm/machine/spu/Makefile.am","./lib/newlib/newlib/libm/machine/spu/sf_frexp.c","./lib/newlib/newlib/libm/machine/spu/s_fmax.c","./lib/newlib/newlib/libm/machine/spu/sf_log1p.c","./lib/newlib/newlib/libm/machine/spu/feclearexcept.c","./lib/newlib/newlib/libm/machine/spu/fegetenv.c","./lib/newlib/newlib/libm/machine/spu/s_tanh.c","./lib/newlib/newlib/libm/machine/spu/s_ldexp.c","./lib/newlib/newlib/libm/machine/spu/sf_logb.c","./lib/newlib/newlib/libm/machine/spu/sf_fpclassify.c","./lib/newlib/newlib/libm/machine/spu/w_exp2.c","./lib/newlib/newlib/libm/machine/spu/s_round.c","./lib/newlib/newlib/libm/machine/spu/fesetround.c","./lib/newlib/newlib/libm/machine/spu/headers/log.h","./lib/newlib/newlib/libm/machine/spu/headers/sinhf.h","./lib/newlib/newlib/libm/machine/spu/headers/tan.h","./lib/newlib/newlib/libm/machine/spu/headers/logf.h","./lib/newlib/newlib/libm/machine/spu/headers/fefpscr.h","./lib/newlib/newlib/libm/machine/spu/headers/acos.h","./lib/newlib/newlib/libm/machine/spu/headers/acoshf.h","./lib/newlib/newlib/libm/machine/spu/headers/nextafterd2.h","./lib/newlib/newlib/libm/machine/spu/headers/fesetenv.h","./lib/newlib/newlib/libm/machine/spu/headers/acosf.h","./lib/newlib/newlib/libm/machine/spu/headers/atanf4.h","./lib/newlib/newlib/libm/machine/spu/headers/ceilf.h","./lib/newlib/newlib/libm/machine/spu/headers/sincos.h","./lib/newlib/newlib/libm/machine/spu/headers/fdimf.h","./lib/newlib/newlib/libm/machine/spu/headers/acosf4.h","./lib/newlib/newlib/libm/machine/spu/headers/logd2.h","./lib/newlib/newlib/libm/machine/spu/headers/floord2.h","./lib/newlib/newlib/libm/machine/spu/headers/tanhd2.h","./lib/newlib/newlib/libm/machine/spu/headers/fegetexceptflag.h","./lib/newlib/newlib/libm/machine/spu/headers/log10.h","./lib/newlib/newlib/libm/machine/spu/headers/lgammaf.h","./lib/newlib/newlib/libm/machine/spu/headers/feholdexcept.h","./lib/newlib/newlib/libm/machine/spu/headers/sinf4.h","./lib/newlib/newlib/libm/machine/spu/headers/cosd2.h","./lib/newlib/newlib/libm/machine/spu/headers/sqrt.h","./lib/newlib/newlib/libm/machine/spu/headers/isnanf4.h","./lib/newlib/newlib/libm/machine/spu/headers/erf.h","./lib/newlib/newlib/libm/machine/spu/headers/powf.h","./lib/newlib/newlib/libm/machine/spu/headers/rintf4.h","./lib/newlib/newlib/libm/machine/spu/headers/log2.h","./lib/newlib/newlib/libm/machine/spu/headers/ldexpf.h","./lib/newlib/newlib/libm/machine/spu/headers/asin.h","./lib/newlib/newlib/libm/machine/spu/headers/cbrtf.h","./lib/newlib/newlib/libm/machine/spu/headers/tanf.h","./lib/newlib/newlib/libm/machine/spu/headers/coshf.h","./lib/newlib/newlib/libm/machine/spu/headers/sind2.h","./lib/newlib/newlib/libm/machine/spu/headers/fdim.h","./lib/newlib/newlib/libm/machine/spu/headers/nextafterf4.h","./lib/newlib/newlib/libm/machine/spu/headers/hypot.h","./lib/newlib/newlib/libm/machine/spu/headers/atanhf4.h","./lib/newlib/newlib/libm/machine/spu/headers/round.h","./lib/newlib/newlib/libm/machine/spu/headers/atanhf.h","./lib/newlib/newlib/libm/machine/spu/headers/copysign.h","./lib/newlib/newlib/libm/machine/spu/headers/expf.h","./lib/newlib/newlib/libm/machine/spu/headers/powd2.h","./lib/newlib/newlib/libm/machine/spu/headers/ilogb.h","./lib/newlib/newlib/libm/machine/spu/headers/log1pd2.h","./lib/newlib/newlib/libm/machine/spu/headers/tgammaf.h","./lib/newlib/newlib/libm/machine/spu/headers/asind2.h","./lib/newlib/newlib/libm/machine/spu/headers/logf4.h","./lib/newlib/newlib/libm/machine/spu/headers/sinhd2.h","./lib/newlib/newlib/libm/machine/spu/headers/cbrt.h","./lib/newlib/newlib/libm/machine/spu/headers/lrint.h","./lib/newlib/newlib/libm/machine/spu/headers/hypotf4.h","./lib/newlib/newlib/libm/machine/spu/headers/fmaxf.h","./lib/newlib/newlib/libm/machine/spu/headers/nearbyintf4.h","./lib/newlib/newlib/libm/machine/spu/headers/expm1d2.h","./lib/newlib/newlib/libm/machine/spu/headers/ldexp.h","./lib/newlib/newlib/libm/machine/spu/headers/dom_chkd_negone_one.h","./lib/newlib/newlib/libm/machine/spu/headers/ldexpf4.h","./lib/newlib/newlib/libm/machine/spu/headers/recipf4.h","./lib/newlib/newlib/libm/machine/spu/headers/expm1.h","./lib/newlib/newlib/libm/machine/spu/headers/feclearexcept.h","./lib/newlib/newlib/libm/machine/spu/headers/sin.h","./lib/newlib/newlib/libm/machine/spu/headers/floorf4.h","./lib/newlib/newlib/libm/machine/spu/headers/lround.h","./lib/newlib/newlib/libm/machine/spu/headers/asinhd2.h","./lib/newlib/newlib/libm/machine/spu/headers/fmodf.h","./lib/newlib/newlib/libm/machine/spu/headers/atanh.h","./lib/newlib/newlib/libm/machine/spu/headers/scalbnf.h","./lib/newlib/newlib/libm/machine/spu/headers/tanhf4.h","./lib/newlib/newlib/libm/machine/spu/headers/lgammad2.h","./lib/newlib/newlib/libm/machine/spu/headers/divd2.h","./lib/newlib/newlib/libm/machine/spu/headers/rintf.h","./lib/newlib/newlib/libm/machine/spu/headers/fmaf.h","./lib/newlib/newlib/libm/machine/spu/headers/asinf4.h","./lib/newlib/newlib/libm/machine/spu/headers/divf4.h","./lib/newlib/newlib/libm/machine/spu/headers/recipd2.h","./lib/newlib/newlib/libm/machine/spu/headers/fminf.h","./lib/newlib/newlib/libm/machine/spu/headers/remquo.h","./lib/newlib/newlib/libm/machine/spu/headers/cos_sin.h","./lib/newlib/newlib/libm/machine/spu/headers/roundf.h","./lib/newlib/newlib/libm/machine/spu/headers/lroundf.h","./lib/newlib/newlib/libm/machine/spu/headers/dom_chkd_less_than.h","./lib/newlib/newlib/libm/machine/spu/headers/copysignf.h","./lib/newlib/newlib/libm/machine/spu/headers/hypotd2.h","./lib/newlib/newlib/libm/machine/spu/headers/log2f.h","./lib/newlib/newlib/libm/machine/spu/headers/signbit.h","./lib/newlib/newlib/libm/machine/spu/headers/nextafterf.h","./lib/newlib/newlib/libm/machine/spu/headers/asinf.h","./lib/newlib/newlib/libm/machine/spu/headers/expm1f.h","./lib/newlib/newlib/libm/machine/spu/headers/asinh.h","./lib/newlib/newlib/libm/machine/spu/headers/asinhf4.h","./lib/newlib/newlib/libm/machine/spu/headers/expd2.h","./lib/newlib/newlib/libm/machine/spu/headers/atanf.h","./lib/newlib/newlib/libm/machine/spu/headers/acosd2.h","./lib/newlib/newlib/libm/machine/spu/headers/signbitd2.h","./lib/newlib/newlib/libm/machine/spu/headers/lgamma.h","./lib/newlib/newlib/libm/machine/spu/headers/logbf.h","./lib/newlib/newlib/libm/machine/spu/headers/isnan.h","./lib/newlib/newlib/libm/machine/spu/headers/sqrtf4.h","./lib/newlib/newlib/libm/machine/spu/headers/logbf4.h","./lib/newlib/newlib/libm/machine/spu/headers/exp2f.h","./lib/newlib/newlib/libm/machine/spu/headers/log1p.h","./lib/newlib/newlib/libm/machine/spu/headers/ldexpd2.h","./lib/newlib/newlib/libm/machine/spu/headers/trunc.h","./lib/newlib/newlib/libm/machine/spu/headers/log2f4.h","./lib/newlib/newlib/libm/machine/spu/headers/tanf4.h","./lib/newlib/newlib/libm/machine/spu/headers/dom_chkf_negone_one.h","./lib/newlib/newlib/libm/machine/spu/headers/expm1f4.h","./lib/newlib/newlib/libm/machine/spu/headers/remainderf.h","./lib/newlib/newlib/libm/machine/spu/headers/sqrtf.h","./lib/newlib/newlib/libm/machine/spu/headers/erfcf.h","./lib/newlib/newlib/libm/machine/spu/headers/sincosf4.h","./lib/newlib/newlib/libm/machine/spu/headers/hypotf.h","./lib/newlib/newlib/libm/machine/spu/headers/erfcf4.h","./lib/newlib/newlib/libm/machine/spu/headers/fegetround.h","./lib/newlib/newlib/libm/machine/spu/headers/log1pf4.h","./lib/newlib/newlib/libm/machine/spu/headers/llroundf.h","./lib/newlib/newlib/libm/machine/spu/headers/tgammad2.h","./lib/newlib/newlib/libm/machine/spu/headers/fegetenv.h","./lib/newlib/newlib/libm/machine/spu/headers/llround.h","./lib/newlib/newlib/libm/machine/spu/headers/sqrtd2.h","./lib/newlib/newlib/libm/machine/spu/headers/llrint.h","./lib/newlib/newlib/libm/machine/spu/headers/vec_literal.h","./lib/newlib/newlib/libm/machine/spu/headers/atan2.h","./lib/newlib/newlib/libm/machine/spu/headers/erfcd2.h","./lib/newlib/newlib/libm/machine/spu/headers/fabs.h","./lib/newlib/newlib/libm/machine/spu/headers/sincosf.h","./lib/newlib/newlib/libm/machine/spu/headers/powf4.h","./lib/newlib/newlib/libm/machine/spu/headers/simdmath.h","./lib/newlib/newlib/libm/machine/spu/headers/tgammaf4.h","./lib/newlib/newlib/libm/machine/spu/headers/sinf.h","./lib/newlib/newlib/libm/machine/spu/headers/sincosd2.h","./lib/newlib/newlib/libm/machine/spu/headers/erff4.h","./lib/newlib/newlib/libm/machine/spu/headers/nearbyint.h","./lib/newlib/newlib/libm/machine/spu/headers/atanhd2.h","./lib/newlib/newlib/libm/machine/spu/headers/acosh.h","./lib/newlib/newlib/libm/machine/spu/headers/atan2d2.h","./lib/newlib/newlib/libm/machine/spu/headers/fma.h","./lib/newlib/newlib/libm/machine/spu/headers/ceil.h","./lib/newlib/newlib/libm/machine/spu/headers/exp.h","./lib/newlib/newlib/libm/machine/spu/headers/llrintf.h","./lib/newlib/newlib/libm/machine/spu/headers/dom_chkf_less_than.h","./lib/newlib/newlib/libm/machine/spu/headers/tanhf.h","./lib/newlib/newlib/libm/machine/spu/headers/sinhf4.h","./lib/newlib/newlib/libm/machine/spu/headers/tand2.h","./lib/newlib/newlib/libm/machine/spu/headers/feupdateenv.h","./lib/newlib/newlib/libm/machine/spu/headers/atand2.h","./lib/newlib/newlib/libm/machine/spu/headers/nextafter.h","./lib/newlib/newlib/libm/machine/spu/headers/fmod.h","./lib/newlib/newlib/libm/machine/spu/headers/erfc.h","./lib/newlib/newlib/libm/machine/spu/headers/cosh.h","./lib/newlib/newlib/libm/machine/spu/headers/cosf.h","./lib/newlib/newlib/libm/machine/spu/headers/exp2f4.h","./lib/newlib/newlib/libm/machine/spu/headers/erfd2.h","./lib/newlib/newlib/libm/machine/spu/headers/log10d2.h","./lib/newlib/newlib/libm/machine/spu/headers/lgammaf4.h","./lib/newlib/newlib/libm/machine/spu/headers/erff.h","./lib/newlib/newlib/libm/machine/spu/headers/log2d2.h","./lib/newlib/newlib/libm/machine/spu/headers/fabsf.h","./lib/newlib/newlib/libm/machine/spu/headers/coshf4.h","./lib/newlib/newlib/libm/machine/spu/headers/frexpf.h","./lib/newlib/newlib/libm/machine/spu/headers/ilogbf.h","./lib/newlib/newlib/libm/machine/spu/headers/cosf4.h","./lib/newlib/newlib/libm/machine/spu/headers/exp2.h","./lib/newlib/newlib/libm/machine/spu/headers/tanh.h","./lib/newlib/newlib/libm/machine/spu/headers/rint.h","./lib/newlib/newlib/libm/machine/spu/headers/tgamma.h","./lib/newlib/newlib/libm/machine/spu/headers/isnanf.h","./lib/newlib/newlib/libm/machine/spu/headers/acoshf4.h","./lib/newlib/newlib/libm/machine/spu/headers/scalbnf4.h","./lib/newlib/newlib/libm/machine/spu/headers/fesetexceptflag.h","./lib/newlib/newlib/libm/machine/spu/headers/truncf.h","./lib/newlib/newlib/libm/machine/spu/headers/truncf4.h","./lib/newlib/newlib/libm/machine/spu/headers/pow.h","./lib/newlib/newlib/libm/machine/spu/headers/fmax.h","./lib/newlib/newlib/libm/machine/spu/headers/expf4.h","./lib/newlib/newlib/libm/machine/spu/headers/erf_utils.h","./lib/newlib/newlib/libm/machine/spu/headers/log1pf.h","./lib/newlib/newlib/libm/machine/spu/headers/sinh.h","./lib/newlib/newlib/libm/machine/spu/headers/asinhf.h","./lib/newlib/newlib/libm/machine/spu/headers/fetestexcept.h","./lib/newlib/newlib/libm/machine/spu/headers/nearbyintf.h","./lib/newlib/newlib/libm/machine/spu/headers/scalbn.h","./lib/newlib/newlib/libm/machine/spu/headers/isnand2.h","./lib/newlib/newlib/libm/machine/spu/headers/log10f.h","./lib/newlib/newlib/libm/machine/spu/headers/floor.h","./lib/newlib/newlib/libm/machine/spu/headers/exp2d2.h","./lib/newlib/newlib/libm/machine/spu/headers/lrintf.h","./lib/newlib/newlib/libm/machine/spu/headers/atan2f.h","./lib/newlib/newlib/libm/machine/spu/headers/feraiseexcept.h","./lib/newlib/newlib/libm/machine/spu/headers/truncd2.h","./lib/newlib/newlib/libm/machine/spu/headers/fesetround.h","./lib/newlib/newlib/libm/machine/spu/headers/atan.h","./lib/newlib/newlib/libm/machine/spu/headers/acoshd2.h","./lib/newlib/newlib/libm/machine/spu/headers/floorf.h","./lib/newlib/newlib/libm/machine/spu/headers/remainder.h","./lib/newlib/newlib/libm/machine/spu/headers/fmin.h","./lib/newlib/newlib/libm/machine/spu/headers/remquof.h","./lib/newlib/newlib/libm/machine/spu/headers/coshd2.h","./lib/newlib/newlib/libm/machine/spu/headers/atan2f4.h","./lib/newlib/newlib/libm/machine/spu/headers/frexp.h","./lib/newlib/newlib/libm/machine/spu/headers/cos.h","./lib/newlib/newlib/libm/test/atanhf_vec.c","./lib/newlib/newlib/libm/test/asin_vec.c","./lib/newlib/newlib/libm/test/erfcf_vec.c","./lib/newlib/newlib/libm/test/coshf_vec.c","./lib/newlib/newlib/libm/test/atan2_vec.c","./lib/newlib/newlib/libm/test/string.c","./lib/newlib/newlib/libm/test/gamma_vec.c","./lib/newlib/newlib/libm/test/cos_vec.c","./lib/newlib/newlib/libm/test/y0f_vec.c","./lib/newlib/newlib/libm/test/asinhf_vec.c","./lib/newlib/newlib/libm/test/sqrtf_vec.c","./lib/newlib/newlib/libm/test/dvec.c","./lib/newlib/newlib/libm/test/test.c","./lib/newlib/newlib/libm/test/atan_vec.c","./lib/newlib/newlib/libm/test/y0_vec.c","./lib/newlib/newlib/libm/test/dcvt.c","./lib/newlib/newlib/libm/test/tanh_vec.c","./lib/newlib/newlib/libm/test/sprint_vec.c","./lib/newlib/newlib/libm/test/asinf_vec.c","./lib/newlib/newlib/libm/test/log2_vec.c","./lib/newlib/newlib/libm/test/test_is.c","./lib/newlib/newlib/libm/test/fmodf_vec.c","./lib/newlib/newlib/libm/test/log_vec.c","./lib/newlib/newlib/libm/test/math2.c","./lib/newlib/newlib/libm/test/acosf_vec.c","./lib/newlib/newlib/libm/test/atanh_vec.c","./lib/newlib/newlib/libm/test/gammaf_vec.c","./lib/newlib/newlib/libm/test/y1_vec.c","./lib/newlib/newlib/libm/test/fmod_vec.c","./lib/newlib/newlib/libm/test/Makefile.in","./lib/newlib/newlib/libm/test/j0_vec.c","./lib/newlib/newlib/libm/test/exp_vec.c","./lib/newlib/newlib/libm/test/floorf_vec.c","./lib/newlib/newlib/libm/test/hypot_vec.c","./lib/newlib/newlib/libm/test/iconv_vec.c","./lib/newlib/newlib/libm/test/sinh_vec.c","./lib/newlib/newlib/libm/test/acos_vec.c","./lib/newlib/newlib/libm/test/jn_vec.c","./lib/newlib/newlib/libm/test/y1f_vec.c","./lib/newlib/newlib/libm/test/j1f_vec.c","./lib/newlib/newlib/libm/test/sinf_vec.c","./lib/newlib/newlib/libm/test/erff_vec.c","./lib/newlib/newlib/libm/test/acoshf_vec.c","./lib/newlib/newlib/libm/test/log10_vec.c","./lib/newlib/newlib/libm/test/j0f_vec.c","./lib/newlib/newlib/libm/test/cosf_vec.c","./lib/newlib/newlib/libm/test/ceil_vec.c","./lib/newlib/newlib/libm/test/convert.c","./lib/newlib/newlib/libm/test/ceilf_vec.c","./lib/newlib/newlib/libm/test/cosh_vec.c","./lib/newlib/newlib/libm/test/yn_vec.c","./lib/newlib/newlib/libm/test/tanhf_vec.c","./lib/newlib/newlib/libm/test/conv_vec.c","./lib/newlib/newlib/libm/test/log10f_vec.c","./lib/newlib/newlib/libm/test/atanf_vec.c","./lib/newlib/newlib/libm/test/test_ieee.c","./lib/newlib/newlib/libm/test/ynf_vec.c","./lib/newlib/newlib/libm/test/log1p_vec.c","./lib/newlib/newlib/libm/test/math.c","./lib/newlib/newlib/libm/test/atan2f_vec.c","./lib/newlib/newlib/libm/test/asinh_vec.c","./lib/newlib/newlib/libm/test/logf_vec.c","./lib/newlib/newlib/libm/test/tanf_vec.c","./lib/newlib/newlib/libm/test/hypotf_vec.c","./lib/newlib/newlib/libm/test/log2f_vec.c","./lib/newlib/newlib/libm/test/log1pf_vec.c","./lib/newlib/newlib/libm/test/sqrt_vec.c","./lib/newlib/newlib/libm/test/jnf_vec.c","./lib/newlib/newlib/libm/test/expf_vec.c","./lib/newlib/newlib/libm/test/erfc_vec.c","./lib/newlib/newlib/libm/test/fabsf_vec.c","./lib/newlib/newlib/libm/test/j1_vec.c","./lib/newlib/newlib/libm/test/fabs_vec.c","./lib/newlib/newlib/libm/test/floor_vec.c","./lib/newlib/newlib/libm/test/sin_vec.c","./lib/newlib/newlib/libm/test/sinhf_vec.c","./lib/newlib/newlib/libm/test/tan_vec.c","./lib/newlib/newlib/libm/test/sprint_ivec.c","./lib/newlib/newlib/libm/test/test.h","./lib/newlib/newlib/libm/test/erf_vec.c","./lib/newlib/newlib/libm/test/acosh_vec.c","./lib/newlib/newlib/libm/complex/cargf.c","./lib/newlib/newlib/libm/complex/ctanhf.c","./lib/newlib/newlib/libm/complex/casinf.c","./lib/newlib/newlib/libm/complex/clogf.c","./lib/newlib/newlib/libm/complex/catanh.c","./lib/newlib/newlib/libm/complex/ctan.c","./lib/newlib/newlib/libm/complex/conj.c","./lib/newlib/newlib/libm/complex/csinf.c","./lib/newlib/newlib/libm/complex/cexp.c","./lib/newlib/newlib/libm/complex/casinh.c","./lib/newlib/newlib/libm/complex/cimagf.c","./lib/newlib/newlib/libm/complex/csin.c","./lib/newlib/newlib/libm/complex/conjf.c","./lib/newlib/newlib/libm/complex/casinhf.c","./lib/newlib/newlib/libm/complex/cacosh.c","./lib/newlib/newlib/libm/complex/cimag.c","./lib/newlib/newlib/libm/complex/catanhf.c","./lib/newlib/newlib/libm/complex/cpow.c","./lib/newlib/newlib/libm/complex/Makefile.in","./lib/newlib/newlib/libm/complex/Hakefile","./lib/newlib/newlib/libm/complex/csinhf.c","./lib/newlib/newlib/libm/complex/ctanf.c","./lib/newlib/newlib/libm/complex/cexpf.c","./lib/newlib/newlib/libm/complex/casin.c","./lib/newlib/newlib/libm/complex/cacosf.c","./lib/newlib/newlib/libm/complex/catanf.c","./lib/newlib/newlib/libm/complex/csqrt.c","./lib/newlib/newlib/libm/complex/cprojf.c","./lib/newlib/newlib/libm/complex/cephes_subrf.h","./lib/newlib/newlib/libm/complex/ctanh.c","./lib/newlib/newlib/libm/complex/crealf.c","./lib/newlib/newlib/libm/complex/cabsf.c","./lib/newlib/newlib/libm/complex/cabs.c","./lib/newlib/newlib/libm/complex/cacoshf.c","./lib/newlib/newlib/libm/complex/csinh.c","./lib/newlib/newlib/libm/complex/complex.tex","./lib/newlib/newlib/libm/complex/csqrtf.c","./lib/newlib/newlib/libm/complex/clog.c","./lib/newlib/newlib/libm/complex/ccoshf.c","./lib/newlib/newlib/libm/complex/catan.c","./lib/newlib/newlib/libm/complex/Makefile.am","./lib/newlib/newlib/libm/complex/cacos.c","./lib/newlib/newlib/libm/complex/ccos.c","./lib/newlib/newlib/libm/complex/ccosf.c","./lib/newlib/newlib/libm/complex/cephes_subr.c","./lib/newlib/newlib/libm/complex/carg.c","./lib/newlib/newlib/libm/complex/cephes_subrf.c","./lib/newlib/newlib/libm/complex/cpowf.c","./lib/newlib/newlib/libm/complex/cproj.c","./lib/newlib/newlib/libm/complex/cephes_subr.h","./lib/newlib/newlib/libm/complex/creal.c","./lib/newlib/newlib/libm/complex/ccosh.c","./lib/newlib/newlib/libm/math/w_atanh.c","./lib/newlib/newlib/libm/math/wf_cosh.c","./lib/newlib/newlib/libm/math/k_cos.c","./lib/newlib/newlib/libm/math/k_sin.c","./lib/newlib/newlib/libm/math/kf_tan.c","./lib/newlib/newlib/libm/math/ef_atan2.c","./lib/newlib/newlib/libm/math/e_log.c","./lib/newlib/newlib/libm/math/w_jn.c","./lib/newlib/newlib/libm/math/wf_sincos.c","./lib/newlib/newlib/libm/math/w_drem.c","./lib/newlib/newlib/libm/math/ef_hypot.c","./lib/newlib/newlib/libm/math/w_log.c","./lib/newlib/newlib/libm/math/wrf_gamma.c","./lib/newlib/newlib/libm/math/ef_sqrt.c","./lib/newlib/newlib/libm/math/e_atanh.c","./lib/newlib/newlib/libm/math/k_rem_pio2.c","./lib/newlib/newlib/libm/math/kf_sin.c","./lib/newlib/newlib/libm/math/wf_gamma.c","./lib/newlib/newlib/libm/math/w_fmod.c","./lib/newlib/newlib/libm/math/ef_acosh.c","./lib/newlib/newlib/libm/math/s_atan.c","./lib/newlib/newlib/libm/math/e_cosh.c","./lib/newlib/newlib/libm/math/ef_fmod.c","./lib/newlib/newlib/libm/math/ef_j0.c","./lib/newlib/newlib/libm/math/ef_asin.c","./lib/newlib/newlib/libm/math/e_pow.c","./lib/newlib/newlib/libm/math/wf_exp.c","./lib/newlib/newlib/libm/math/w_lgamma.c","./lib/newlib/newlib/libm/math/ef_pow.c","./lib/newlib/newlib/libm/math/erf_lgamma.c","./lib/newlib/newlib/libm/math/wf_atanh.c","./lib/newlib/newlib/libm/math/w_atan2.c","./lib/newlib/newlib/libm/math/wf_acosh.c","./lib/newlib/newlib/libm/math/wf_drem.c","./lib/newlib/newlib/libm/math/e_hypot.c","./lib/newlib/newlib/libm/math/wr_gamma.c","./lib/newlib/newlib/libm/math/ef_sinh.c","./lib/newlib/newlib/libm/math/sf_atan.c","./lib/newlib/newlib/libm/math/ef_cosh.c","./lib/newlib/newlib/libm/math/sf_cos.c","./lib/newlib/newlib/libm/math/wr_lgamma.c","./lib/newlib/newlib/libm/math/w_cosh.c","./lib/newlib/newlib/libm/math/wf_log.c","./lib/newlib/newlib/libm/math/e_jn.c","./lib/newlib/newlib/libm/math/Makefile.in","./lib/newlib/newlib/libm/math/Hakefile","./lib/newlib/newlib/libm/math/e_atan2.c","./lib/newlib/newlib/libm/math/er_gamma.c","./lib/newlib/newlib/libm/math/e_j0.c","./lib/newlib/newlib/libm/math/s_ceil.c","./lib/newlib/newlib/libm/math/ef_remainder.c","./lib/newlib/newlib/libm/math/w_tgamma.c","./lib/newlib/newlib/libm/math/w_gamma.c","./lib/newlib/newlib/libm/math/ef_rem_pio2.c","./lib/newlib/newlib/libm/math/e_sinh.c","./lib/newlib/newlib/libm/math/e_fmod.c","./lib/newlib/newlib/libm/math/wf_exp2.c","./lib/newlib/newlib/libm/math/e_j1.c","./lib/newlib/newlib/libm/math/e_scalb.c","./lib/newlib/newlib/libm/math/w_acosh.c","./lib/newlib/newlib/libm/math/wf_pow.c","./lib/newlib/newlib/libm/math/sf_ldexp.c","./lib/newlib/newlib/libm/math/w_sincos.c","./lib/newlib/newlib/libm/math/sf_erf.c","./lib/newlib/newlib/libm/math/wf_hypot.c","./lib/newlib/newlib/libm/math/e_log10.c","./lib/newlib/newlib/libm/math/s_floor.c","./lib/newlib/newlib/libm/math/ef_log10.c","./lib/newlib/newlib/libm/math/e_acosh.c","./lib/newlib/newlib/libm/math/w_asin.c","./lib/newlib/newlib/libm/math/wf_atan2.c","./lib/newlib/newlib/libm/math/e_remainder.c","./lib/newlib/newlib/libm/math/kf_rem_pio2.c","./lib/newlib/newlib/libm/math/s_asinh.c","./lib/newlib/newlib/libm/math/w_j1.c","./lib/newlib/newlib/libm/math/sf_asinh.c","./lib/newlib/newlib/libm/math/wf_sinh.c","./lib/newlib/newlib/libm/math/math.tex","./lib/newlib/newlib/libm/math/s_tan.c","./lib/newlib/newlib/libm/math/wf_lgamma.c","./lib/newlib/newlib/libm/math/wf_log10.c","./lib/newlib/newlib/libm/math/wf_asin.c","./lib/newlib/newlib/libm/math/w_sqrt.c","./lib/newlib/newlib/libm/math/sf_floor.c","./lib/newlib/newlib/libm/math/wf_acos.c","./lib/newlib/newlib/libm/math/ef_exp.c","./lib/newlib/newlib/libm/math/s_sin.c","./lib/newlib/newlib/libm/math/s_fabs.c","./lib/newlib/newlib/libm/math/sf_tan.c","./lib/newlib/newlib/libm/math/er_lgamma.c","./lib/newlib/newlib/libm/math/ef_j1.c","./lib/newlib/newlib/libm/math/erf_gamma.c","./lib/newlib/newlib/libm/math/sf_sin.c","./lib/newlib/newlib/libm/math/w_sinh.c","./lib/newlib/newlib/libm/math/wf_scalb.c","./lib/newlib/newlib/libm/math/ef_atanh.c","./lib/newlib/newlib/libm/math/wf_remainder.c","./lib/newlib/newlib/libm/math/w_remainder.c","./lib/newlib/newlib/libm/math/w_exp.c","./lib/newlib/newlib/libm/math/s_signif.c","./lib/newlib/newlib/libm/math/wf_fmod.c","./lib/newlib/newlib/libm/math/ef_acos.c","./lib/newlib/newlib/libm/math/e_rem_pio2.c","./lib/newlib/newlib/libm/math/w_j0.c","./lib/newlib/newlib/libm/math/ef_scalb.c","./lib/newlib/newlib/libm/math/w_log10.c","./lib/newlib/newlib/libm/math/ef_log.c","./lib/newlib/newlib/libm/math/e_sqrt.c","./lib/newlib/newlib/libm/math/wf_jn.c","./lib/newlib/newlib/libm/math/wf_tgamma.c","./lib/newlib/newlib/libm/math/k_tan.c","./lib/newlib/newlib/libm/math/w_acos.c","./lib/newlib/newlib/libm/math/s_erf.c","./lib/newlib/newlib/libm/math/ef_jn.c","./lib/newlib/newlib/libm/math/wrf_lgamma.c","./lib/newlib/newlib/libm/math/s_frexp.c","./lib/newlib/newlib/libm/math/e_acos.c","./lib/newlib/newlib/libm/math/sf_tanh.c","./lib/newlib/newlib/libm/math/wf_sqrt.c","./lib/newlib/newlib/libm/math/sf_ceil.c","./lib/newlib/newlib/libm/math/w_hypot.c","./lib/newlib/newlib/libm/math/s_cos.c","./lib/newlib/newlib/libm/math/e_asin.c","./lib/newlib/newlib/libm/math/w_scalb.c","./lib/newlib/newlib/libm/math/sf_fabs.c","./lib/newlib/newlib/libm/math/wf_j0.c","./lib/newlib/newlib/libm/math/k_standard.c","./lib/newlib/newlib/libm/math/w_pow.c","./lib/newlib/newlib/libm/math/Makefile.am","./lib/newlib/newlib/libm/math/sf_frexp.c","./lib/newlib/newlib/libm/math/e_exp.c","./lib/newlib/newlib/libm/math/s_tanh.c","./lib/newlib/newlib/libm/math/wf_j1.c","./lib/newlib/newlib/libm/math/s_ldexp.c","./lib/newlib/newlib/libm/math/kf_cos.c","./lib/newlib/newlib/libm/math/w_exp2.c","./lib/newlib/newlib/libm/math/sf_signif.c","./lib/newlib/newlib/testsuite/newlib.locale/UTF-8.exp","./lib/newlib/newlib/testsuite/newlib.locale/locale.exp","./lib/newlib/newlib/testsuite/newlib.locale/UTF-8.c","./lib/newlib/newlib/testsuite/include/check.h","./lib/newlib/newlib/testsuite/newlib.search/hsearchtest.c","./lib/newlib/newlib/testsuite/newlib.search/hsearchtest.exp","./lib/newlib/newlib/testsuite/newlib.elix/elix.exp","./lib/newlib/newlib/testsuite/newlib.elix/tmmap.c","./lib/newlib/newlib/testsuite/lib/passfail.exp","./lib/newlib/newlib/testsuite/lib/checkoutput.exp","./lib/newlib/newlib/testsuite/lib/flags.exp","./lib/newlib/newlib/testsuite/lib/newlib.exp","./lib/newlib/newlib/testsuite/newlib.stdlib/stdlib.exp","./lib/newlib/newlib/testsuite/newlib.stdlib/size_max.c","./lib/newlib/newlib/testsuite/newlib.stdlib/atexit.c","./lib/newlib/newlib/testsuite/newlib.stdlib/atexit.exp","./lib/newlib/newlib/testsuite/newlib.wctype/twctrans.c","./lib/newlib/newlib/testsuite/newlib.wctype/twctype.c","./lib/newlib/newlib/testsuite/newlib.wctype/tiswctype.c","./lib/newlib/newlib/testsuite/newlib.wctype/wctype.exp","./lib/newlib/newlib/testsuite/config/default.exp","./lib/newlib/newlib/testsuite/newlib.string/tstring.c","./lib/newlib/newlib/testsuite/newlib.string/string.exp","./lib/newlib/newlib/testsuite/newlib.string/memmove1.c","./lib/newlib/newlib/testsuite/newlib.iconv/iconvnm.c","./lib/newlib/newlib/testsuite/newlib.iconv/iconvru.c","./lib/newlib/newlib/testsuite/newlib.iconv/iconv.exp","./lib/newlib/newlib/testsuite/newlib.iconv/iconvjp.c","./lib/newlib/config/bootstrap-debug.mk","./lib/newlib/config/override.m4","./lib/newlib/config/tls.m4","./lib/newlib/config/no-executables.m4","./lib/newlib/config/proginstall.m4","./lib/newlib/config/unwind_ipinfo.m4","./lib/newlib/config/mh-sysv4","./lib/newlib/config/gxx-include-dir.m4","./lib/newlib/config/enable.m4","./lib/newlib/config/mh-darwin","./lib/newlib/config/mh-cxux","./lib/newlib/config/mh-interix","./lib/newlib/config/bootstrap-debug-ckovw.mk","./lib/newlib/config/mh-necv4","./lib/newlib/config/bootstrap-lto.mk","./lib/newlib/config/mh-x86omitfp","./lib/newlib/config/plugins.m4","./lib/newlib/config/mh-ncr3000","./lib/newlib/config/bootstrap-debug-lib.mk","./lib/newlib/config/mh-solaris","./lib/newlib/config/depstand.m4","./lib/newlib/config/multi.m4","./lib/newlib/config/bootstrap-time.mk","./lib/newlib/config/tcl.m4","./lib/newlib/config/mt-ospace","./lib/newlib/config/dfp.m4","./lib/newlib/config/mh-ppc-aix","./lib/newlib/config/mt-alphaieee","./lib/newlib/config/mt-sde","./lib/newlib/config/bootstrap-O1.mk","./lib/newlib/config/mt-spu","./lib/newlib/config/mh-pa-hpux10","./lib/newlib/config/mt-mips-elfoabi","./lib/newlib/config/mt-gnu","./lib/newlib/config/mh-dgux386","./lib/newlib/config/mt-netware","./lib/newlib/config/mh-decstation","./lib/newlib/config/mh-cygwin","./lib/newlib/config/mh-mingw","./lib/newlib/config/mt-v810","./lib/newlib/config/mt-d30v","./lib/newlib/config/gettext-sister.m4","./lib/newlib/config/futex.m4","./lib/newlib/config/mh-djgpp","./lib/newlib/config/bootstrap-debug-big.mk","./lib/newlib/config/mt-mips-gnu","./lib/newlib/config/mt-mips16-compat","./lib/newlib/config/stdint.m4","./lib/newlib/config/bootstrap-debug-lean.mk","./lib/newlib/config/acx.m4","./lib/newlib/config/mh-pa","./lib/newlib/config/mt-mep","./lib/newlib/config/acinclude.m4","./lib/newlib/config/mt-wince","./lib/newlib/config/largefile.m4","./lib/newlib/config/extensions.m4","./lib/newlib/config/zlib.m4","./lib/newlib/config/mh-lynxrs6k","./lib/newlib/config/mh-sysv5","./lib/newlib/config/mh-sco","./lib/newlib/config/bootstrap-O3.mk","./lib/newlib/etc/ChangeLog","./lib/newlib/etc/configdev.ein","./lib/newlib/etc/configbuild.ein","./lib/newlib/etc/Makefile.in","./lib/newlib/etc/make-stds.texi","./lib/newlib/etc/configbuild.fig","./lib/newlib/etc/configbuild.tin","./lib/newlib/etc/configure.texi","./lib/newlib/etc/configdev.fig","./lib/newlib/etc/configure","./lib/newlib/etc/configure.in","./lib/newlib/etc/configdev.tin","./lib/newlib/etc/add-log.vi","./lib/newlib/etc/gnu-oids.texi","./lib/getopt/getopt.c","./lib/getopt/Hakefile","./lib/zlib/gzio.c","./lib/zlib/deflate.h","./lib/zlib/inflate.c","./lib/zlib/inftrees.h","./lib/zlib/uncompr.c","./lib/zlib/Hakefile","./lib/zlib/trees.h","./lib/zlib/inffast.h","./lib/zlib/trees.c","./lib/zlib/inffixed.h","./lib/zlib/inftrees.c","./lib/zlib/deflate.c","./lib/zlib/crc32.c","./lib/zlib/adler32.c","./lib/zlib/crc32.h","./lib/zlib/compress.c","./lib/zlib/infback.c","./lib/zlib/inflate.h","./lib/zlib/inffast.c","./lib/zlib/zutil.h","./lib/zlib/zutil.c","./lib/elf/elf32.c","./lib/elf/elf64.c","./lib/elf/Hakefile","./lib/elf/elf.c","./lib/crt/crtbegin.c","./lib/crt/Hakefile","./lib/crt/crtend.c","./lib/crt/README","./lib/crt/arch/x86_32/crt0.S","./lib/crt/arch/arm/crt0.S","./lib/crt/arch/x86_64/crt0.S","./lib/oldc/Hakefile","./lib/oldc/package.cfg","./lib/oldc/src/ferror.c","./lib/oldc/src/qsort.c","./lib/oldc/src/mktime.c","./lib/oldc/src/memchr.c","./lib/oldc/src/strftime.c","./lib/oldc/src/assert.c","./lib/oldc/src/ungetc.c","./lib/oldc/src/getchar.c","./lib/oldc/src/xprintf_int.c","./lib/oldc/src/memmove.c","./lib/oldc/src/fread.c","./lib/oldc/src/tmpfile.c","./lib/oldc/src/fputs.c","./lib/oldc/src/strtold.c","./lib/oldc/src/wmemcpy.c","./lib/oldc/src/xprintf_float.c","./lib/oldc/src/wmemcmp.c","./lib/oldc/src/local.h","./lib/oldc/src/strchr.c","./lib/oldc/src/realloc.c","./lib/oldc/src/floatio.h","./lib/oldc/src/strtoll.c","./lib/oldc/src/msgcat.c","./lib/oldc/src/memcmp.c","./lib/oldc/src/strtoul.c","./lib/oldc/src/fclose.c","./lib/oldc/src/strcoll.c","./lib/oldc/src/calloc.c","./lib/oldc/src/getopt.c","./lib/oldc/src/xprintf.c","./lib/oldc/src/memcpy.c","./lib/oldc/src/strerror.c","./lib/oldc/src/strrchr.c","./lib/oldc/src/strcspn.c","./lib/oldc/src/bsearch.c","./lib/oldc/src/asctime.c","./lib/oldc/src/strncpy.c","./lib/oldc/src/errno.c","./lib/oldc/src/snprintf.c","./lib/oldc/src/perror.c","./lib/oldc/src/wcscpy.c","./lib/oldc/src/rand.c","./lib/oldc/src/sprintf.c","./lib/oldc/src/fgetc.c","./lib/oldc/src/wmemset.c","./lib/oldc/src/_fread.c","./lib/oldc/src/exit.c","./lib/oldc/src/puts.c","./lib/oldc/src/strcat.c","./lib/oldc/src/strdup.c","./lib/oldc/src/vswprintf.c","./lib/oldc/src/locale.c","./lib/oldc/src/fputc.c","./lib/oldc/src/ftell.c","./lib/oldc/src/strncmp.c","./lib/oldc/src/strlen.c","./lib/oldc/src/vfprintf.c","./lib/oldc/src/fprintf.c","./lib/oldc/src/scanf.c","./lib/oldc/src/strtok.c","./lib/oldc/src/vfscanf.c","./lib/oldc/src/format.h","./lib/oldc/src/fflush.c","./lib/oldc/src/gmtime.c","./lib/oldc/src/wcsncpy.c","./lib/oldc/src/difftime.c","./lib/oldc/src/memset.c","./lib/oldc/src/fscanf.c","./lib/oldc/src/rewind.c","./lib/oldc/src/xprintf_str.c","./lib/oldc/src/fseek.c","./lib/oldc/src/strtol.c","./lib/oldc/src/strstr.c","./lib/oldc/src/strcpy.c","./lib/oldc/src/swprintf.c","./lib/oldc/src/wmemchr.c","./lib/oldc/src/sscanf.c","./lib/oldc/src/localtime.c","./lib/oldc/src/strncat.c","./lib/oldc/src/strspn.c","./lib/oldc/src/system.c","./lib/oldc/src/wcscmp.c","./lib/oldc/src/fpclassify.c","./lib/oldc/src/strpbrk.c","./lib/oldc/src/strtoull.c","./lib/oldc/src/strlcpy.c","./lib/oldc/src/fgets.c","./lib/oldc/src/wcscoll.c","./lib/oldc/src/vsscanf.c","./lib/oldc/src/malloc.c","./lib/oldc/src/clearerr.c","./lib/oldc/src/vprintf.c","./lib/oldc/src/getenv.c","./lib/oldc/src/strcmp.c","./lib/oldc/src/strxfrm.c","./lib/oldc/src/feof.c","./lib/oldc/src/putchar.c","./lib/oldc/src/fileno.c","./lib/oldc/src/wmemmove.c","./lib/oldc/src/setbuf.c","./lib/oldc/src/wcsxfrm.c","./lib/oldc/src/vsnprintf.c","./lib/oldc/src/_srefill.c","./lib/oldc/src/clock.c","./lib/oldc/src/printf.c","./lib/oldc/src/fwrite.c","./lib/oldc/src/wcslen.c","./lib/oldc/src/arch-x86_64/jmp.S","./lib/oldc/src/arch-x86_64/flt_rounds.c","./lib/oldc/src/arch-x86_64/asm.h","./lib/oldc/src/arch-arm/jmp.S","./lib/oldc/src/arch-arm/asm.h","./lib/oldc/src/locale/wctype.c","./lib/oldc/src/locale/mbsrtowcs.c","./lib/oldc/src/locale/table.c","./lib/oldc/src/locale/toupper.c","./lib/oldc/src/locale/lmessages.c","./lib/oldc/src/locale/lmonetary.c","./lib/oldc/src/locale/mbsnrtowcs.c","./lib/oldc/src/locale/setlocale.c","./lib/oldc/src/locale/un-namespace.h","./lib/oldc/src/locale/runefile.h","./lib/oldc/src/locale/wcstol.c","./lib/oldc/src/locale/lmessages.h","./lib/oldc/src/locale/none.c","./lib/oldc/src/locale/fix_grouping.c","./lib/oldc/src/locale/mblocal.h","./lib/oldc/src/locale/mbtowc.c","./lib/oldc/src/locale/mbstowcs.c","./lib/oldc/src/locale/setlocale.h","./lib/oldc/src/locale/wcstoul.c","./lib/oldc/src/locale/iswctype.c","./lib/oldc/src/locale/wcsnrtombs.c","./lib/oldc/src/locale/wcsrtombs.c","./lib/oldc/src/locale/collcmp.c","./lib/oldc/src/locale/wcstof.c","./lib/oldc/src/locale/tolower.c","./lib/oldc/src/locale/wcstoull.c","./lib/oldc/src/locale/wcstold.c","./lib/oldc/src/locale/wcstoimax.c","./lib/oldc/src/locale/collate.h","./lib/oldc/src/locale/lnumeric.h","./lib/oldc/src/locale/nomacros.c","./lib/oldc/src/locale/runetype.c","./lib/oldc/src/locale/mblen.c","./lib/oldc/src/locale/wcsftime.c","./lib/oldc/src/locale/collate.c","./lib/oldc/src/locale/wcstoumax.c","./lib/oldc/src/locale/wctrans.c","./lib/oldc/src/locale/wcrtomb.c","./lib/oldc/src/locale/wctomb.c","./lib/oldc/src/locale/mbrtowc.c","./lib/oldc/src/locale/wcstod.c","./lib/oldc/src/locale/mbrlen.c","./lib/oldc/src/locale/namespace.h","./lib/oldc/src/locale/ldpart.h","./lib/oldc/src/locale/btowc.c","./lib/oldc/src/locale/lmonetary.h","./lib/oldc/src/locale/wctob.c","./lib/oldc/src/locale/lnumeric.c","./lib/oldc/src/locale/mbsinit.c","./lib/oldc/src/locale/wcstoll.c","./lib/oldc/src/locale/ascii.c","./lib/oldc/src/locale/nextwctype.c","./lib/oldc/src/locale/wcstombs.c","./lib/oldc/src/arch-beehive/jmp.S","./lib/oldc/src/gdtoa/sum.c","./lib/oldc/src/gdtoa/strtodg.c","./lib/oldc/src/gdtoa/_hdtoa.c","./lib/oldc/src/gdtoa/strtod.c","./lib/oldc/src/gdtoa/smisc.c","./lib/oldc/src/gdtoa/dmisc.c","./lib/oldc/src/gdtoa/_ldtoa.c","./lib/oldc/src/gdtoa/gdtoa.h","./lib/oldc/src/gdtoa/gdtoa_fltrnds.h","./lib/oldc/src/gdtoa/hexnan.c","./lib/oldc/src/gdtoa/gmisc.c","./lib/oldc/src/gdtoa/gdtoa.c","./lib/oldc/src/gdtoa/_hldtoa.c","./lib/oldc/src/gdtoa/strtof.c","./lib/oldc/src/gdtoa/strtord.c","./lib/oldc/src/gdtoa/hd_init.c","./lib/oldc/src/gdtoa/misc.c","./lib/oldc/src/gdtoa/dtoa.c","./lib/oldc/src/gdtoa/gdtoaimp.h","./lib/oldc/src/gdtoa/gethex.c","./lib/oldc/src/gdtoa/ulp.c","./lib/oldc/src/gdtoa/x86_32/arith.h","./lib/oldc/src/gdtoa/x86_32/gd_qnan.h","./lib/oldc/src/gdtoa/arm/arith.h","./lib/oldc/src/gdtoa/arm/gd_qnan.h","./lib/oldc/src/gdtoa/x86_64/arith.h","./lib/oldc/src/gdtoa/x86_64/gd_qnan.h","./lib/oldc/src/gdtoa/beehive/arith.h","./lib/oldc/src/gdtoa/beehive/gd_qnan.h","./lib/oldc/src/sys-barrelfish/icc.c","./lib/oldc/src/sys-barrelfish/sys_stdio.c","./lib/oldc/src/sys-barrelfish/sys_tmpfile.c","./lib/oldc/src/sys-barrelfish/sys_abort.c","./lib/oldc/src/sys-barrelfish/sys_morecore.c","./lib/oldc/src/sys-barrelfish/sys_exit.c","./lib/oldc/src/fs-null/fopen.c","./lib/oldc/src/string/strcasecmp.c","./lib/oldc/src/fs-barrelfish/fopen.c","./lib/oldc/src/arch-x86_32/jmp.S","./lib/oldc/src/arch-x86_32/flt_rounds.c","./lib/oldc/src/arch-x86_32/asm.h","./lib/oldc/src/arch-powerpc64/jmp.S","./lib/oldc/src/arch-alpha/alpha-divrem.S","./lib/oldc/src/arch-alpha/alpha-divrem.m4","./lib/oldc/src/arch-alpha/dispatch.S","./lib/oldc/src/arch-alpha/halt.S","./lib/oldc/src/arch-mips64/jmp.S","./lib/oldc/test/test_libs_c.c","./lib/oldc/test/test_libs_c.h","./lib/oldc/test/fs-null/test_fs.c","./lib/oldc/msun/Hakefile","./lib/oldc/msun/ia64/s_fmal.S","./lib/oldc/msun/ia64/fenv.c","./lib/oldc/msun/ia64/s_fmaf.S","./lib/oldc/msun/ia64/s_fma.S","./lib/oldc/msun/powerpc/fenv.c","./lib/oldc/msun/ld128/invtrig.h","./lib/oldc/msun/ld128/s_exp2l.c","./lib/oldc/msun/ld128/invtrig.c","./lib/oldc/msun/ld128/s_nanl.c","./lib/oldc/msun/ld128/k_tanl.c","./lib/oldc/msun/ld128/k_cosl.c","./lib/oldc/msun/ld128/k_sinl.c","./lib/oldc/msun/src/e_asinf.c","./lib/oldc/msun/src/k_cos.c","./lib/oldc/msun/src/k_sin.c","./lib/oldc/msun/src/e_log.c","./lib/oldc/msun/src/e_gamma.c","./lib/oldc/msun/src/s_llroundl.c","./lib/oldc/msun/src/s_log1p.c","./lib/oldc/msun/src/w_drem.c","./lib/oldc/msun/src/e_sqrtf.c","./lib/oldc/msun/src/s_carg.c","./lib/oldc/msun/src/s_llrintl.c","./lib/oldc/msun/src/s_signgam.c","./lib/oldc/msun/src/e_atanh.c","./lib/oldc/msun/src/s_ilogbl.c","./lib/oldc/msun/src/s_tanhf.c","./lib/oldc/msun/src/s_atanl.c","./lib/oldc/msun/src/s_cbrtf.c","./lib/oldc/msun/src/k_rem_pio2.c","./lib/oldc/msun/src/s_isinf.c","./lib/oldc/msun/src/s_fmaxf.c","./lib/oldc/msun/src/s_cargl.c","./lib/oldc/msun/src/s_nextafterf.c","./lib/oldc/msun/src/s_atan.c","./lib/oldc/msun/src/e_cosh.c","./lib/oldc/msun/src/s_exp2f.c","./lib/oldc/msun/src/s_remquof.c","./lib/oldc/msun/src/s_conj.c","./lib/oldc/msun/src/s_log1pf.c","./lib/oldc/msun/src/s_trunc.c","./lib/oldc/msun/src/s_nextafter.c","./lib/oldc/msun/src/s_llrintf.c","./lib/oldc/msun/src/s_scalbln.c","./lib/oldc/msun/src/s_ilogbf.c","./lib/oldc/msun/src/e_pow.c","./lib/oldc/msun/src/s_ilogb.c","./lib/oldc/msun/src/s_ceill.c","./lib/oldc/msun/src/e_scalbf.c","./lib/oldc/msun/src/s_nearbyint.c","./lib/oldc/msun/src/s_logb.c","./lib/oldc/msun/src/s_csqrtl.c","./lib/oldc/msun/src/e_remainderf.c","./lib/oldc/msun/src/e_logf.c","./lib/oldc/msun/src/e_hypot.c","./lib/oldc/msun/src/e_rem_pio2f.c","./lib/oldc/msun/src/s_rint.c","./lib/oldc/msun/src/s_creall.c","./lib/oldc/msun/src/s_llround.c","./lib/oldc/msun/src/s_finitef.c","./lib/oldc/msun/src/s_nexttoward.c","./lib/oldc/msun/src/s_llrint.c","./lib/oldc/msun/src/s_finite.c","./lib/oldc/msun/src/s_fmaxl.c","./lib/oldc/msun/src/e_jn.c","./lib/oldc/msun/src/s_cimagf.c","./lib/oldc/msun/src/s_cimag.c","./lib/oldc/msun/src/e_atan2.c","./lib/oldc/msun/src/s_cosf.c","./lib/oldc/msun/src/s_fminf.c","./lib/oldc/msun/src/s_cproj.c","./lib/oldc/msun/src/e_jnf.c","./lib/oldc/msun/src/e_j0.c","./lib/oldc/msun/src/s_crealf.c","./lib/oldc/msun/src/s_ceil.c","./lib/oldc/msun/src/s_significandf.c","./lib/oldc/msun/src/s_fmal.c","./lib/oldc/msun/src/e_lgamma_r.c","./lib/oldc/msun/src/e_expf.c","./lib/oldc/msun/src/s_tgammaf.c","./lib/oldc/msun/src/s_csqrtf.c","./lib/oldc/msun/src/s_floorf.c","./lib/oldc/msun/src/e_sinh.c","./lib/oldc/msun/src/s_isnormal.c","./lib/oldc/msun/src/s_nextafterl.c","./lib/oldc/msun/src/e_fmod.c","./lib/oldc/msun/src/s_scalbnf.c","./lib/oldc/msun/src/e_j1.c","./lib/oldc/msun/src/e_powf.c","./lib/oldc/msun/src/e_log10f.c","./lib/oldc/msun/src/s_cprojf.c","./lib/oldc/msun/src/e_scalb.c","./lib/oldc/msun/src/e_atan2f.c","./lib/oldc/msun/src/s_lroundl.c","./lib/oldc/msun/src/s_floorl.c","./lib/oldc/msun/src/s_remquol.c","./lib/oldc/msun/src/e_log10.c","./lib/oldc/msun/src/s_floor.c","./lib/oldc/msun/src/e_acosh.c","./lib/oldc/msun/src/s_cosl.c","./lib/oldc/msun/src/e_remainder.c","./lib/oldc/msun/src/e_sqrtl.c","./lib/oldc/msun/src/s_asinh.c","./lib/oldc/msun/src/e_hypotf.c","./lib/oldc/msun/src/s_scalbnl.c","./lib/oldc/msun/src/s_frexpf.c","./lib/oldc/msun/src/s_tan.c","./lib/oldc/msun/src/e_atan2l.c","./lib/oldc/msun/src/s_ceilf.c","./lib/oldc/msun/src/s_lrintl.c","./lib/oldc/msun/src/e_gammaf.c","./lib/oldc/msun/src/s_truncf.c","./lib/oldc/msun/src/s_remquo.c","./lib/oldc/msun/src/s_nan.c","./lib/oldc/msun/src/s_fdim.c","./lib/oldc/msun/src/s_isnan.c","./lib/oldc/msun/src/s_csqrt.c","./lib/oldc/msun/src/math_private.h","./lib/oldc/msun/src/s_modf.c","./lib/oldc/msun/src/s_sin.c","./lib/oldc/msun/src/s_fabs.c","./lib/oldc/msun/src/s_fmin.c","./lib/oldc/msun/src/k_sinf.c","./lib/oldc/msun/src/s_cbrt.c","./lib/oldc/msun/src/s_modfl.c","./lib/oldc/msun/src/e_gamma_r.c","./lib/oldc/msun/src/k_tanf.c","./lib/oldc/msun/src/e_fmodl.c","./lib/oldc/msun/src/s_tanf.c","./lib/oldc/msun/src/s_expm1.c","./lib/oldc/msun/src/s_cimagl.c","./lib/oldc/msun/src/s_lrint.c","./lib/oldc/msun/src/s_fabsf.c","./lib/oldc/msun/src/w_cabsf.c","./lib/oldc/msun/src/s_sinf.c","./lib/oldc/msun/src/s_exp2.c","./lib/oldc/msun/src/s_rintl.c","./lib/oldc/msun/src/s_copysign.c","./lib/oldc/msun/src/e_lgammaf_r.c","./lib/oldc/msun/src/e_rem_pio2.c","./lib/oldc/msun/src/s_tanl.c","./lib/oldc/msun/src/w_cabsl.c","./lib/oldc/msun/src/s_isfinite.c","./lib/oldc/msun/src/e_acosl.c","./lib/oldc/msun/src/e_j0f.c","./lib/oldc/msun/src/s_modff.c","./lib/oldc/msun/src/s_creal.c","./lib/oldc/msun/src/s_fmaf.c","./lib/oldc/msun/src/e_sqrt.c","./lib/oldc/msun/src/s_truncl.c","./lib/oldc/msun/src/s_fabsl.c","./lib/oldc/msun/src/e_gammaf_r.c","./lib/oldc/msun/src/e_fmodf.c","./lib/oldc/msun/src/s_lroundf.c","./lib/oldc/msun/src/k_tan.c","./lib/oldc/msun/src/s_erf.c","./lib/oldc/msun/src/s_cargf.c","./lib/oldc/msun/src/s_frexpl.c","./lib/oldc/msun/src/e_remainderl.c","./lib/oldc/msun/src/e_j1f.c","./lib/oldc/msun/src/s_frexp.c","./lib/oldc/msun/src/e_acos.c","./lib/oldc/msun/src/s_lrintf.c","./lib/oldc/msun/src/s_fma.c","./lib/oldc/msun/src/e_acoshf.c","./lib/oldc/msun/src/e_coshf.c","./lib/oldc/msun/src/k_cosf.c","./lib/oldc/msun/src/w_dremf.c","./lib/oldc/msun/src/s_lround.c","./lib/oldc/msun/src/e_hypotl.c","./lib/oldc/msun/src/e_asinl.c","./lib/oldc/msun/src/s_cos.c","./lib/oldc/msun/src/s_erff.c","./lib/oldc/msun/src/s_roundl.c","./lib/oldc/msun/src/e_asin.c","./lib/oldc/msun/src/s_scalbn.c","./lib/oldc/msun/src/s_logbl.c","./lib/oldc/msun/src/e_atanhf.c","./lib/oldc/msun/src/s_rintf.c","./lib/oldc/msun/src/e_sinhf.c","./lib/oldc/msun/src/s_logbf.c","./lib/oldc/msun/src/s_fmax.c","./lib/oldc/msun/src/s_roundf.c","./lib/oldc/msun/src/s_llroundf.c","./lib/oldc/msun/src/s_cprojl.c","./lib/oldc/msun/src/s_fminl.c","./lib/oldc/msun/src/s_copysignl.c","./lib/oldc/msun/src/e_exp.c","./lib/oldc/msun/src/s_asinhf.c","./lib/oldc/msun/src/s_tanh.c","./lib/oldc/msun/src/s_ldexp.c","./lib/oldc/msun/src/e_lgammaf.c","./lib/oldc/msun/src/s_nexttowardf.c","./lib/oldc/msun/src/e_acosf.c","./lib/oldc/msun/src/s_copysignf.c","./lib/oldc/msun/src/s_atanf.c","./lib/oldc/msun/src/s_sinl.c","./lib/oldc/msun/src/s_conjf.c","./lib/oldc/msun/src/w_cabs.c","./lib/oldc/msun/src/s_conjl.c","./lib/oldc/msun/src/s_expm1f.c","./lib/oldc/msun/src/s_significand.c","./lib/oldc/msun/src/s_round.c","./lib/oldc/msun/src/e_lgamma.c","./lib/oldc/msun/src/s_signbit.c","./lib/oldc/msun/amd64/s_lrintf.S","./lib/oldc/msun/amd64/e_sqrtl.S","./lib/oldc/msun/amd64/s_llrintf.S","./lib/oldc/msun/amd64/s_remquo.S","./lib/oldc/msun/amd64/e_remainderf.S","./lib/oldc/msun/amd64/fenv.c","./lib/oldc/msun/amd64/s_scalbnf.S","./lib/oldc/msun/amd64/s_llrint.S","./lib/oldc/msun/amd64/s_scalbnl.S","./lib/oldc/msun/amd64/s_scalbn.S","./lib/oldc/msun/amd64/s_llrintl.S","./lib/oldc/msun/amd64/s_lrintl.S","./lib/oldc/msun/amd64/e_sqrtf.S","./lib/oldc/msun/amd64/e_sqrt.S","./lib/oldc/msun/amd64/s_lrint.S","./lib/oldc/msun/amd64/s_remquof.S","./lib/oldc/msun/amd64/s_remquol.S","./lib/oldc/msun/arm/fenv.c","./lib/oldc/msun/mips/fenv.c","./lib/oldc/msun/ld80/invtrig.h","./lib/oldc/msun/ld80/s_exp2l.c","./lib/oldc/msun/ld80/invtrig.c","./lib/oldc/msun/ld80/s_nanl.c","./lib/oldc/msun/ld80/k_tanl.c","./lib/oldc/msun/ld80/k_cosl.c","./lib/oldc/msun/ld80/k_sinl.c","./lib/oldc/msun/sparc64/fenv.c","./lib/oldc/msun/sparc64/e_sqrtf.S","./lib/oldc/msun/sparc64/e_sqrt.S","./lib/oldc/msun/beehive/fenv.c","./lib/oldc/doc/filesystem_design","./kernel/memmove.c","./kernel/string.c","./kernel/Hakefile","./kernel/stdlib.c","./kernel/dispatch.c","./kernel/memset.c","./kernel/startup.c","./kernel/printf.c","./kernel/arch/submission_Karkatsoulis_Antonios.tar.gz","./kernel/arch/armv7/cp15.S","./kernel/arch/armv7/kludges.c","./kernel/arch/armv7/linker.lds.in","./kernel/arch/armv7/kputchar.c","./kernel/arch/armv7/gic.c","./kernel/arch/armv7/exceptions.S","./kernel/arch/arm/exn.c","./kernel/arch/arm/exec.c","./kernel/arch/arm/misc.c","./kernel/arch/omap44xx/startup_helpers.c","./kernel/arch/omap44xx/paging.c","./kernel/arch/omap44xx/boot.S","./kernel/arch/omap44xx/multiboot.c","./kernel/arch/omap44xx/startup_arch.c","./kernel/arch/omap44xx/omap_led.c","./kernel/arch/omap44xx/omap.c","./kernel/arch/omap44xx/omap_uart.c","./kernel/arch/omap44xx/start_aps.c","./kernel/arch/omap44xx/omap_gic.c","./kernel/arch/omap44xx/init.c","./kernel/include/dispatch.h","./kernel/include/exec.h","./kernel/include/timer.h","./kernel/include/cap_predicates.h","./kernel/include/paging_generic.h","./kernel/include/startup.h","./kernel/include/wakeup.h","./kernel/include/microbenchmarks.h","./kernel/include/diteinfo.h","./kernel/include/serial.h","./kernel/include/syscall.h","./kernel/include/kernel.h","./kernel/include/useraccess.h","./kernel/include/paging_kernel_helper.h","./kernel/include/multiboot.h","./kernel/include/schedule.h","./kernel/include/gdb_stub.h","./kernel/include/arch/armv7/startup_arch.h","./kernel/include/arch/armv7/offsets.h","./kernel/include/arch/armv7/start_aps.h","./kernel/include/arch/armv7/startup_helpers.h","./kernel/include/arch/armv7/armv7_syscall.h","./kernel/include/arch/armv7/paging_kernel_arch.h","./kernel/include/arch/armv7/arm_core_data.h","./kernel/include/arch/armv7/omap44xx_led.h","./kernel/include/arch/armv7/pl011_uart.h","./kernel/include/arch/armv7/exceptions.h","./kernel/include/arch/armv7/ti_i2c.h","./kernel/include/arch/armv7/irq.h","./kernel/include/arch/armv7/kputchar.h","./kernel/include/arch/armv7/ixp2800_uart.h","./kernel/include/arch/armv7/gic.h","./kernel/include/arch/armv7/global.h","./kernel/include/arch/armv7/io.h","./kernel/include/arch/armv7/init.h","./kernel/include/arch/armv7/misc.h","./kernel/include/arch/armv7/arm_hal.h","./kernel/include/arch/armv7/arm.h","./kernel/include/arch/armv7/arch_gdb_stub.h","./kernel/include/arch/armv7/phys_mmap.h","./kernel/include/arch/armv7/cp15.h","./kernel/include/arch/armv7/kernel_multiboot.h","./molly_panda/molly_ld_script","./molly_panda/tmp_molly__armv7_sbin_cpu_omap44xx","./molly_panda/tmp_molly__armv7_sbin_init","./if/xmplcr.if","./if/serial.if","./if/nameservice.if","./if/monitor.if","./if/net_ports.if","./if/mouse.if","./if/skb.if","./if/net_queue_manager.if","./if/net_soft_filters.if","./if/hpet.if","./if/intermon.if","./if/ehci.if","./if/fb.if","./if/monitor_mem.if","./if/rcce.if","./if/glue_bench.if","./if/skb_map.if","./if/empty.if","./if/boot_perfmon.if","./if/trivfs.if","./if/keyboard.if","./if/unixsock.if","./if/replay.if","./if/Hakefile","./if/dist_event.if","./if/ata_rw28.if","./if/xmplthc.if","./if/ahci_mgmt.if","./if/pixels.if","./if/net_ARP.if","./if/bcast.if","./if/acpi.if","./if/xmplmsg.if","./if/usb_manager.if","./if/bench.if","./if/bcache.if","./if/bulkbench.if","./if/monitor_blocking.if","./if/lock.if","./if/mem.if","./if/test.if","./if/xcorecap.if","./if/types.if","./if/ping_pong.if","./if/interdisp.if","./if/spawn.if","./if/timer.if","./if/pci.if","./if/xmplrpc.if","./if/xcorecapbench.if","./if/bfs.if","./if/lpc_kbd.if","./if/usb_driver.if","./if/octopus.if","./if/arch/x86_64.if","./if/arch/scc.if","./if/arch/x86_32.if","./if/arch/armv5.if","./if/arch/armv7.if","./if/arch/xscale.if","./if/platform/x86_64.if","./if/platform/scc.if","./if/platform/x86_32.if","./if/platform/armv5.if","./if/platform/armv7.if","./if/platform/xscale.if","./tools/arm-mkbootcpio.sh","./tools/grub-qemu.img","./tools/arm-mkbootelf.sh","./tools/gen-gdbscript.sh","./tools/debug.sh","./tools/debugsim.sh","./tools/debug.arm.gdb","./tools/debug.gdb","./tools/run-pdflatex.sh","./tools/bin/arm_molly","./tools/bin/fugu","./tools/bin/.marker","./tools/arm_gem5/O3_ARM_v7a.py","./tools/arm_gem5/RealView.py","./tools/arm_gem5/additional_notes.txt","./tools/arm_gem5/boot.arm","./tools/arm_gem5/gem5Panda.py","./tools/arm_gem5/debug.gem5.core1.gdb","./tools/arm_gem5/CacheConfig.py","./tools/arm_gem5/Caches.py","./tools/arm_gem5/arm-with-neon.xml","./tools/arm_gem5/gem5_patches.patch","./tools/arm_gem5/arm-vfpv3.xml","./tools/arm_gem5/debug.gem5.gdb","./tools/arm_gem5/arm-core.xml","./tools/arm_gem5/gem5script.py","./tools/arm_gem5/README","./tools/tracing/bfscope.py","./tools/tracing/analyze_traces.py","./tools/pleco/Parser.hs","./tools/pleco/Makefile","./tools/pleco/Hakefile","./tools/pleco/Main.lhs","./tools/schedsim/be17.cfg","./tools/schedsim/gang1.txt","./tools/schedsim/be7.cfg","./tools/schedsim/hrtbe0.cfg","./tools/schedsim/hrt1.txt","./tools/schedsim/simulator.c","./tools/schedsim/hrt4.cfg","./tools/schedsim/hrt3.txt","./tools/schedsim/be8.txt","./tools/schedsim/hrtbe0.txt","./tools/schedsim/hrt1.cfg","./tools/schedsim/hrtbe1.cfg","./tools/schedsim/gang2.cfg","./tools/schedsim/be7.txt","./tools/schedsim/hrtbe2.txt","./tools/schedsim/be13.cfg","./tools/schedsim/hrt2.txt","./tools/schedsim/hrtbe4.cfg","./tools/schedsim/be4.cfg","./tools/schedsim/be11.cfg","./tools/schedsim/be6.txt","./tools/schedsim/be2.cfg","./tools/schedsim/hrtbe3.txt","./tools/schedsim/hrtbe3.cfg","./tools/schedsim/be12.cfg","./tools/schedsim/Hakefile","./tools/schedsim/be11.txt","./tools/schedsim/be12.txt","./tools/schedsim/be9.txt","./tools/schedsim/be6.cfg","./tools/schedsim/hrt4.txt","./tools/schedsim/be10.txt","./tools/schedsim/be4.txt","./tools/schedsim/be3.txt","./tools/schedsim/be2.txt","./tools/schedsim/be15.txt","./tools/schedsim/be15.cfg","./tools/schedsim/be5.cfg","./tools/schedsim/hrt0.cfg","./tools/schedsim/hrt2.cfg","./tools/schedsim/be16.txt","./tools/schedsim/be3.cfg","./tools/schedsim/be5.txt","./tools/schedsim/hrtbe1.txt","./tools/schedsim/hrtbe5.txt","./tools/schedsim/be1.cfg","./tools/schedsim/gang1.cfg","./tools/schedsim/be0.txt","./tools/schedsim/be9.cfg","./tools/schedsim/be14.txt","./tools/schedsim/gang0.cfg","./tools/schedsim/be13.txt","./tools/schedsim/be16.cfg","./tools/schedsim/gang0.txt","./tools/schedsim/be17.txt","./tools/schedsim/hrtbe5.cfg","./tools/schedsim/hrtbe4.txt","./tools/schedsim/be10.cfg","./tools/schedsim/gang2.txt","./tools/schedsim/be8.cfg","./tools/schedsim/hrt3.cfg","./tools/schedsim/be0.cfg","./tools/schedsim/hrtbe2.cfg","./tools/schedsim/be14.cfg","./tools/schedsim/hrt0.txt","./tools/schedsim/be1.txt","./tools/scc/bootscc.sh","./tools/scc/bootvector.map","./tools/scc/bigimage.map","./tools/scc/bootvector.dat","./tools/scc/watchall.sh","./tools/scc/barrelfish48.mt","./tools/arm_molly/Hakefile","./tools/arm_molly/molly_ld_script.in","./tools/arm_molly/molly_init.c","./tools/arm_molly/molly_boot.S","./tools/arm_molly/lib.c","./tools/fof/FutureWork.tex","./tools/fof/Makefile","./tools/fof/PureExpressions.lhs","./tools/fof/Introduction.tex","./tools/fof/Main.lhs","./tools/fof/Eval.lhs","./tools/fof/Expressions.lhs","./tools/fof/Constructs.lhs-boot","./tools/fof/Expressions.lhs-boot","./tools/fof/FiletOFish.bib","./tools/fof/IntroLanguage.tex","./tools/fof/FiletOFish.lhs","./tools/fof/Constructs.lhs","./tools/fof/Semantics.lhs","./tools/fof/Compile.lhs","./tools/fof/Libbarrelfish/HasDescendants.lhs","./tools/fof/Libbarrelfish/MemToPhys.lhs","./tools/fof/Libc/Printf.lhs","./tools/fof/Libc/Assert.lhs","./tools/fof/Constructs/References.lhs","./tools/fof/Constructs/Functions.lhs","./tools/fof/Constructs/Unions.lhs","./tools/fof/Constructs/Arrays.lhs","./tools/fof/Constructs/Enumerations.lhs","./tools/fof/Constructs/Conditionals.lhs","./tools/fof/Constructs/Typedef.lhs","./tools/fof/Constructs/Structures.lhs","./tools/fof/Constructs/Strings.lhs","./tools/fof/IL/Paka/Paka.lhs","./tools/fof/IL/Paka/Optimizer.lhs","./tools/fof/IL/Paka/Builders.lhs","./tools/fof/IL/Paka/Syntax.lhs","./tools/fof/IL/Paka/Compile.lhs","./tools/fof/IL/FoF/FoF.lhs","./tools/fof/IL/FoF/Run.lhs","./tools/fof/IL/FoF/Compile.lhs","./tools/harness/stats.py","./tools/harness/reprocess.py","./tools/harness/debug.py","./tools/harness/checkout.py","./tools/harness/scalebench.py","./tools/harness/results.py","./tools/harness/barrelfish.py","./tools/harness/harness.py","./tools/harness/README","./tools/harness/tests/spawntest.py","./tools/harness/tests/multihoptests.py","./tools/harness/tests/freemem.py","./tools/harness/tests/skew.py","./tools/harness/tests/__init__.py","./tools/harness/tests/memtest.py","./tools/harness/tests/echoserver.py","./tools/harness/tests/rpctests.py","./tools/harness/tests/perfmontest.py","./tools/harness/tests/tsctests.py","./tools/harness/tests/webserver.py","./tools/harness/tests/phases.py","./tools/harness/tests/channel_cost.py","./tools/harness/tests/nfscat.py","./tools/harness/tests/spantest.py","./tools/harness/tests/vmkit.py","./tools/harness/tests/monitortest.py","./tools/harness/tests/mdbbench.py","./tools/harness/tests/common.py","./tools/harness/tests/fputest.py","./tools/harness/tests/clockdrift.py","./tools/harness/tests/TimerTest.py","./tools/harness/tests/tracing.py","./tools/harness/tests/bulktests.py","./tools/harness/tests/bomp_sidebyside.py","./tools/harness/tests/splash_bomp.py","./tools/harness/tests/rcce.py","./tools/harness/siteconfig/__init__.py","./tools/harness/siteconfig/eth.py","./tools/harness/siteconfig/msrc.py","./tools/harness/machines/gem5.py","./tools/harness/machines/__init__.py","./tools/harness/machines/eth.py","./tools/harness/machines/msrc_machinedata.py","./tools/harness/machines/eth_machinedata.py","./tools/harness/machines/msrc.py","./tools/harness/machines/qemu.py","./tools/asmoffsets/Hakefile","./tools/asmoffsets/asmoffsets.c","./tools/fugu/Parser.hs","./tools/fugu/Makefile","./tools/fugu/Hakefile","./tools/fugu/Main.lhs","./tools/fugu/FuguBackend.lhs","./tools/molly/m5script.py","./tools/molly/molly_ld_script","./tools/molly/Hakefile","./tools/molly/molly_init.c","./tools/molly/molly_boot.S","./tools/flounder/Backend.lhs","./tools/flounder/Parser.hs","./tools/flounder/MsgBuf.hs","./tools/flounder/BackendCommon.hs","./tools/flounder/Multihop.hs","./tools/flounder/Arch.hs","./tools/flounder/RPCClient.hs","./tools/flounder/intro.tex","./tools/flounder/Hakefile","./tools/flounder/THCStubsBackend.hs","./tools/flounder/UMPCommon.hs","./tools/flounder/CSyntax.hs","./tools/flounder/UMP.hs","./tools/flounder/Main.lhs","./tools/flounder/THCBackend.hs","./tools/flounder/Syntax.lhs","./tools/flounder/GHBackend.hs","./tools/flounder/CAbsSyntax.hs","./tools/flounder/LMP.hs","./tools/flounder/MsgFragments.hs","./tools/flounder/UMP_IPI.hs","./tools/flounder/GCBackend.hs","./tools/flounder/Loopback.hs","./tools/flounder/AHCI.hs","./tools/flounder/notes.txt","./tools/flounder/tutorial.lhs","./tools/elver/boot.S","./tools/elver/Hakefile","./tools/elver/lib.c","./tools/elver/elver.c","./tools/mkrelease/executable_files","./tools/mkrelease/mkrelease.sh","./tools/mackerel/Space.hs","./tools/mackerel/RegisterTable.hs","./tools/mackerel/ShiftDriver.hs","./tools/mackerel/Hakefile","./tools/mackerel/Main.hs","./tools/mackerel/CSyntax.hs","./tools/mackerel/TypeTable.hs","./tools/mackerel/BitFieldDriver.hs","./tools/mackerel/BUGS.txt","./tools/mackerel/Checks.hs","./tools/mackerel/Attr.hs","./tools/mackerel/Poly.hs","./tools/mackerel/TypeName.hs","./tools/mackerel/CAbsSyntax.hs","./tools/mackerel/Fields.hs","./tools/mackerel/README.txt","./tools/mackerel/Dev.hs","./tools/mackerel/MackerelParser.hs","./tools/dite/elf32.c","./tools/dite/elf64.c","./tools/dite/Hakefile","./tools/dite/dite.c","./tools/dite/elf.h","./tools/hamlet/Parser.hs","./tools/hamlet/Hakefile","./tools/hamlet/Hamlet.lhs","./tools/hamlet/Main.lhs","./tools/hamlet/HamletBackend.lhs","./tools/hamlet/HamletAst.lhs","./tools/tools/.marker","./tools/tools/fugu/Parser.o","./tools/tools/fugu/Constructs.o-boot","./tools/tools/fugu/Eval.o","./tools/tools/fugu/Compile.o","./tools/tools/fugu/Compile.hi","./tools/tools/fugu/Expressions.o","./tools/tools/fugu/FuguBackend.hi","./tools/tools/fugu/Main.o","./tools/tools/fugu/Constructs.o","./tools/tools/fugu/Expressions.hi","./tools/tools/fugu/Eval.hi","./tools/tools/fugu/Constructs.hi-boot","./tools/tools/fugu/PureExpressions.hi","./tools/tools/fugu/PureExpressions.o","./tools/tools/fugu/FuguBackend.o","./tools/tools/fugu/Constructs.hi","./tools/tools/fugu/Expressions.hi-boot","./tools/tools/fugu/Main.hi","./tools/tools/fugu/Expressions.o-boot","./tools/tools/fugu/Semantics.hi","./tools/tools/fugu/Semantics.o","./tools/tools/fugu/Parser.hi","./tools/tools/fugu/Libbarrelfish/HasDescendants.o","./tools/tools/fugu/Libbarrelfish/MemToPhys.hi","./tools/tools/fugu/Libbarrelfish/HasDescendants.hi","./tools/tools/fugu/Libbarrelfish/MemToPhys.o","./tools/tools/fugu/Libc/Assert.o","./tools/tools/fugu/Libc/Printf.o","./tools/tools/fugu/Libc/Printf.hi","./tools/tools/fugu/Libc/Assert.hi","./tools/tools/fugu/Constructs/Typedef.hi","./tools/tools/fugu/Constructs/Unions.o","./tools/tools/fugu/Constructs/Strings.hi","./tools/tools/fugu/Constructs/References.hi","./tools/tools/fugu/Constructs/Typedef.o","./tools/tools/fugu/Constructs/Conditionals.o","./tools/tools/fugu/Constructs/Strings.o","./tools/tools/fugu/Constructs/Enumerations.hi","./tools/tools/fugu/Constructs/Enumerations.o","./tools/tools/fugu/Constructs/References.o","./tools/tools/fugu/Constructs/Arrays.hi","./tools/tools/fugu/Constructs/Functions.o","./tools/tools/fugu/Constructs/Arrays.o","./tools/tools/fugu/Constructs/Unions.hi","./tools/tools/fugu/Constructs/Conditionals.hi","./tools/tools/fugu/Constructs/Functions.hi","./tools/tools/fugu/Constructs/Structures.hi","./tools/tools/fugu/Constructs/Structures.o","./tools/tools/fugu/IL/Paka/Syntax.o","./tools/tools/fugu/IL/Paka/Builders.hi","./tools/tools/fugu/IL/Paka/Paka.hi","./tools/tools/fugu/IL/Paka/Optimizer.o","./tools/tools/fugu/IL/Paka/Compile.o","./tools/tools/fugu/IL/Paka/Compile.hi","./tools/tools/fugu/IL/Paka/Syntax.hi","./tools/tools/fugu/IL/Paka/Paka.o","./tools/tools/fugu/IL/Paka/Optimizer.hi","./tools/tools/fugu/IL/Paka/Builders.o","./tools/tools/fugu/IL/FoF/Run.hi","./tools/tools/fugu/IL/FoF/Compile.o","./tools/tools/fugu/IL/FoF/Compile.hi","./tools/tools/fugu/IL/FoF/FoF.o","./tools/tools/fugu/IL/FoF/FoF.hi","./tools/tools/fugu/IL/FoF/Run.o","./tools/demo/menu.demo.lst","./tools/demo/guide.pptx","./tools/demo/guide.pdf","./tools/demo/bin/Aquarium.exe","./tools/demo/bin/Aquarium.pdb","./tools/demo/bin/TestAquarium.exe","./tools/demo/TestAquarium/Program.cs","./tools/demo/TestAquarium/TestAquarium.csproj","./tools/demo/TestAquarium/Properties/AssemblyInfo.cs","./tools/demo/Aquarium/Events.cs","./tools/demo/Aquarium/Aquarium.csproj","./tools/demo/Aquarium/Window1.xaml.cs","./tools/demo/Aquarium/App.xaml.cs","./tools/demo/Aquarium/Key.xaml","./tools/demo/Aquarium/Key.xaml.cs","./tools/demo/Aquarium/barrelfish.png","./tools/demo/Aquarium/App.xaml","./tools/demo/Aquarium/Window1.xaml","./tools/demo/Aquarium/Dialogs.cs","./tools/demo/Aquarium/Properties/Resources.Designer.cs","./tools/demo/Aquarium/Properties/Resources.resx","./tools/demo/Aquarium/Properties/AssemblyInfo.cs","./tools/demo/Aquarium/Properties/Settings.settings","./tools/demo/Aquarium/Properties/Settings.Designer.cs","./tools/demo/Aquarium/Resources/barrelfish.ico","./tools/demo/logs/npc_1_1_0_8.5.log","./tools/demo/logs/span15.2.log","./tools/demo/logs/npc_1_1_1_8.3.log","./tools/demo/logs/demo.9.log","./tools/demo/logs/demo.6.log","./tools/demo/logs/npc_1_1_0_8_1.4.log","./tools/demo/logs/npc_1_1_1_8.6.log","./tools/demo/logs/npc_1_1_0_8.9.log","./tools/demo/logs/demo.5.log","./tools/demo/logs/npc_1_1_0_8.7.log","./tools/demo/logs/span15.9.log","./tools/demo/logs/span15.1.log","./tools/demo/logs/span15.0.log","./tools/demo/logs/npc_tput.6.log","./tools/demo/logs/bmp_bench.log","./tools/demo/logs/demo.4.log","./tools/demo/logs/npc_1_1_0_8_1.3.log","./tools/demo/logs/npc_tput.5.log","./tools/demo/logs/npc_1_1_1_8.1.log","./tools/demo/logs/demo.18.log","./tools/demo/logs/npc_1_1_0_8.6.log","./tools/demo/logs/span15.5.log","./tools/demo/logs/npc_1_1_0_8_1.1.log","./tools/demo/logs/demo.19.log","./tools/demo/logs/npc_1_1_1_8.8.log","./tools/demo/logs/npc_1_1_1_8.9.log","./tools/demo/logs/span15.8.log","./tools/demo/logs/demo.2.log","./tools/demo/logs/npc_tput.2.log","./tools/demo/logs/demo.17.log","./tools/demo/logs/npc_1_1_0_8.8.log","./tools/demo/logs/npc_1_1_1_8.5.log","./tools/demo/logs/demo.11.log","./tools/demo/logs/npc_tput.3.log","./tools/demo/logs/demo.8.log","./tools/demo/logs/span15.3.log","./tools/demo/logs/npc_tput.10.log","./tools/demo/logs/span15.7.log","./tools/demo/logs/npc_1_1_0_8.1.log","./tools/demo/logs/npc_1_1_1_8.7.log","./tools/demo/logs/npc_tput.8.log","./tools/demo/logs/npc_tput.9.log","./tools/demo/logs/demo.20.log","./tools/demo/logs/npc_tput.7.log","./tools/demo/logs/npc_1_1_0_8.0.log","./tools/demo/logs/npc_1_1_0_8_1.2.log","./tools/demo/logs/npc_tput.1.log","./tools/demo/logs/npc_1_1_1_8","./tools/demo/logs/demo.1.log","./tools/demo/logs/span15.6.log","./tools/demo/logs/npc_1_1_0_8_1.0.log","./tools/demo/logs/demo.12.log","./tools/demo/logs/npc_1_1_1_8.2.log","./tools/demo/logs/demo.13.log","./tools/demo/logs/demo.7.log","./tools/demo/logs/npc_tput.4.log","./tools/demo/logs/npc_1_1_0_8.3.log","./tools/demo/logs/demo.15.log","./tools/demo/logs/npc_1_1_0_8.2.log","./tools/demo/logs/demo.14.log","./tools/demo/logs/npc_1_1_1_8.4.log","./tools/demo/logs/demo.3.log","./tools/demo/logs/demo.16.log","./tools/demo/logs/npc_1_1_0_8.4.log","./tools/demo/logs/span15.4.log","./tools/demo/logs/demo.10.log","./errors/errno.fugu","./errors/Hakefile"];
hf = [
("./include/Hakefile", (let find fn arg = (fn allfiles "./include/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./include/Hakefile" a in
{-# LINE 1 "./include/Hakefile" #-}
--------------------------------------------------------------------------
-- Copyright (c) 2007-2011, ETH Zurich.
-- All rights reserved.
--
-- This file is distributed under the terms in the attached LICENSE file.
-- If you do not find this file, copies can be found by writing to:
-- ETH Zurich D-INFK, Haldeneggsteig 4, CH-8092 Zurich. Attn: Systems Group.
--
-- Hakefile for /include
-- 
--------------------------------------------------------------------------

[ includeFile (options arch) f
      | f <- [ 
   "cpiobin.h",
   "dlfcn.h",
   "multicast.h",
   "utime.h",
   "values.h",
   "x86emu.h",
   "zconf.h",
   "zlib.h"
  ], arch <- allArchitectures ]
)))),
("./hake/Hakefile", (let find fn arg = (fn allfiles "./hake/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./hake/Hakefile" a in
{-# LINE 1 "./hake/Hakefile" #-}
----------------------------------------------------------------------
-- Copyright (c) 2009, 2011, ETH Zurich.
-- All rights reserved.
--
-- This file is distributed under the terms in the attached LICENSE file.
-- If you do not find this file, copies can be found by writing to:
-- ETH Zurich D-INFK CAB F.78, Universitaetstr 6, CH-8092 Zurich. 
-- Attn: Systems Group.
--
-- Hakefile for /hake
--
----------------------------------------------------------------------

let
  hsInDir af tf dir = inDir af tf dir ".hs"
  hakesrc = find hsInDir "."
in
[ Rule ([ Str "ghc -O --make -XDeriveDataTypeable",
          Str "-package ghc",
          Str "-package ghc-paths",
          Str "-rtsopts=all",
          Str "-o", Out "hake" "/hake",
          Str "-outputdir", NoDep BuildTree "hake" "/",
          NStr "-i", NoDep SrcTree "src" "",
          NStr "-i", NoDep BuildTree "hake" "/",
          In SrcTree "src" "Main.hs",
          Dep InstallTree "" "Config.hs",
          Str "$(LDFLAGS)"
        ] 
        ++ [Dep SrcTree "src" f | f <- hakesrc] 
        ++ [NL, Str "rm", NoDep BuildTree "hake" "/ARMv5.o" ]),
  Rule [ Str "cp", 
         In SrcTree "src" "symbolic_targets.mk",
         Out "root" "symbolic_targets.mk" 
       ],

  -- copy default menu.lst file for the first architecture
  -- XXX: this should be per-platform, if hake knew about them
  Rule [ Str "cp -p -b ", In SrcTree "src" "menu.lst.$(word 1, $(HAKE_ARCHS))", Out "root" "menu.lst" ]
]
)))),
("./doc/008-tracing/Hakefile", (let find fn arg = (fn allfiles "./doc/008-tracing/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./doc/008-tracing/Hakefile" a in
{-# LINE 1 "./doc/008-tracing/Hakefile" #-}
----------------------------------------------------------------------
-- Copyright (c) 2010, ETH Zurich.
-- All rights reserved.
--
-- This file is distributed under the terms in the attached LICENSE file.
-- If you do not find this file, copies can be found by writing to:
-- ETH Zurich D-INFK, Haldeneggsteig 4, CH-8092 Zurich. Attn: Systems Group.
--
-- Hakefile for /doc/008-tracing
--
----------------------------------------------------------------------

[ buildTechNote "Tracing.tex" "TN-008-Tracing.pdf" False False [] ]
)))),
("./doc/002-mackerel/Hakefile", (let find fn arg = (fn allfiles "./doc/002-mackerel/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./doc/002-mackerel/Hakefile" a in
{-# LINE 1 "./doc/002-mackerel/Hakefile" #-}
----------------------------------------------------------------------
-- Copyright (c) 2010, ETH Zurich.
-- All rights reserved.
--
-- This file is distributed under the terms in the attached LICENSE file.
-- If you do not find this file, copies can be found by writing to:
-- ETH Zurich D-INFK, Universitaetstr. 6, CH-8092 Zurich. Attn: Systems Group.
--
-- Hakefile for /doc/002-mackerel
--
----------------------------------------------------------------------

[ buildTechNote "Mackerel.tex" "TN-002-Mackerel.pdf" False False [] ]
)))),
("./doc/011-idc/Hakefile", (let find fn arg = (fn allfiles "./doc/011-idc/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./doc/011-idc/Hakefile" a in
{-# LINE 1 "./doc/011-idc/Hakefile" #-}
----------------------------------------------------------------------
-- Copyright (c) 2010, ETH Zurich.
-- All rights reserved.
--
-- This file is distributed under the terms in the attached LICENSE file.
-- If you do not find this file, copies can be found by writing to:
-- ETH Zurich D-INFK, Universitaetstr. 6, CH-8092 Zurich. Attn: Systems Group.
--
-- Hakefile for /doc/011-idc
--
----------------------------------------------------------------------

[ buildTechNote "IDC.tex" "TN-011-IDC.pdf" True False ["figures/ump_bind"]
]
)))),
("./doc/010-spec/Hakefile", (let find fn arg = (fn allfiles "./doc/010-spec/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./doc/010-spec/Hakefile" a in
{-# LINE 1 "./doc/010-spec/Hakefile" #-}
----------------------------------------------------------------------
-- Copyright (c) 2010, ETH Zurich.
-- All rights reserved.
--
-- This file is distributed under the terms in the attached LICENSE file.
-- If you do not find this file, copies can be found by writing to:
-- ETH Zurich D-INFK, Universitaetstr. 6, CH-8092 Zurich. Attn: Systems Group.
--
-- Hakefile for /doc/010-spec
--
----------------------------------------------------------------------

let
    figoutput f = "/tmp/" ++ f ++ ".pdf"
    circo f = [ Str "circo", Str "-Tpdf",
                In SrcTree "src" (f ++ ".circo"), Str "-o", Out "tools" (figoutput f), NL ]
    dot f = [ Str "dot", Str "-Tpdf",
              In SrcTree "src" (f ++ ".dot"), Str "-o", Out "tools" (figoutput f), NL ]
in
  [ buildTechNoteWithDeps "Spec.tex" "TN-010-Spec.pdf" True False []
    (concat [dot "app_cspace", circo "disp_states_simple",
             dot "disp_states_simple_save_area_analysis", dot "init_cspace"]
    ++ [ Str "hg", Str "-R", NoDep SrcTree "src" "/",
         Str "log -l 1 --template 'Revision {rev} of {date|shortdate}\\n'",
         In SrcTree "src" "Spec.tex", Str ">", Out "tools" "/tmp/specdate.tex", NL ])
  ]
)))),
("./doc/000-overview/Hakefile", (let find fn arg = (fn allfiles "./doc/000-overview/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./doc/000-overview/Hakefile" a in
{-# LINE 1 "./doc/000-overview/Hakefile" #-}
----------------------------------------------------------------------
-- Copyright (c) 2010, ETH Zurich.
-- All rights reserved.
--
-- This file is distributed under the terms in the attached LICENSE file.
-- If you do not find this file, copies can be found by writing to:
-- ETH Zurich D-INFK, Universitaetstr. 6, CH-8092 Zurich. Attn: Systems Group.
--
-- Hakefile for /doc/000-overview
--
----------------------------------------------------------------------

[ buildTechNote "Overview.tex" "TN-000-Overview.pdf" False False
                    [ "cap_heirarchy", "cap_translation",
                      "dcb", "LMP", "os-arch", "UMP" ] 
]


  
)))),
("./doc/003-hake/Hakefile", (let find fn arg = (fn allfiles "./doc/003-hake/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./doc/003-hake/Hakefile" a in
{-# LINE 1 "./doc/003-hake/Hakefile" #-}
----------------------------------------------------------------------
-- Copyright (c) 2010, ETH Zurich.
-- All rights reserved.
--
-- This file is distributed under the terms in the attached LICENSE file.
-- If you do not find this file, copies can be found by writing to:
-- ETH Zurich D-INFK, Universitaetstr. 6, CH-8092 Zurich. Attn: Systems Group.
--
-- Hakefile for /doc/003-hake
--
----------------------------------------------------------------------

[ buildTechNote "Hake.tex" "TN-003-Hake.pdf" False False [] ]

)))),
("./doc/009-notifications/Hakefile", (let find fn arg = (fn allfiles "./doc/009-notifications/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./doc/009-notifications/Hakefile" a in
{-# LINE 1 "./doc/009-notifications/Hakefile" #-}
----------------------------------------------------------------------
-- Copyright (c) 2010, ETH Zurich.
-- All rights reserved.
--
-- This file is distributed under the terms in the attached LICENSE file.
-- If you do not find this file, copies can be found by writing to:
-- ETH Zurich D-INFK, Universitaetstr. 6, CH-8092 Zurich. Attn: Systems Group.
--
-- Hakefile for /doc/009-notifications
--
----------------------------------------------------------------------

[ buildTechNote "Notify.tex" "TN-009-Notifications.pdf" False False
                    [ "umpnotify" ] 
]

)))),
("./doc/013-capability-mgmt/Hakefile", (let find fn arg = (fn allfiles "./doc/013-capability-mgmt/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./doc/013-capability-mgmt/Hakefile" a in
{-# LINE 1 "./doc/013-capability-mgmt/Hakefile" #-}
----------------------------------------------------------------------
-- Copyright (c) 2010, ETH Zurich.
-- All rights reserved.
--
-- This file is distributed under the terms in the attached LICENSE file.
-- If you do not find this file, copies can be found by writing to:
-- ETH Zurich D-INFK, Universitaetstr. 6, CH-8092 Zurich. Attn: Systems Group.
--
-- Hakefile for /doc/004-virtual_memory
--
----------------------------------------------------------------------

let
  figoutput f = "/tmp/" ++ f ++ ".pdf"
  dot f = [ Str "dot", Str "-Tpdf",
            In SrcTree "src" (f ++ ".dot"), Str "-o", Out "tools" (figoutput f), NL ]
  in
 [ buildTechNoteWithDeps "CapMgmt.tex" "TN-013-CapabilityManagement.pdf" True False [] 
   (concat [dot "cap_types"])
 ]

)))),
("./doc/014-bulk-transfer/Hakefile", (let find fn arg = (fn allfiles "./doc/014-bulk-transfer/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./doc/014-bulk-transfer/Hakefile" a in
{-# LINE 1 "./doc/014-bulk-transfer/Hakefile" #-}
----------------------------------------------------------------------
-- Copyright (c) 2010, ETH Zurich.
-- All rights reserved.
--
-- This file is distributed under the terms in the attached LICENSE file.
-- If you do not find this file, copies can be found by writing to:
-- ETH Zurich D-INFK, Universitaetstr. 6, CH-8092 Zurich. Attn: Systems Group.
--
-- Hakefile for /doc/014-bulk-transfer
--
----------------------------------------------------------------------

[ buildTechNote "bulk-transfer.tex" "TN-014-bulk-transfer.pdf" False False [] ]

)))),
("./doc/005-scc/Hakefile", (let find fn arg = (fn allfiles "./doc/005-scc/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./doc/005-scc/Hakefile" a in
{-# LINE 1 "./doc/005-scc/Hakefile" #-}
----------------------------------------------------------------------
-- Copyright (c) 2010, ETH Zurich.
-- All rights reserved.
--
-- This file is distributed under the terms in the attached LICENSE file.
-- If you do not find this file, copies can be found by writing to:
-- ETH Zurich D-INFK, Universitaetstr. 6, CH-8092 Zurich. Attn: Systems Group.
--
-- Hakefile for /doc/005-scc
--
----------------------------------------------------------------------

[ buildTechNote "SCC.tex" "TN-005-SCC.pdf" True False
                    [ "figures/exp1", "figures/exp2",
                      "plots/mpbbench/mpbbench_oneway", 
                      "plots/rcce_bench/rcce_bt",
                      "plots/rcce_bench/rcce_bt_speedup",
                      "plots/rcce_bench/rcce_lu",
                      "plots/rcce_bench/rcce_lu_speedup" ]
]
)))),
("./doc/015-disk-driver-arch/Hakefile", (let find fn arg = (fn allfiles "./doc/015-disk-driver-arch/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./doc/015-disk-driver-arch/Hakefile" a in
{-# LINE 1 "./doc/015-disk-driver-arch/Hakefile" #-}
----------------------------------------------------------------------
-- Copyright (c) 2010, ETH Zurich.
-- All rights reserved.
--
-- This file is distributed under the terms in the attached LICENSE file.
-- If you do not find this file, copies can be found by writing to:
-- ETH Zurich D-INFK, Universitaetstr. 6, CH-8092 Zurich. Attn: Systems Group.
--
-- Hakefile for /doc/015-disk-driver-arch
--
----------------------------------------------------------------------

let
  svg_sources = [ "architecture", "blockdevfs_list",
                  "cache_design", "dma_pool_design", "fat16_layout",
                  "fat32_layout", "fillbench", "h2d_fis", "mmap",
                  "pmem_overview", "rfis_area" ]

  figoutput f = "/tmp/" ++ f ++ ".pdf"

  -- Fix issues with modified LD_LIBRARY_PATH breaking inkscape, -SG, 9/1/13
  inkscape f = [ Str "LD_LIBRARY_PATH=", Str "inkscape", Str "-D", Str "-A",
                 Out "tools" (figoutput f), In SrcTree "src" ("figures/" ++ f ++ ".svg"), NL ]
  in 
 [ buildTechNoteWithDeps "disk-driver-report.tex" "TN-015-DiskDriverArchitecture.pdf" True True
   [] (concat [ inkscape f | f <- svg_sources ])
 ]

)))),
("./doc/001-glossary/Hakefile", (let find fn arg = (fn allfiles "./doc/001-glossary/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./doc/001-glossary/Hakefile" a in
{-# LINE 1 "./doc/001-glossary/Hakefile" #-}
----------------------------------------------------------------------
-- Copyright (c) 2010, ETH Zurich.
-- All rights reserved.
--
-- This file is distributed under the terms in the attached LICENSE file.
-- If you do not find this file, copies can be found by writing to:
-- ETH Zurich D-INFK, Universitaetstr. 6, CH-8092 Zurich. Attn: Systems Group.
--
-- Hakefile for /doc/001-glossary
--
----------------------------------------------------------------------

[ buildTechNoteWithDeps "Glossary.tex" "TN-001-Glossary.pdf" False False []
                            [ Str "runghc", In SrcTree "src" "Main.hs", Str ">", 
                              Out "tools" "/tmp/gloss-from-haskell.tex", NL ]
]
)))),
("./doc/004-virtual_memory/Hakefile", (let find fn arg = (fn allfiles "./doc/004-virtual_memory/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./doc/004-virtual_memory/Hakefile" a in
{-# LINE 1 "./doc/004-virtual_memory/Hakefile" #-}
----------------------------------------------------------------------
-- Copyright (c) 2010, ETH Zurich.
-- All rights reserved.
--
-- This file is distributed under the terms in the attached LICENSE file.
-- If you do not find this file, copies can be found by writing to:
-- ETH Zurich D-INFK, Universitaetstr. 6, CH-8092 Zurich. Attn: Systems Group.
--
-- Hakefile for /doc/004-virtual_memory
--
----------------------------------------------------------------------

[ buildTechNote "VirtualMemory.tex" "TN-004-VirtualMemory.pdf" False False [] ]

)))),
("./doc/016-serial-ports/Hakefile", (let find fn arg = (fn allfiles "./doc/016-serial-ports/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./doc/016-serial-ports/Hakefile" a in
{-# LINE 1 "./doc/016-serial-ports/Hakefile" #-}
----------------------------------------------------------------------
-- Copyright (c) 2012, ETH Zurich.
-- All rights reserved.
--
-- This file is distributed under the terms in the attached LICENSE file.
-- If you do not find this file, copies can be found by writing to:
-- ETH Zurich D-INFK, Universitaetstr. 6, CH-8092 Zurich. Attn: Systems Group.
--
-- Hakefile for /doc/016-serial-ports
--
----------------------------------------------------------------------

[ buildTechNote "Serial.tex" "TN-016-Serial.pdf" False False [] ]
)))),
("./doc/012-services/Hakefile", (let find fn arg = (fn allfiles "./doc/012-services/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./doc/012-services/Hakefile" a in
{-# LINE 1 "./doc/012-services/Hakefile" #-}
----------------------------------------------------------------------
-- Copyright (c) 2010, ETH Zurich.
-- All rights reserved.
--
-- This file is distributed under the terms in the attached LICENSE file.
-- If you do not find this file, copies can be found by writing to:
-- ETH Zurich D-INFK, Universitaetstr. 6, CH-8092 Zurich. Attn: Systems Group.
--
-- Hakefile for /doc/012-services
--
----------------------------------------------------------------------

[ buildTechNote "Services.tex" "TN-012-Services.pdf" False False [] ]
--                    [ "cap_heirarchy", "cap_translation",
--                      "dcb", "LMP", "os-arch", "UMP" ] 
--]


  
)))),
("./doc/006-routing/Hakefile", (let find fn arg = (fn allfiles "./doc/006-routing/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./doc/006-routing/Hakefile" a in
{-# LINE 1 "./doc/006-routing/Hakefile" #-}
----------------------------------------------------------------------
-- Copyright (c) 2010, ETH Zurich.
-- All rights reserved.
--
-- This file is distributed under the terms in the attached LICENSE file.
-- If you do not find this file, copies can be found by writing to:
-- ETH Zurich D-INFK, Universitaetstr. 6, CH-8092 Zurich. Attn: Systems Group.
--
-- Hakefile for /doc/006-routing
--
----------------------------------------------------------------------

[ buildTechNote "Routing.tex" "TN-006-Routing.pdf" True False
                    [ "client-monitor", 
                      "client-server", 
                      "many-to-many" ]
]
)))),
("./usr/init/Hakefile", (let find fn arg = (fn allfiles "./usr/init/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./usr/init/Hakefile" a in
{-# LINE 1 "./usr/init/Hakefile" #-}
--------------------------------------------------------------------------
-- Copyright (c) 2007-2009, ETH Zurich.
-- All rights reserved.
--
-- This file is distributed under the terms in the attached LICENSE file.
-- If you do not find this file, copies can be found by writing to:
-- ETH Zurich D-INFK, Haldeneggsteig 4, CH-8092 Zurich. Attn: Systems Group.
--
-- Hakefile for /usr/init
--
--------------------------------------------------------------------------

[ build application { target = "init",
                      assemblyFiles = [ "syscall/syscall.S" ],
  		      cFiles = [ "main.c",
                                 "init.c",
                                 "syscall/syscalls.c",
                                 "libc_glue/debug_printf.c",
                                 "libc_glue/morecore.c"
                               ],
                      addLinkFlags = [ "-e _start_init"],
                      addIncludes = [ "include" ],
		      architectures = allArchitectures
                    }
]
)))),
("./lib/collections/Hakefile", (let find fn arg = (fn allfiles "./lib/collections/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./lib/collections/Hakefile" a in
{-# LINE 1 "./lib/collections/Hakefile" #-}
--------------------------------------------------------------------------
-- Copyright (c) 2007-2009, ETH Zurich.
-- All rights reserved.
--
-- This file is distributed under the terms in the attached LICENSE file.
-- If you do not find this file, copies can be found by writing to:
-- ETH Zurich D-INFK, Haldeneggsteig 4, CH-8092 Zurich. Attn: Systems Group.
--
-- Hakefile for lib/concurrent
-- 
--------------------------------------------------------------------------

[ build library { target = "collections",
                  cFiles = [ "list.c", "hash_table.c", "stack.c",
                             "flipbuffer.c" ]
                }
]
)))),
("./lib/procon/Hakefile", (let find fn arg = (fn allfiles "./lib/procon/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./lib/procon/Hakefile" a in
{-# LINE 1 "./lib/procon/Hakefile" #-}
--------------------------------------------------------------------------
-- Copyright (c) 2007-2011, ETH Zurich.
-- All rights reserved.
--
-- This file is distributed under the terms in the attached LICENSE file.
-- If you do not find this file, copies can be found by writing to:
-- ETH Zurich D-INFK, Haldeneggsteig 4, CH-8092 Zurich. Attn: Systems Group.
--
-- Hakefile for lib/procon
--
--------------------------------------------------------------------------

[ build library { target = "procon",
                  cFiles = [ "procon.c"]
                }
]
)))),
("./lib/newlib/Hakefile", (let find fn arg = (fn allfiles "./lib/newlib/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./lib/newlib/Hakefile" a in
{-# LINE 1 "./lib/newlib/Hakefile" #-}
if Config.libc == "newlib" then
[ build library { 
  target = "newlib",
  addLibraries = [ "newlib_" ]
   }
]
else []
)))),
("./lib/newlib/newlib/Hakefile", (let find fn arg = (fn allfiles "./lib/newlib/newlib/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./lib/newlib/newlib/Hakefile" a in
{-# LINE 1 "./lib/newlib/newlib/Hakefile" #-}
if Config.libc == "newlib" then
[ build library { 
  target = "newlib_",
  addLibraries = [ "newc", "m" ]
   }
]
else []
)))),
("./lib/newlib/newlib/libc/Hakefile", (let find fn arg = (fn allfiles "./lib/newlib/newlib/libc/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./lib/newlib/newlib/libc/Hakefile" a in
{-# LINE 1 "./lib/newlib/newlib/libc/Hakefile" #-}
if Config.libc == "newlib" then
let
    arch_srcs "x86_64"  = [ "machine/x86_64/" ++ x | x <- ["setjmp.S", "memcpy.S", "memset.S"]]
    arch_srcs "x86_32"  = [ "machine/i386/" ++ x   | x <- ["setjmp.S", "memcpy.S", "memset.S"]]
    arch_srcs "scc"     = [ "machine/i386/" ++ x   | x <- ["setjmp.S", "memcpy.S", "memset.S"]]
    arch_srcs "armv5"   = [ "machine/arm/setjmp.S" ]
    arch_srcs "arm11mp" = [ "machine/arm/setjmp.S" ]
    arch_srcs "xscale"  = [ "machine/arm/setjmp.S" ]
    arch_srcs "armv7"   = [ "machine/arm/setjmp.S" ]
    arch_srcs  x        = error ("Unknown architecture for newlib: " ++ x)
in
[ build library {
  target = "newc",
  addCFlags  = Config.newlibAddCFlags,
  omitCFlags = [ "-Wmissing-prototypes",
                 "-Wmissing-declarations",
                 "-Wimplicit-function-declaration",
                 "-Werror"],
  addLibraries = [
      "ctype"
    , "search"
    , "string"
    , "argz"
    , "stdlib"
    , "stdio"
--  , "signal"
    , "time"
    , "locale"
    , "reent"
    , "errno"
    , "misc"
    , "sys" ],
  cFiles = arch_srcs arch,
  architectures = [arch]
} | arch <- allArchitectures ]
else []
)))),
("./lib/newlib/newlib/libc/locale/Hakefile", (let find fn arg = (fn allfiles "./lib/newlib/newlib/libc/locale/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./lib/newlib/newlib/libc/locale/Hakefile" a in
{-# LINE 1 "./lib/newlib/newlib/libc/locale/Hakefile" #-}
if Config.libc == "newlib" then [ build library {
  target = "locale",
  cFiles = [
    "locale.c",
    "fix_grouping.c",
    "ldpart.c",
    "lmessages.c",
    "lnumeric.c",
    "lmonetary.c",
    "nl_langinfo.c",
    "timelocal.c",
    "lctype.c" ],
  addCFlags = Config.newlibAddCFlags,
  omitCFlags = [ "-Wmissing-prototypes",
                 "-Wmissing-declarations",
                 "-Wimplicit-function-declaration",
                 "-Werror" ]
}] else []
)))),
("./lib/newlib/newlib/libc/stdio/Hakefile", (let find fn arg = (fn allfiles "./lib/newlib/newlib/libc/stdio/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./lib/newlib/newlib/libc/stdio/Hakefile" a in
{-# LINE 1 "./lib/newlib/newlib/libc/stdio/Hakefile" #-}
let
  common_cflags = Config.newlibAddCFlags
  common_omitcflags = [
        "-std=c99",
        "-Wredundant-decls",
        "-Wmissing-prototypes",
        "-Wmissing-declarations",
        "-Wimplicit-function-declaration",
        "-Werror" ]
in
  if Config.libc == "newlib" then
  [
    build library {
      target = "stdio_si",
      cFiles = [ "svfiprintf.c", "svfiscanf.c", "svfiwprintf.c", "svfiwscanf.c"  ],
      addCFlags = common_cflags ++ [ "-DINTEGER_ONLY", "-DSTRING_ONLY" ],
      omitCFlags = common_omitcflags
    },

    build library {
      target = "stdio_i",
      cFiles = [ "vfiprintf.c", "vfiscanf.c", "vfiwprintf.c", "vfiwscanf.c"  ],
      addCFlags = common_cflags ++ [ "-DINTEGER_ONLY" ],
      omitCFlags = common_omitcflags
    },

    build library {
      target = "stdio_s",
      cFiles = [ "svfprintf.c", "svfscanf.c", "svfwprintf.c", "svfwscanf.c"  ],
      addCFlags = common_cflags ++ [ "-DSTRING_ONLY" ],
      omitCFlags = common_omitcflags
    },

    build library {
      target = "stdio",
      cFiles = [
      "clearerr.c",
      "fclose.c",
      "fdopen.c",
      "feof.c",
      "ferror.c",
      "fflush.c",
      "fgetc.c",
      "fgetpos.c",
      "fgets.c",
      "fileno.c",
      --"findfp.c",
      "fiprintf.c",
      "flags.c",
      "fopen.c",
      "fprintf.c",
      "fputc.c",
      "fputs.c",
      "fread.c",
      "freopen.c",
      "fscanf.c",
      "fiscanf.c",
      "fseek.c",
      "fsetpos.c",
      "ftell.c",
      "fvwrite.c",
      "fwalk.c",
      "fwrite.c",
      "getc.c",
      "getchar.c",
      "getc_u.c",
      "getchar_u.c",
      "getdelim.c",
      "getline.c",
      "gets.c",
      "iprintf.c",
      "iscanf.c",
      "makebuf.c",
      "perror.c",
      "printf.c",
      "putc.c",
      "putchar.c",
      "putc_u.c",
      "putchar_u.c",
      "puts.c",
      "refill.c",
      "remove.c",
      "rename.c",
      "rewind.c",
      "rget.c",
      "scanf.c",
      "sccl.c",
      "setbuf.c",
      "setbuffer.c",
      "setlinebuf.c",
      "setvbuf.c",
      "siprintf.c",
      "siscanf.c",
      "sniprintf.c",
      "snprintf.c",
      "sprintf.c",
      "sscanf.c",
      "stdio.c",
      "tmpfile.c",
      "tmpnam.c",
      "ungetc.c",
      "vdiprintf.c",
      "vdprintf.c",
      "viprintf.c",
      "viscanf.c",
      "vprintf.c",
      "vscanf.c",
      "vsiprintf.c",
      "vsiscanf.c",
      "vsnprintf.c",
      "vsniprintf.c",
      "vsprintf.c",
      "vsscanf.c",
      "wbuf.c",
      "wsetup.c",
      "asiprintf.c",
      "asprintf.c",
      "fcloseall.c",
      "fseeko.c",
      "ftello.c",
      "getw.c",
      "mktemp.c",
      "putw.c",
      "vasiprintf.c",
      "vasprintf.c",
      "asniprintf.c",
      "asnprintf.c",
      "diprintf.c",
      "dprintf.c",
      "fgetwc.c",
      "fgetws.c",
      "fmemopen.c",
      "fopencookie.c",
      "fpurge.c",
      "fputwc.c",
      "fputws.c",
      "funopen.c",
      "fwide.c",
      "fwprintf.c",
      "fwscanf.c",
      "getwc.c",
      "getwchar.c",
      "open_memstream.c",
      "putwc.c",
      "putwchar.c",
      "swprintf.c",
      "swscanf.c",
      "ungetwc.c",
      "vasniprintf.c",
      "vasnprintf.c",
      "vswprintf.c",
      "vswscanf.c",
      "vwprintf.c",
      "vwscanf.c",
      "wprintf.c",
      "wscanf.c",
      "vfwscanf.c", "vfscanf.c", "vfprintf.c", "vfwprintf.c"
    ],
    addCFlags = common_cflags,
    addLibraries = [ "stdio_si", "stdio_s", "stdio_i" ],
    omitCFlags = common_omitcflags
  }
]
else []
)))),
("./lib/newlib/newlib/libc/string/Hakefile", (let find fn arg = (fn allfiles "./lib/newlib/newlib/libc/string/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./lib/newlib/newlib/libc/string/Hakefile" a in
{-# LINE 1 "./lib/newlib/newlib/libc/string/Hakefile" #-}
if Config.libc == "newlib" then [ build library {
  target = "string",
  cFiles = [
    "bcopy.c",
    "bzero.c",
    "index.c",
    "memchr.c",
    "memcmp.c",
    "memcpy.c",
    "memmove.c",
    "memset.c",
    "rindex.c",
    "strcasecmp.c",
    "strcat.c",
    "strchr.c",
    "strcmp.c",
    "strcoll.c",
    "strcpy.c",
    "strcspn.c",
    "strdup.c",
    "strdup_r.c",
    "strerror.c",
    "strerror_r.c",
    "strlcat.c",
    "strlcpy.c",
    "strlen.c",
    "strlwr.c",
    "strncasecmp.c",
    "strncat.c",
    "strncmp.c",
    "strncpy.c",
    "strnlen.c",
    "strpbrk.c",
    "strrchr.c",
    "strsep.c",
    "strsignal.c",
    "strspn.c",
    "strtok.c",
    "strtok_r.c",
    "strupr.c",
    "strxfrm.c",
    "strstr.c",
    "swab.c",
    "u_strerr.c",
    "wcscat.c",
    "wcschr.c",
    "wcscmp.c",
    "wcscoll.c",
    "wcscpy.c",
    "wcscspn.c",
    "wcslcat.c",
    "wcslcpy.c",
    "wcslen.c",
    "wcsncat.c",
    "wcsncmp.c",
    "wcsncpy.c",
    "wcsnlen.c",
    "wcspbrk.c",
    "wcsrchr.c",
    "wcsspn.c",
    "wcsstr.c",
    "wcstok.c",
    "wcswidth.c",
    "wcsxfrm.c",
    "wcwidth.c",
    "wmemchr.c",
    "wmemcmp.c",
    "wmemcpy.c",
    "wmemmove.c",
    "wmemset.c",
    "bcmp.c",
    "memccpy.c",
    "mempcpy.c",
    "stpcpy.c",
    "stpncpy.c",
    "strndup.c",
    "strcasestr.c",
    "strndup_r.c",
    "wcpcpy.c",
    "wcpncpy.c",
    "wcsdup.c",
    "memmem.c",
    "wcscasecmp.c",
    "wcsncasecmp.c"],
  addCFlags = Config.newlibAddCFlags,
  omitCFlags = [ "-Wmissing-prototypes",
                 "-Wmissing-declarations",
                 "-Wimplicit-function-declaration",
                 "-Werror" ]
}] else []
)))),
("./lib/newlib/newlib/libc/signal/Hakefile", (let find fn arg = (fn allfiles "./lib/newlib/newlib/libc/signal/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./lib/newlib/newlib/libc/signal/Hakefile" a in
{-# LINE 1 "./lib/newlib/newlib/libc/signal/Hakefile" #-}
if Config.libc == "newlib" then [ build library {
  target     = "signal",
  cFiles     = [ "raise.c", "signal.c" ],
  addCFlags  = Config.newlibAddCFlags,
  omitCFlags = [ "-Wmissing-prototypes",
                 "-Wmissing-declarations",
                 "-Wimplicit-function-declaration",
                 "-Werror" ]
} ] else []
)))),
("./lib/newlib/newlib/libc/misc/Hakefile", (let find fn arg = (fn allfiles "./lib/newlib/newlib/libc/misc/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./lib/newlib/newlib/libc/misc/Hakefile" a in
{-# LINE 1 "./lib/newlib/newlib/libc/misc/Hakefile" #-}
if Config.libc == "newlib" then [ build library {
  target = "misc",
  cFiles = [
          "__dprintf.c",
          "unctrl.c",
          "ffs.c",
          "init.c",
          "fini.c"
        ],
  addCFlags = Config.newlibAddCFlags,
  omitCFlags = [ "-Wmissing-prototypes",
                 "-Wmissing-declarations",
                 "-Wimplicit-function-declaration",
                 "-Werror" ]
} ] else []
)))),
("./lib/newlib/newlib/libc/stdlib/Hakefile", (let find fn arg = (fn allfiles "./lib/newlib/newlib/libc/stdlib/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./lib/newlib/newlib/libc/stdlib/Hakefile" a in
{-# LINE 1 "./lib/newlib/newlib/libc/stdlib/Hakefile" #-}
let
  malloc_provided = case Config.newlib_malloc of
    "sbrk"      -> False
    "dlmalloc"  -> True
    "oldmalloc" -> True
  common_cflags = Config.newlibAddCFlags
                  ++ if malloc_provided then ["-DMALLOC_PROVIDED"] else []
  common_omitcflags = [ "-std=c99",
                        "-Wredundant-decls",
                        "-Wmissing-prototypes",
                        "-Wmissing-declarations",
                        "-Wimplicit-function-declaration",
                        "-Werror" ]
in
  if Config.libc == "newlib" then
  [
    build library {
      target = "stdlib_free",
      cFiles = [ "freer.c" ],
      addCFlags = common_cflags ++ [ "-DINTERNAL_NEWLIB", "-DDEFINE_FREE" ],
      omitCFlags = common_omitcflags
    },

    build library {
      target = "stdlib_realloc",
      cFiles = [ "reallocr.c" ],
      addCFlags = common_cflags ++ [ "-DINTERNAL_NEWLIB", "-DDEFINE_REALLOC" ],
      omitCFlags = common_omitcflags
    },

    build library {
      target = "stdlib_calloc",
      cFiles = [ "callocr.c" ],
      addCFlags = common_cflags ++ [ "-DINTERNAL_NEWLIB", "-DDEFINE_CALLOC" ],
      omitCFlags = common_omitcflags
    },

    build library {
      target = "stdlib_cfree",
      cFiles = [ "cfreer.c" ],
      addCFlags = common_cflags ++ [ "-DINTERNAL_NEWLIB", "-DDEFINE_CFREE" ],
      omitCFlags = common_omitcflags
    },

    build library {
      target = "stdlib_mallinfo",
      cFiles = [ "mallinfor.c" ],
      addCFlags = common_cflags ++ [ "-DINTERNAL_NEWLIB", "-DDEFINE_MALLINFO" ],
      omitCFlags = common_omitcflags
    },

    build library {
      target = "stdlib_mallstats",
      cFiles = [ "mallstatsr.c" ],
      addCFlags = common_cflags ++ [ "-DINTERNAL_NEWLIB", "-DDEFINE_MALLOC_STATS" ],
      omitCFlags = common_omitcflags
    },

    build library {
      target = "stdlib_msize",
      cFiles = [ "msizer.c" ],
      addCFlags = common_cflags ++ [ "-DINTERNAL_NEWLIB", "-DDEFINE_MALLOC_USABLE_SIZE" ],
      omitCFlags = common_omitcflags
    },

    build library {
      target = "stdlib_malloc",
      cFiles = [ "mallocr.c" ],
      addCFlags = common_cflags ++ [ "-DINTERNAL_NEWLIB", "-DDEFINE_MALLOC" ],
      omitCFlags = common_omitcflags
    },

    build library {
      target = "stdlib_malign",
      cFiles = [ "malignr.c" ],
      addCFlags = common_cflags ++ [ "-DINTERNAL_NEWLIB", "-DDEFINE_MEMALIGN" ],
      omitCFlags = common_omitcflags
    },

    build library {
      target = "stdlib_mallopt",
      cFiles = [ "malloptr.c" ],
      addCFlags = common_cflags ++ [ "-DINTERNAL_NEWLIB", "-DDEFINE_MALLOPT" ],
      omitCFlags = common_omitcflags
    },

    build library {
      target = "stdlib_pvalloc",
      cFiles = [ "pvallocr.c" ],
      addCFlags = common_cflags ++ [ "-DINTERNAL_NEWLIB", "-DDEFINE_PVALLOC" ],
      omitCFlags = common_omitcflags
    },

    build library {
      target = "stdlib_valloc",
      cFiles = [ "vallocr.c" ],
      addCFlags = common_cflags ++ [ "-DINTERNAL_NEWLIB", "-DDEFINE_VALLOC" ],
      omitCFlags = common_omitcflags
    },

    build library {
      target = "stdlib",
      cFiles = [
        "__adjust.c" ,
        "__atexit.c" ,
        "__call_atexit.c" ,
        "__exp10.c" ,
        "__ten_mu.c" ,
        --"_Exit.c" ,
        --"abort.c" ,
        "abs.c" ,
        "assert.c" ,
        "atexit.c" ,
        "atof.c" ,
        "atoff.c" ,
        "atoi.c" ,
        "atol.c" ,
        "calloc.c" ,
        "div.c" ,
        "dtoa.c" ,
        "dtoastub.c" ,
        "environ.c" ,
        "envlock.c" ,
        "eprintf.c" ,
        "exit.c" ,
        "gdtoa-gethex.c" ,
        "gdtoa-hexnan.c" ,
        "getenv.c" ,
        "getenv_r.c" ,
        "labs.c" ,
        "ldiv.c" ,
        "ldtoa.c",
        "malloc.c",
        "mblen.c",
        "mblen_r.c",
        "mbstowcs.c",
        "mbstowcs_r.c",
        "mbtowc.c",
        "mbtowc_r.c",
        "mlock.c",
        "mprec.c",
        "mstats.c",
        "rand.c",
        "rand_r.c",
        "realloc.c",
        "reallocf.c",
        "sb_charsets.c",
        "strtod.c",
        "strtol.c",
        "strtoul.c",
        "wcstod.c",
        "wcstol.c",
        "wcstoul.c",
        "wcstombs.c",
        "wcstombs_r.c",
        "wctomb.c",
        "wctomb_r.c",
        "strtold.c",
        "wcstold.c",
        "cxa_atexit.c",
        "cxa_finalize.c",
        "drand48.c",
        "ecvtbuf.c",
        "efgcvt.c",
        "erand48.c",
        "jrand48.c",
        "lcong48.c",
        "lrand48.c",
        "mrand48.c",
        "msize.c",
        "mtrim.c",
        "nrand48.c",
        "rand48.c",
        "seed48.c",
        "srand48.c",
        "strtoll.c",
        "strtoll_r.c",
        "strtoull.c",
        "strtoull_r.c",
        "wcstoll.c",
        "wcstoll_r.c",
        "wcstoull.c",
        "wcstoull_r.c",
        "atoll.c",
        "llabs.c",
        "lldiv.c",
        "a64l.c",
        "btowc.c",
        "getopt.c",
        "getsubopt.c",
        "l64a.c",
        "malign.c",
        "mbrlen.c",
        "mbrtowc.c",
        "mbsinit.c",
        "mbsnrtowcs.c",
        "mbsrtowcs.c",
        "on_exit.c",
        "valloc.c",
        "wcrtomb.c",
        "wcsnrtombs.c",
        "wcsrtombs.c",
        "wctob.c",
        "putenv.c",
        "putenv_r.c",
        "setenv.c",
        "setenv_r.c"
        --"system.c"
        ],
      addCFlags = common_cflags,
      addLibraries = [ "stdlib_free", "stdlib_realloc", "stdlib_calloc", "stdlib_cfree", "stdlib_mallinfo", "stdlib_mallstats", "stdlib_msize", "stdlib_malloc", "stdlib_malign", "stdlib_mallopt", "stdlib_pvalloc", "stdlib_valloc" ],
      omitCFlags = common_omitcflags
    } ]
else []
)))),
("./lib/newlib/newlib/libc/reent/Hakefile", (let find fn arg = (fn allfiles "./lib/newlib/newlib/libc/reent/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./lib/newlib/newlib/libc/reent/Hakefile" a in
{-# LINE 1 "./lib/newlib/newlib/libc/reent/Hakefile" #-}
if Config.libc == "newlib" then
let
    sbrk_files = case Config.newlib_malloc of
     "sbrk"      -> ["sbrkr.c"]
     "dlmalloc"  -> []
     "oldmalloc" -> []
in
[ build library {
  target = "reent",
  cFiles = [
    "reent.c",
    "impure.c",
    --"fcntlr.c",
    "getreent.c"
    --"gettimeofdayr.c",
    --"isattyr.c",
    --"linkr.c",
    --"mkdirr.c",
    --"renamer.c",
    --"signalr.c",
    --"signgam.c",
    --"sbrkr.c"
    --"statr.c",
    --"timesr.c"
    --"openr.c",
    --"fstatr.c",
    --"unlinkr.c",
    --"lseekr.c",
    --"writer.c",
    --"closer.c",
    --"readr.c",
    --"execr.c"
   ] ++ sbrk_files,
    addCFlags = Config.newlibAddCFlags,
    omitCFlags = [ "-Wmissing-prototypes",
                   "-Wmissing-declarations",
                   "-Wimplicit-function-declaration",
                   "-Werror"]
}] else []
)))),
("./lib/newlib/newlib/libc/sys/barrelfish/Hakefile", (let find fn arg = (fn allfiles "./lib/newlib/newlib/libc/sys/barrelfish/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./lib/newlib/newlib/libc/sys/barrelfish/Hakefile" a in
{-# LINE 1 "./lib/newlib/newlib/libc/sys/barrelfish/Hakefile" #-}
if Config.libc == "newlib" then
let
    -- selection of malloc() implementation.
    -- Note that the default is "oldmalloc", and the other two options are (in
    -- the time of this writting) problematic:
    --   - "sbrk" uses sbrk() system call and does not return memory to the OS
    --   - "dlmalloc" does not seem to be work for low-level services like the memory allocator
    malloc_files = case Config.newlib_malloc of
        "dlmalloc"  -> ["dlmalloc.c", "mallocr.c"]
        "oldmalloc" -> ["oldmalloc.c", "oldcalloc.c", "oldrealloc.c", "oldsys_morecore.c", "mallocr.c"]
        "sbrk"      -> ["sbrk.c"]
in [ build library {
   target = "sys",
   addCFlags  = Config.newlibAddCFlags,
   cFiles     = [ "syscalls.c" , "findfp.c" , "posix_syscalls.c"]
                ++ malloc_files,
 omitCFlags   = [ "-Wmissing-prototypes",
                  "-Wmissing-declarations",
                  "-Wimplicit-function-declaration",
                  "-Werror" ]
}] else []
)))),
("./lib/newlib/newlib/libc/ctype/Hakefile", (let find fn arg = (fn allfiles "./lib/newlib/newlib/libc/ctype/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./lib/newlib/newlib/libc/ctype/Hakefile" a in
{-# LINE 1 "./lib/newlib/newlib/libc/ctype/Hakefile" #-}
if Config.libc == "newlib" then [ build library {
  target = "ctype",
  cFiles = [
    "ctype_.c",
    "isalnum.c",
    "isalpha.c",
    "iscntrl.c",
    "isdigit.c",
    "islower.c",
    "isupper.c",
    "isprint.c",
    "ispunct.c",
    "isspace.c",
    "isxdigit.c",
    "tolower.c",
    "toupper.c",
    "isascii.c",
    "isblank.c",
    "iswalnum.c",
    "iswalpha.c",
    "iswblank.c",
    "iswcntrl.c",
    "iswctype.c",
    "iswdigit.c",
    "iswgraph.c",
    "iswlower.c",
    "iswprint.c",
    "iswpunct.c",
    "iswspace.c",
    "iswupper.c",
    "iswxdigit.c",
    "jp2uc.c",
    "toascii.c",
    "towctrans.c",
    "towlower.c",
    "towupper.c",
    "wctrans.c",
    "wctype.c"], 
  addCFlags  = Config.newlibAddCFlags,
  omitCFlags = [ "-std=c99", "-Wmissing-declarations", "-Wmissing-prototypes", "-Werror"]
}] else []
)))),
("./lib/newlib/newlib/libc/time/Hakefile", (let find fn arg = (fn allfiles "./lib/newlib/newlib/libc/time/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./lib/newlib/newlib/libc/time/Hakefile" a in
{-# LINE 1 "./lib/newlib/newlib/libc/time/Hakefile" #-}
if Config.libc == "newlib" then
[ build library {
  target = "time",
  cFiles = [
    "asctime.c",
    "asctime_r.c",
    "clock.c",
    "ctime.c",
    "ctime_r.c",
    "difftime.c",
    "gettzinfo.c",
    "gmtime.c",
    "gmtime_r.c",
    "lcltime.c",
    "lcltime_r.c",
    "mktime.c",
    "mktm_r.c",
    "strftime.c",
    "strptime.c",
    "time.c",
    "tzlock.c",
    "tzset.c",
    "tzset_r.c",
    "tzvars.c",
    "wcsftime.c" ],
  addCFlags = Config.newlibAddCFlags,
  omitCFlags = [ "-std=c99",
                 "-Wmissing-prototypes",
                 "-Wmissing-declarations",
                 "-Wimplicit-function-declaration",
                 "-Werror" ]
   }
]
else []
)))),
("./lib/newlib/newlib/libc/search/Hakefile", (let find fn arg = (fn allfiles "./lib/newlib/newlib/libc/search/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./lib/newlib/newlib/libc/search/Hakefile" a in
{-# LINE 1 "./lib/newlib/newlib/libc/search/Hakefile" #-}
if Config.libc == "newlib" then [ build library {
  target = "search",
  cFiles = [
    "bsearch.c",
    "qsort.c",
    "hash.c",
    "hash_bigkey.c",
    "hash_buf.c",
    "hash_func.c",
    "hash_log2.c",
    "hash_page.c",
    "hcreate.c",
    "hcreate_r.c",
    "tdelete.c",
    "tdestroy.c",
    "tfind.c",
    "tsearch.c",
    "twalk.c"],
  addCFlags  = Config.newlibAddCFlags,
  omitCFlags = [ "-Wold-style-definition",
                 "-Wstrict-prototypes",
                 "-Wredundant-decls",
                 "-Werror" ]
}] else []
)))),
("./lib/newlib/newlib/libc/errno/Hakefile", (let find fn arg = (fn allfiles "./lib/newlib/newlib/libc/errno/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./lib/newlib/newlib/libc/errno/Hakefile" a in
{-# LINE 1 "./lib/newlib/newlib/libc/errno/Hakefile" #-}
if Config.libc == "newlib" then [ build library {
  target = "errno",
  cFiles = [ "errno.c" ],
  addCFlags = Config.newlibAddCFlags,
  omitCFlags = [ "-Wmissing-prototypes",
                 "-Wmissing-declarations",
                 "-Wimplicit-function-declaration",
                 "-Werror" ]
}] else []
)))),
("./lib/newlib/newlib/libc/argz/Hakefile", (let find fn arg = (fn allfiles "./lib/newlib/newlib/libc/argz/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./lib/newlib/newlib/libc/argz/Hakefile" a in
{-# LINE 1 "./lib/newlib/newlib/libc/argz/Hakefile" #-}
if Config.libc == "newlib" then [ build library {
  target = "argz",
  cFiles = [
          "argz_add.c",
          "argz_add_sep.c",
          "argz_append.c",
          "argz_count.c",
          "argz_create.c",
          "argz_create_sep.c",
          "argz_delete.c",
          "argz_extract.c",
          "argz_insert.c",
          "argz_next.c",
          "argz_replace.c",
          "argz_stringify.c",
          "buf_findstr.c",
          "dummy.c",
          "envz_add.c",
          "envz_entry.c",
          "envz_get.c",
          "envz_merge.c",
          "envz_remove.c",
          "envz_strip.c"
        ],
      addCFlags =  Config.newlibAddCFlags,
      omitCFlags = [ "-Wmissing-prototypes",
                     "-Wmissing-declarations",
                     "-Wimplicit-function-declaration",
                     "-Werror" ]
} ] else []
)))),
("./lib/newlib/newlib/libm/Hakefile", (let find fn arg = (fn allfiles "./lib/newlib/newlib/libm/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./lib/newlib/newlib/libm/Hakefile" a in
{-# LINE 1 "./lib/newlib/newlib/libm/Hakefile" #-}
if Config.libc == "newlib" then
[ build library { 
  target = "m",
  addLibraries = [ "math", "common", "complex" ]
   }
]
else []
)))),
("./lib/newlib/newlib/libm/common/Hakefile", (let find fn arg = (fn allfiles "./lib/newlib/newlib/libm/common/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./lib/newlib/newlib/libm/common/Hakefile" a in
{-# LINE 1 "./lib/newlib/newlib/libm/common/Hakefile" #-}
if Config.libc == "newlib" then
[ build library { 
  target = "common",
  cFiles = [ 
    "s_finite.c",
    "s_copysign.c",
    "s_modf.c",
    "s_scalbn.c",
    "s_cbrt.c",
    "s_exp10.c",
    "s_expm1.c",
    "s_ilogb.c",
    "s_infconst.c",
    "s_infinity.c",
    "s_isinf.c",
    "s_isinfd.c",
    "s_isnan.c",
    "s_isnand.c",
    "s_log1p.c",
    "s_nan.c",
    "s_nextafter.c",
    "s_pow10.c",
    "s_rint.c",
    "s_logb.c",
    "s_log2.c",
    "s_matherr.c",
    "s_lib_ver.c",
    "s_fdim.c",
    "s_fma.c",
    "s_fmax.c",
    "s_fmin.c",
    "s_fpclassify.c",
    "s_lrint.c",
    "s_llrint.c",
    "s_lround.c",
    "s_llround.c",
    "s_nearbyint.c",
    "s_remquo.c",
    "s_round.c",
    "s_scalbln.c",
    "s_signbit.c",
    "s_trunc.c",
    "sf_finite.c",
    "sf_copysign.c",
    "sf_modf.c",
    "sf_scalbn.c",
    "sf_cbrt.c",
    "sf_exp10.c",
    "sf_expm1.c",
    "sf_ilogb.c",
    "sf_infinity.c",
    "sf_isinf.c",
    "sf_isinff.c",
    "sf_isnan.c",
    "sf_isnanf.c",
    "sf_log1p.c",
    "sf_nan.c",
    "sf_nextafter.c",
    "sf_pow10.c",
    "sf_rint.c",
    "sf_logb.c",
    "sf_log2.c",
    "sf_fdim.c",
    "sf_fma.c",
    "sf_fmax.c",
    "sf_fmin.c",
    "sf_fpclassify.c",
    "sf_lrint.c",
    "sf_llrint.c",
    "sf_lround.c",
    "sf_llround.c",
    "sf_nearbyint.c",
    "sf_remquo.c",
    "sf_round.c",
    "sf_scalbln.c",
    "sf_trunc.c",
    "atanl.c",
    "cosl.c",
    "sinl.c",
    "tanl.c",
    "tanhl.c",
    "frexpl.c",
    "modfl.c",
    "ceill.c",
    "fabsl.c",
    "floorl.c",
    "log1pl.c",
    "expm1l.c",
    "acosl.c",
    "asinl.c",
    "atan2l.c",
    "coshl.c",
    "sinhl.c",
    "expl.c",
    "ldexpl.c",
    "logl.c",
    "log10l.c",
    "powl.c",
    "sqrtl.c",
    "fmodl.c",
    "hypotl.c",
    "copysignl.c",
    "nanl.c",
    "ilogbl.c",
    "asinhl.c",
    "cbrtl.c",
    "nextafterl.c",
    "rintl.c",
    "scalbnl.c",
    "exp2l.c",
    "scalblnl.c",
    "tgammal.c",
    "nearbyintl.c",
    "lrintl.c",
    "llrintl.c",
    "roundl.c",
    "lroundl.c",
    "llroundl.c",
    "truncl.c",
    "remquol.c",
    "fdiml.c",
    "fmaxl.c",
    "fminl.c",
    "fmal.c",
    "acoshl.c",
    "atanhl.c",
    "remainderl.c",
    "lgammal.c",
    "erfl.c",
    "erfcl.c"
        ],
      addCFlags = [ "-DPACKAGE_NAME=\"newlib\"", "-DPACKAGE_TARNAME=\"newlib\"", "-DPACKAGE_VERSION=\"1.19.0\"", "-DPACKAGE_BUGREPORT=\"\"", "-DPACKAGE_URL=\"\"", "-D_I386MACH_ALLOW_HW_INTERRUPTS", "-DMISSING_SYSCALL_NAMES" ],
  omitCFlags = [ "-std=c99", "-Wmissing-prototypes", "-Wmissing-declarations", "-Wimplicit-function-declaration", "-Werror" ]
   }
]
else []
)))),
("./lib/newlib/newlib/libm/complex/Hakefile", (let find fn arg = (fn allfiles "./lib/newlib/newlib/libm/complex/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./lib/newlib/newlib/libm/complex/Hakefile" a in
{-# LINE 1 "./lib/newlib/newlib/libm/complex/Hakefile" #-}
if Config.libc == "newlib" then
[ build library { 
  target = "complex",
  cFiles = [ 
    "cabs.c",
    "cacos.c",
    "cacosh.c",
    "carg.c",
    "casin.c",
    "casinh.c",
    "catan.c",
    "catanh.c",
    "ccos.c",
    "ccosh.c",
    "cephes_subr.c",
    "cexp.c",
    "cimag.c",
    "clog.c",
    "conj.c",
    "cpow.c",
    "cproj.c",
    "creal.c",
    "csin.c",
    "csinh.c",
    "csqrt.c",
    "ctan.c",
    "ctanh.c",
    "cabsf.c",
    "casinf.c",
    "ccosf.c",
    "cimagf.c",
    "cprojf.c",
    "csqrtf.c",
    "cacosf.c",
    "casinhf.c",
    "ccoshf.c",
    "clogf.c",
    "crealf.c",
    "ctanf.c",
    "cacoshf.c",
    "catanf.c",
    "cephes_subrf.c",
    "conjf.c",
    "csinf.c",
    "ctanhf.c",
    "cargf.c",
    "catanhf.c",
    "cexpf.c",
    "cpowf.c",
    "csinhf.c"
        ],
      addCFlags = [ "-DPACKAGE_NAME=\"newlib\"", "-DPACKAGE_TARNAME=\"newlib\"", "-DPACKAGE_VERSION=\"1.19.0\"", "-DPACKAGE_BUGREPORT=\"\"", "-DPACKAGE_URL=\"\"", "-D_I386MACH_ALLOW_HW_INTERRUPTS", "-DMISSING_SYSCALL_NAMES" ],
  omitCFlags = [ "-std=c99", "-Wmissing-prototypes", "-Wmissing-declarations", "-Wimplicit-function-declaration", "-Werror" ]
   }
]
else []
)))),
("./lib/newlib/newlib/libm/math/Hakefile", (let find fn arg = (fn allfiles "./lib/newlib/newlib/libm/math/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./lib/newlib/newlib/libm/math/Hakefile" a in
{-# LINE 1 "./lib/newlib/newlib/libm/math/Hakefile" #-}
if Config.libc == "newlib" then
[ build library { 
  target = "math",
  cFiles = [ 
    "k_standard.c",
    "k_rem_pio2.c",
    "k_cos.c",
    "k_sin.c",
    "k_tan.c",
    "e_acos.c",
    "e_acosh.c",
    "e_asin.c",
    "e_atan2.c",
    "e_atanh.c",
    "e_cosh.c",
    "e_exp.c",
    "e_fmod.c",
    "er_gamma.c",
    "e_hypot.c",
    "e_j0.c",
    "e_j1.c",
    "e_jn.c",
    "er_lgamma.c",
    "e_log.c",
    "e_log10.c",
    "e_pow.c",
    "e_rem_pio2.c",
    "e_remainder.c",
    "e_scalb.c",
    "e_sinh.c",
    "e_sqrt.c",
    "w_acos.c",
    "w_acosh.c",
    "w_asin.c",
    "w_atan2.c",
    "w_atanh.c",
    "w_cosh.c",
    "w_exp.c",
    "w_fmod.c",
    "w_gamma.c",
    "wr_gamma.c",
    "w_hypot.c",
    "w_j0.c",
    "w_j1.c",
    "w_jn.c",
    "w_lgamma.c",
    "wr_lgamma.c",
    "w_log.c",
    "w_log10.c",
    "w_pow.c",
    "w_remainder.c",
    "w_scalb.c",
    "w_sinh.c",
    "w_sqrt.c",
    "w_sincos.c",
    "w_drem.c",
    "s_asinh.c",
    "s_atan.c",
    "s_ceil.c",
    "s_cos.c",
    "s_erf.c",
    "s_fabs.c",
    "s_floor.c",
    "s_frexp.c",
    "s_ldexp.c",
    "s_signif.c",
    "s_sin.c",
    "s_tan.c",
    "s_tanh.c",
    "w_exp2.c",
    "w_tgamma.c",
    "kf_rem_pio2.c",
    "kf_cos.c",
    "kf_sin.c",
    "kf_tan.c",
    "ef_acos.c",
    "ef_acosh.c",
    "ef_asin.c",
    "ef_atan2.c",
    "ef_atanh.c",
    "ef_cosh.c",
    "ef_exp.c",
    "ef_fmod.c",
    "erf_gamma.c",
    "ef_hypot.c",
    "ef_j0.c",
    "ef_j1.c",
    "ef_jn.c",
    "erf_lgamma.c",
    "ef_log.c",
    "ef_log10.c",
    "ef_pow.c",
    "ef_rem_pio2.c",
    "ef_remainder.c",
    "ef_scalb.c",
    "ef_sinh.c",
    "ef_sqrt.c",
    "wf_acos.c",
    "wf_acosh.c",
    "wf_asin.c",
    "wf_atan2.c",
    "wf_atanh.c",
    "wf_cosh.c",
    "wf_exp.c",
    "wf_fmod.c",
    "wf_gamma.c",
    "wrf_gamma.c",
    "wf_hypot.c",
    "wf_j0.c",
    "wf_j1.c",
    "wf_jn.c",
    "wf_lgamma.c",
    "wrf_lgamma.c",
    "wf_log.c",
    "wf_log10.c",
    "wf_pow.c",
    "wf_remainder.c",
    "wf_scalb.c",
    "wf_sinh.c",
    "wf_sqrt.c",
    "wf_sincos.c",
    "wf_drem.c",
    "sf_asinh.c",
    "sf_atan.c",
    "sf_ceil.c",
    "sf_cos.c",
    "sf_erf.c",
    "sf_fabs.c",
    "sf_floor.c",
    "sf_frexp.c",
    "sf_ldexp.c",
    "sf_signif.c",
    "sf_sin.c",
    "sf_tan.c",
    "sf_tanh.c",
    "wf_exp2.c",
    "wf_tgamma.c"
        ],
  addCFlags = [ "-DPACKAGE_NAME=\"newlib\"", "-DPACKAGE_TARNAME=\"newlib\"", "-DPACKAGE_VERSION=\"1.19.0\"", "-DPACKAGE_BUGREPORT=\"\"", "-DPACKAGE_URL=\"\"", "-D_I386MACH_ALLOW_HW_INTERRUPTS", "-DMISSING_SYSCALL_NAMES" ],
  addIncludes = [ "../common" ],
  omitCFlags = [ "-std=c99", "-Wmissing-prototypes", "-Wmissing-declarations", "-Wimplicit-function-declaration", "-Werror" ]
   }
]
else []
)))),
("./lib/getopt/Hakefile", (let find fn arg = (fn allfiles "./lib/getopt/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./lib/getopt/Hakefile" a in
{-# LINE 1 "./lib/getopt/Hakefile" #-}
--------------------------------------------------------------------------
-- Copyright (c) 2007-2009, ETH Zurich.
-- All rights reserved.
--
-- This file is distributed under the terms in the attached LICENSE file.
-- If you do not find this file, copies can be found by writing to:
-- ETH Zurich D-INFK, Haldeneggsteig 4, CH-8092 Zurich. Attn: Systems Group.
--
-- Hakefile for lib/getopt
-- 
--------------------------------------------------------------------------

[ build library { target = "getopt", cFiles = [ "getopt.c" ] } ]

)))),
("./lib/zlib/Hakefile", (let find fn arg = (fn allfiles "./lib/zlib/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./lib/zlib/Hakefile" a in
{-# LINE 1 "./lib/zlib/Hakefile" #-}
--------------------------------------------------------------------------
-- Copyright (c) 2007-2009, ETH Zurich.
-- All rights reserved.
--
-- This file is distributed under the terms in the attached LICENSE file.
-- If you do not find this file, copies can be found by writing to:
-- ETH Zurich D-INFK, Haldeneggsteig 4, CH-8092 Zurich. Attn: Systems Group.
--
-- Hakefile for lib/zlib
-- 
--------------------------------------------------------------------------

[ build library { target = "zlib",
                  -- gzio.c has been removed for missing fdopen()
                  -- call, which is POSIX.
                  cFiles = [ "adler32.c", "compress.c", "crc32.c", 
                             "uncompr.c", "deflate.c", "trees.c", 
                             "zutil.c", "inflate.c", "infback.c", 
                             "inftrees.c", "inffast.c" ],
                  addCFlags = [ "-Wno-old-style-definition" ]
                }
]
)))),
("./lib/elf/Hakefile", (let find fn arg = (fn allfiles "./lib/elf/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./lib/elf/Hakefile" a in
{-# LINE 1 "./lib/elf/Hakefile" #-}
--------------------------------------------------------------------------
-- Copyright (c) 2007-2009, 2011, ETH Zurich.
-- All rights reserved.
--
-- This file is distributed under the terms in the attached LICENSE file.
-- If you do not find this file, copies can be found by writing to:
-- ETH Zurich D-INFK, Haldeneggsteig 4, CH-8092 Zurich. Attn: Systems Group.
--
-- Hakefile for lib/elf
-- 
--------------------------------------------------------------------------

[
 build library { target = "elf", cFiles = [ "elf.c", "elf64.c", "elf32.c" ] },

 -- CPU driver version of ELF library. Built without SSE on x86.
 build library {
             target = "elf_kernel",
             cFiles = [ "elf.c", "elf64.c", "elf32.c" ],
             addCFlags = [ "-mno-mmx", "-mno-sse", "-mno-sse2",
                           "-mno-sse3", "-mno-ssse3", "-mno-sse4.1",
                           "-mno-sse4.2", "-mno-sse4", "-mno-sse4a",
                           "-mno-3dnow" ],
             architectures = [ "x86_64", "x86_32", "scc" ]
           }
]
)))),
("./lib/crt/Hakefile", (let find fn arg = (fn allfiles "./lib/crt/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./lib/crt/Hakefile" a in
{-# LINE 1 "./lib/crt/Hakefile" #-}
--------------------------------------------------------------------------
-- Copyright (c) 2007-2011, ETH Zurich.
-- All rights reserved.
--
-- This file is distributed under the terms in the attached LICENSE file.
-- If you do not find this file, copies can be found by writing to:
-- ETH Zurich D-INFK, Haldeneggsteig 4, CH-8092 Zurich. Attn: Systems Group.
--
-- Hakefile for lib/crt
-- 
--------------------------------------------------------------------------

-- Description of crt*.o files generated:
-- crt0.o: startup for all C/C++ programs
-- crtbegin.o .ctors section header (for C++ ABI compatibility)
-- crtend.o .ctors section footer (for C++ ABI compatibility)

[(
let 
    opts = (options arch) { 
             extraDependencies = [ Dep BuildTree arch "/include/asmoffsets.h" ],
             extraDefines = [ "-Wno-array-bounds" ]
           }
    adir = "arch" ./. archFamily arch
in
    Rules [assembleSFile opts (adir  ./. "crt0.S"),
           copy opts (adir ./. "crt0.o") "/lib/crt0.o",
           compileCFile opts ("crtbegin.c"),
           copy opts "crtbegin.o" "/lib/crtbegin.o",
           compileCFile opts ("crtend.c"),
           copy opts "crtend.o" "/lib/crtend.o" ]
) | arch <- allArchitectures ]
)))),
("./lib/oldc/Hakefile", (let find fn arg = (fn allfiles "./lib/oldc/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./lib/oldc/Hakefile" a in
{-# LINE 1 "./lib/oldc/Hakefile" #-}
--------------------------------------------------------------------------
-- Copyright (c) 2007-2011, ETH Zurich.
-- All rights reserved.
--
-- This file is distributed under the terms in the attached LICENSE file.
-- If you do not find this file, copies can be found by writing to:
-- ETH Zurich D-INFK, Haldeneggsteig 4, CH-8092 Zurich. Attn: Systems Group.
--
-- Hakefile for /lib/c
--
--------------------------------------------------------------------------
if Config.libc == "oldc" then
[(
  let
      -- architecture independent source files
      generic_src = [ "src" ./. f | f <- [
        "asctime.c",    "fseek.c",         "getchar.c",   "strncpy.c",
        "assert.c",     "ftell.c",         "getenv.c",    "rewind.c",   "strpbrk.c",
        "calloc.c",     "fwrite.c",        "getopt.c",    "scanf.c",    "strrchr.c",
        "clearerr.c",   "gdtoa/dmisc.c",   "gmtime.c",    "setbuf.c",   "strspn.c",
        "clock.c",      "gdtoa/dtoa.c",    "locale.c",    "snprintf.c", "strstr.c",
        "difftime.c",   "gdtoa/gdtoa.c",   "localtime.c", "sprintf.c",  "strtok.c",
        "errno.c",      "gdtoa/gethex.c",  "malloc.c",    "strtol.c",   "fileno.c",
        "exit.c",       "gdtoa/gmisc.c",   "memchr.c",    "_srefill.c", "strtoll.c",
        "fclose.c",     "gdtoa/hd_init.c", "memcmp.c",    "sscanf.c",   "strtoul.c",
        "feof.c",       "gdtoa/_hdtoa.c",  "memcpy.c",    "strcat.c",   "system.c",
        "ferror.c",     "gdtoa/hexnan.c",  "memmove.c",   "strchr.c",
        "fflush.c",     "gdtoa/_hldtoa.c", "memset.c",    "strcmp.c",   "tmpfile.c",
        "fgetc.c",      "gdtoa/_ldtoa.c",  "mktime.c",    "strcoll.c",  "ungetc.c",
        "fgets.c",      "gdtoa/misc.c",    "perror.c",    "strcpy.c",   "vfprintf.c",
        "fpclassify.c", "gdtoa/smisc.c",   "printf.c",    "strcspn.c",  "vfscanf.c",
        "fprintf.c",    "gdtoa/strtod.c",  "putchar.c",   "strdup.c",   "vprintf.c",
        "fputc.c",      "gdtoa/strtodg.c", "puts.c",      "strerror.c", "vsnprintf.c",
        "fputs.c",      "gdtoa/strtof.c",  "qsort.c",     "strftime.c", "xprintf.c",
        "_fread.c",     "gdtoa/strtord.c", "rand.c",      "strlen.c",   "xprintf_float.c",
        "fread.c",      "gdtoa/sum.c",     "realloc.c",   "strncat.c",  "xprintf_int.c",
        "fscanf.c",     "gdtoa/ulp.c",     "strncmp.c",  "xprintf_str.c",
        "msgcat.c", "strlcpy.c", "strtold.c", "strtoull.c", "strxfrm.c",
        "swprintf.c", "vsscanf.c", "vswprintf.c", "wcscmp.c", "wcscoll.c", "wcscpy.c",
        "wcslen.c", "wcsncpy.c", "wcsxfrm.c", "wmemchr.c", "wmemcmp.c", "wmemcpy.c",
        "wmemmove.c", "wmemset.c", "bsearch.c",
        "fs-barrelfish/fopen.c", "sys-barrelfish/sys_exit.c", "sys-barrelfish/sys_stdio.c",
        "sys-barrelfish/sys_abort.c", "sys-barrelfish/sys_morecore.c",
        "sys-barrelfish/sys_tmpfile.c",
        "locale/ascii.c", "locale/btowc.c", "locale/collate.c",
        "locale/collcmp.c", "locale/fix_grouping.c", "locale/iswctype.c",
        "locale/lmessages.c", "locale/lmonetary.c", "locale/lnumeric.c",
        "locale/mblen.c", "locale/mbrlen.c", "locale/mbrtowc.c",
        "locale/mbsinit.c", "locale/mbsnrtowcs.c", "locale/mbsrtowcs.c",
        "locale/mbstowcs.c", "locale/mbtowc.c", "locale/nextwctype.c",
        "locale/nomacros.c", "locale/none.c", "locale/runetype.c",
        "locale/setlocale.c", "locale/table.c", "locale/tolower.c",
        "locale/toupper.c", "locale/wcrtomb.c", "locale/wcsftime.c",
        "locale/wcsnrtombs.c", "locale/wcsrtombs.c", "locale/wcstod.c",
        "locale/wcstof.c", "locale/wcstoimax.c", "locale/wcstol.c",
        "locale/wcstold.c", "locale/wcstoll.c", "locale/wcstombs.c",
        "locale/wcstoul.c", "locale/wcstoull.c", "locale/wcstoumax.c",
        "locale/wctob.c", "locale/wctomb.c", "locale/wctrans.c",
        "locale/wctype.c", "string/strcasecmp.c" ]]

      -- architecture-dependent source files (relative to arch family)
      archfam_src a = [ ("src/arch-" ++ a) ./. f | f <- archfam_files a ]
      archfam_files "x86_64" = ["flt_rounds.c"]
      archfam_files "x86_32" = ["flt_rounds.c"]
      archfam_files _ = []

      args = library { target = "oldc",
                    cFiles = generic_src ++ (archfam_src (archFamily a)),
                    architectures = [a],
                    addIncludes = [ "src/gdtoa", "src/gdtoa" ./. archFamily a,
                                    "src/locale" ],
                    addCFlags = [ "-DNO_FENV_H", "-DNO_ERRNO", "-DHAVE_WCHAR" ],
                    assemblyFiles = [ ("src/arch-" ++ archFamily a) ./. "jmp.S" ]
                  }
      defaultopts = libGetOptionsForArch a args

      -- build gdtoa with -fno-strict-aliasing
      mkopts s
        | isPrefixOf "src/gdtoa" s = defaultopts { extraFlags = ["-fno-strict-aliasing"] ++ (extraFlags defaultopts) }
        | otherwise                = defaultopts

      -- this is in the List module, but I can't do an import from a Hakefile. sigh.
      isPrefixOf              :: (Eq a) => [a] -> [a] -> Bool
      isPrefixOf [] _         =  True
      isPrefixOf _  []        =  False
      isPrefixOf (x:xs) (y:ys)=  x == y && isPrefixOf xs ys

  in
    Rules [Rules [compileCFile (mkopts s)  s | s <- (Args.cFiles args)],
           assembleSFiles defaultopts (Args.assemblyFiles args),
           staticLibrary defaultopts (Args.target args) (allObjectPaths defaultopts args) 
             [ libraryPath "msun" ] ]
) | a <- allArchitectures ]
else []
)))),
("./lib/oldc/msun/Hakefile", (let find fn arg = (fn allfiles "./lib/oldc/msun/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./lib/oldc/msun/Hakefile" a in
{-# LINE 1 "./lib/oldc/msun/Hakefile" #-}
--------------------------------------------------------------------------
-- Copyright (c) 2007-2009, ETH Zurich.
-- All rights reserved.
--
-- This file is distributed under the terms in the attached LICENSE file.
-- If you do not find this file, copies can be found by writing to:
-- ETH Zurich D-INFK, Haldeneggsteig 4, CH-8092 Zurich. Attn: Systems Group.
--
-- Hakefile for lib/msun
--
--------------------------------------------------------------------------

if Config.libc == "oldc" then
[(
  let
    common_src = ["src" ./. f | f <- [
        "e_acos.c", "e_acosf.c", "e_acosh.c", "e_acoshf.c", "e_asin.c", "e_asinf.c",
        "e_atan2.c", "e_atan2f.c", "e_atanh.c", "e_atanhf.c", "e_cosh.c", "e_coshf.c", "e_exp.c",
        "e_expf.c", "e_fmod.c", "e_fmodf.c", "e_gamma.c", "e_gamma_r.c", "e_gammaf.c",
        "e_gammaf_r.c", "e_hypot.c", "e_hypotf.c", "e_j0.c", "e_j0f.c", "e_j1.c", "e_j1f.c",
        "e_jn.c", "e_jnf.c", "e_lgamma.c", "e_lgamma_r.c", "e_lgammaf.c", "e_lgammaf_r.c",
        "e_log.c", "e_log10.c", "e_log10f.c", "e_logf.c", "e_pow.c", "e_powf.c", "e_rem_pio2.c",
        "e_rem_pio2f.c", "e_remainder.c", "e_remainderf.c", "e_scalb.c", "e_scalbf.c",
        "e_sinh.c", "e_sinhf.c", "e_sqrt.c", "e_sqrtf.c",
        "k_cos.c", "k_cosf.c", "k_rem_pio2.c", "k_sin.c", "k_sinf.c",
        "k_tan.c", "k_tanf.c",
        "s_asinh.c", "s_asinhf.c", "s_atan.c", "s_atanf.c", "s_carg.c", "s_cargf.c", "s_cargl.c",
        "s_cbrt.c", "s_cbrtf.c", "s_ceil.c", "s_ceilf.c",
        "s_copysign.c", "s_copysignf.c", "s_cos.c", "s_cosf.c",
        "s_csqrt.c", "s_csqrtf.c", "s_erf.c", "s_erff.c",
        "s_exp2.c", "s_exp2f.c", "s_expm1.c", "s_expm1f.c", "s_fabsf.c", "s_fdim.c",
        "s_finite.c", "s_finitef.c",
        "s_floor.c", "s_floorf.c", "s_fma.c", "s_fmaf.c",
        "s_fmax.c", "s_fmaxf.c", "s_fmaxl.c", "s_fmin.c",
        "s_fminf.c", "s_fminl.c", "s_frexpf.c", "s_ilogb.c", "s_ilogbf.c",
        "s_ilogbl.c", "s_isfinite.c", "s_isinf.c", "s_isnormal.c",
        "s_llrint.c", "s_llrintf.c", "s_llround.c", "s_llroundf.c", "s_llroundl.c",
        "s_log1p.c", "s_log1pf.c", "s_logb.c", "s_logbf.c", "s_lrint.c", "s_lrintf.c",
        "s_lround.c", "s_lroundf.c", "s_lroundl.c", "s_modff.c",
        "s_nan.c", "s_nearbyint.c", "s_nextafter.c", "s_nextafterf.c",
        "s_nexttowardf.c", "s_remquo.c", "s_remquof.c",
        "s_rint.c", "s_rintf.c", "s_round.c", "s_roundf.c", "s_roundl.c",
        "s_scalbln.c", "s_scalbn.c", "s_scalbnf.c", "s_signbit.c",
        "s_signgam.c", "s_significand.c", "s_significandf.c", "s_sin.c", "s_sinf.c",
        "s_tan.c", "s_tanf.c", "s_tanh.c", "s_tanhf.c", "s_tgammaf.c", "s_trunc.c", "s_truncf.c",
        "w_cabs.c", "w_cabsf.c", "w_drem.c", "w_dremf.c",

        -- The BSD source of MSUN provides these but doenst compile them
        -- claiming that libc provides them, but in barrelfish we seem to need them
        "s_fabs.c", "s_frexp.c", "s_isnan.c", "s_ldexp.c", "s_modf.c"]]

    (longdouble_dir, arch_csrc, arch_asmsrc) = case a of
        "x86_64" -> ("ld80", ["amd64/fenv.c"], ["amd64" ./. f | f <- [
                        "e_remainderf.S", "e_sqrt.S", "s_llrintf.S",
                        "s_lrintf.S", "s_remquof.S", "s_scalbnf.S", "e_sqrtf.S",
                        "s_llrintl.S", "s_lrintl.S", "s_remquol.S",
                        "s_scalbnl.S", "e_sqrtl.S", "s_llrint.S", "s_lrint.S",
                        "s_remquo.S", "s_scalbn.S"]])
        _ -> ("", [], [])

    longdouble_src = if longdouble_dir == "" then [] else (
        [longdouble_dir ./. f | f <- [
                "invtrig.c", "k_cosl.c", "k_sinl.c", "k_tanl.c",
                "s_exp2l.c", "s_nanl.c"]]
        ++
        ["src" ./. f | f <- [
                "e_acosl.c", "e_asinl.c", "e_atan2l.c", "e_fmodl.c",
                "e_hypotl.c", "e_remainderl.c", "e_sqrtl.c",
                "s_atanl.c", "s_ceill.c", "s_cosl.c", "s_cprojl.c", "s_csqrtl.c",
                "s_floorl.c", "s_fmal.c",
                "s_frexpl.c", "s_logbl.c", "s_nextafterl.c", "s_nexttoward.c",
                "s_remquol.c", "s_rintl.c", "s_scalbnl.c",
                "s_sinl.c", "s_tanl.c", "s_truncl.c", "w_cabsl.c"]])
  in
    build library { target = "msun",
                  cFiles = arch_csrc ++ common_src ++ longdouble_src,
                  assemblyFiles = arch_asmsrc,
                  architectures = [ a ],
                  addIncludes = ["src"] ++ (
                          if longdouble_dir == "" then [] else [longdouble_dir])
                }
) | a <- allArchitectures ]
else []
)))),
("./kernel/Hakefile", (let find fn arg = (fn allfiles "./kernel/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./kernel/Hakefile" a in
{-# LINE 1 "./kernel/Hakefile" #-}
--------------------------------------------------------------------------
-- Copyright (c) 2007-2013, ETH Zurich.
-- All rights reserved.
--
-- This file is distributed under the terms in the attached LICENSE file.
-- If you do not find this file, copies can be found by writing to:
-- ETH Zurich D-INFK, CAB F.78, Universitaetstr. 6, CH-8092 Zurich. 
-- Attn: Systems Group.
--
-- Hakefile for Barrelfish CPU drivers
-- 
--------------------------------------------------------------------------

--
-- Missing from this new Hakefile is the rule to build kernel debug
-- symbols, since this requires some thinking about naming
-- conventions.  Here is the rule we need:
--
--                Rule ( [ Str "OBJDUMP=objdump",
--                         In SrcTree "src" "/tools/gen-gdbscript.sh",
--                         In SrcTree "src" "/tools/debug.gdb.in",
--                         In BuildTree arch "../sbin/cpu",
--                         Str ">", Out arch "/debug.gdb"
--                        ] )



let
  common_c = [ "dispatch.c",
               "memset.c", 
               "memmove.c", 
               "printf.c",
               "startup.c",
               "stdlib.c", 
               "string.c" ]
  common_libs = [ ]
  
  link_cpudriver arg = linkKernel opts name objs libs
    where 
      opts = (kernelOptions $ head $ Args.architectures arg)
      suffix = if "cpu" == Args.target arg 
             then "" 
             else "_" ++ (Args.target arg)
      name = "cpu" ++ suffix
      objs = [ objectFilePath opts f 
             | f <- (Args.assemblyFiles arg) ++ (Args.cFiles arg) ++ common_c ] 
      libs = (Args.addLibraries arg) ++ common_libs
    
  cpudrivers arglist = 
    let 
      cafiles = Data.List.nub $ concat [ [ [ arch, cfile ] 
                                         | arch <- Args.architectures arg,
                                           cfile <- common_c ++ (Args.cFiles arg) ]
                                       | arg <- arglist ]
      safiles = Data.List.nub $ concat [ [ [ arch, sfile ]
                                         | arch <- Args.architectures arg,
                                           sfile <- Args.assemblyFiles arg ]
                                       | arg <- arglist ]
      mafiles = Data.List.nub $ concat [ [ [ arch, mfile ]
                                         | arch <- Args.architectures arg,
                                           mfile <- Args.mackerelDevices arg ]
                                       | arg <- arglist ]
    in
     ( [ compileCFile (kernelOptions a) f | [a,f] <- cafiles ]
       ++
       [ assembleSFile (kernelOptions a) f | [a,f] <- safiles ]
       ++
       [ mackerelDependencies (kernelOptions a) f [ c | [a,c] <- cafiles]  
       | [a,f] <- mafiles ]
       ++
       [ link_cpudriver arg | arg <- arglist ]
     )
         
  in cpudrivers [
  --
  -- Generic Intel/AMD amd64 64-bit x86 core
  --
  --
  -- Broadcom OMAP44xx-series dual-core Cortex-A9 SoC
  --
  cpuDriver {
     target = "omap44xx",
     architectures = [ "armv7" ],
     assemblyFiles = [ "arch/omap44xx/boot.S",
                       "arch/armv7/cp15.S",
                       "arch/armv7/exceptions.S" ],
     cFiles = [ "arch/arm/exn.c",
                "arch/arm/misc.c",
                "arch/armv7/kludges.c",
                "arch/armv7/kputchar.c",
                "arch/omap44xx/init.c",
                "arch/omap44xx/paging.c",
                "arch/omap44xx/multiboot.c",
                "arch/omap44xx/omap_gic.c",
                "arch/omap44xx/omap_led.c",
                "arch/omap44xx/omap_uart.c",
                "arch/omap44xx/startup_arch.c",
                "arch/omap44xx/startup_helpers.c" ],
      addLibraries = [ "elf" ]
     }
  ]
)))),
("./if/Hakefile", (let find fn arg = (fn allfiles "./if/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./if/Hakefile" a in
{-# LINE 1 "./if/Hakefile" #-}
--------------------------------------------------------------------------
-- Copyright (c) 2007-2011, ETH Zurich.
-- All rights reserved.
--
-- This file is distributed under the terms in the attached LICENSE file.
-- If you do not find this file, copies can be found by writing to:
-- ETH Zurich D-INFK, Haldeneggsteig 4, CH-8092 Zurich. Attn: Systems Group.
--
-- Hakefile for if/
--
--------------------------------------------------------------------------

-- whereas these are using the new-style bindings
[ flounderGenDefs (options arch) f
      | f <- [ "ahci_mgmt",
               "ata_rw28",
               "bcast",
               "bench",
               "boot_perfmon",
               "bulkbench",
               "diskd",
               "ehci",
               "net_queue_manager",
               "net_ports",
               "net_soft_filters",
               "net_ARP",
               "fb",
               "glue_bench",
               "hpet",
               "interdisp",
               "intermon",
               "keyboard",
               "lock",
               "mem",
               "monitor",
               "monitor_blocking",
               "monitor_mem",
               "mouse",
               "nameservice",
--               "netd",
               "acpi",
               "pci",
               "ping_pong",
               "pixels",
               "rcce",
               "routing",
               "serial",
               "skb",
               "skb_map",
               "octopus",               
               "spawn",
               "test",
               "timer",
               "trivfs",
               "usb_driver",
               "usb_manager",
               "xcorecap",
               "xcorecapbench",
               "xmplcr",
               "xmplmsg",
               "xmplrpc",
               "xmplthc",
               "unixsock",
	       "bcache",
	       "replay",
	       "empty"],
             arch <- allArchitectures
] ++

-- these are for THC stubs
[ flounderTHCFile (options arch) f
      | f <- [ "bench",
               "ping_pong",
               "mem",
               "xmplthc",
               "octopus" ],
             arch <- allArchitectures
]
)))),
("./tools/pleco/Hakefile", (let find fn arg = (fn allfiles "./tools/pleco/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./tools/pleco/Hakefile" a in
{-# LINE 1 "./tools/pleco/Hakefile" #-}
----------------------------------------------------------------------
-- Copyright (c) 2013, ETH Zurich.
-- All rights reserved.
--
-- This file is distributed under the terms in the attached LICENSE file.
-- If you do not find this file, copies can be found by writing to:
-- ETH Zurich D-INFK, Haldeneggsteig 4, CH-8092 Zurich. Attn: Systems Group.
--
-- Hakefile for /tools/pleco
--
----------------------------------------------------------------------

[ compileHaskellWithLibs "pleco" "Main.lhs" (find withSuffices [".hs",".lhs"])
  			 	["/tools/fof"] ]
)))),
("./tools/schedsim/Hakefile", (let find fn arg = (fn allfiles "./tools/schedsim/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./tools/schedsim/Hakefile" a in
{-# LINE 1 "./tools/schedsim/Hakefile" #-}
----------------------------------------------------------------------
-- Copyright (c) 2009, 2010, ETH Zurich.
-- All rights reserved.
--
-- This file is distributed under the terms in the attached LICENSE file.
-- If you do not find this file, copies can be found by writing to:
-- ETH Zurich D-INFK, Haldeneggsteig 4, CH-8092 Zurich. Attn: Systems Group.
--
-- Hakefile for scheduler simulator
--
----------------------------------------------------------------------

[ compileNativeC "simulator"
  [ "simulator.c" ]
  [ "-std=gnu99", "-g", "-Wall", "-Werror", "-DSCHEDULER_SIMULATOR" ]
  []
]
)))),
("./tools/arm_molly/Hakefile", (let find fn arg = (fn allfiles "./tools/arm_molly/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./tools/arm_molly/Hakefile" a in
{-# LINE 1 "./tools/arm_molly/Hakefile" #-}
----------------------------------------------------------------------
-- Copyright (c) 2009, 2010, ETH Zurich.
-- All rights reserved.
--
-- This file is distributed under the terms in the attached LICENSE file.
-- If you do not find this file, copies can be found by writing to:
-- ETH Zurich D-INFK, Haldeneggsteig 4, CH-8092 Zurich. Attn: Systems Group.
--
-- Hakefile for molly
--
----------------------------------------------------------------------

[ compileNativeC "arm_molly" ["build_multiboot.c"] ["-std=gnu99", "-g", "-Iarmv7/include/"] [] ]
)))),
("./tools/asmoffsets/Hakefile", (let find fn arg = (fn allfiles "./tools/asmoffsets/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./tools/asmoffsets/Hakefile" a in
{-# LINE 1 "./tools/asmoffsets/Hakefile" #-}
--------------------------------------------------------------------------
-- Copyright (c) 2007-2009, ETH Zurich.
-- All rights reserved.
--
-- This file is distributed under the terms in the attached LICENSE file.
-- If you do not find this file, copies can be found by writing to:
-- ETH Zurich D-INFK, Haldeneggsteig 4, CH-8092 Zurich. Attn: Systems Group.
--
-- Hakefile for tools/asmoffsets
--
--------------------------------------------------------------------------

concat [ let
    kopts = kernelOptions arch
    opts = kopts { -- Need this to exclude asmoffsets.h!
                   optDependencies = [d | d <- optDependencies kopts,
                                      d /= Dep InstallTree arch "/include/asmoffsets.h"]
                 }
   in
     [ Rule (makecToAssembler opts "src" "asmoffsets.c" "asmoffsets.s"), -- asmoffsets.s here is not the output it is the stem of the presumed output for the depenedency
       makeDependAssembler opts "src" "asmoffsets.c",
       Rule [ Str "grep -E '^#(if|ifndef|ifdef|define|undef|endif)'",
           In BuildTree arch (assemblerFilePath opts "asmoffsets.c"),
           Str "| sed 's/\\$$//'",
           Str "| sed -e 's_#\\([0-9]\\)_\\1_' >",
           Out arch "/include/asmoffsets.h" ]
     ] | arch <- allArchitectures]
)))),
("./tools/fugu/Hakefile", (let find fn arg = (fn allfiles "./tools/fugu/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./tools/fugu/Hakefile" a in
{-# LINE 1 "./tools/fugu/Hakefile" #-}
----------------------------------------------------------------------
-- Copyright (c) 2009, ETH Zurich.
-- All rights reserved.
--
-- This file is distributed under the terms in the attached LICENSE file.
-- If you do not find this file, copies can be found by writing to:
-- ETH Zurich D-INFK, Haldeneggsteig 4, CH-8092 Zurich. Attn: Systems Group.
--
-- Hakefile for /tools/fugu
--
----------------------------------------------------------------------

[ compileHaskellWithLibs "fugu" "Main.lhs" (find withSuffices [".hs",".lhs"])
  			 	["/tools/fof"] ]
)))),
("./tools/molly/Hakefile", (let find fn arg = (fn allfiles "./tools/molly/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./tools/molly/Hakefile" a in
{-# LINE 1 "./tools/molly/Hakefile" #-}
----------------------------------------------------------------------
-- Copyright (c) 2009, 2010, ETH Zurich.
-- All rights reserved.
--
-- This file is distributed under the terms in the attached LICENSE file.
-- If you do not find this file, copies can be found by writing to:
-- ETH Zurich D-INFK, Haldeneggsteig 4, CH-8092 Zurich. Attn: Systems Group.
--
-- Hakefile for molly
--
----------------------------------------------------------------------

[ compileNativeC "molly" ["build_multiboot.c"] ["-std=gnu99", "-g"] [] ]
)))),
("./tools/flounder/Hakefile", (let find fn arg = (fn allfiles "./tools/flounder/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./tools/flounder/Hakefile" a in
{-# LINE 1 "./tools/flounder/Hakefile" #-}
----------------------------------------------------------------------
-- Copyright (c) 2009, ETH Zurich.
-- All rights reserved.
--
-- This file is distributed under the terms in the attached LICENSE file.
-- If you do not find this file, copies can be found by writing to:
-- ETH Zurich D-INFK, Haldeneggsteig 4, CH-8092 Zurich. Attn: Systems Group.
--
-- Hakefile for /tools/flounder
--
----------------------------------------------------------------------

[ compileHaskell "flounder" "Main.lhs" (find withSuffices [".hs",".lhs"]) ]
)))),
("./tools/elver/Hakefile", (let find fn arg = (fn allfiles "./tools/elver/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./tools/elver/Hakefile" a in
{-# LINE 1 "./tools/elver/Hakefile" #-}
----------------------------------------------------------------------
-- Copyright (c) 2009, 2010, ETH Zurich.
-- All rights reserved.
--
-- This file is distributed under the terms in the attached LICENSE file.
-- If you do not find this file, copies can be found by writing to:
-- ETH Zurich D-INFK, Haldeneggsteig 4, CH-8092 Zurich. Attn: Systems Group.
--
-- Hakefile for /tools/elver
--
----------------------------------------------------------------------

--
-- This has to be rather low-level, since elver is indeed a module for
-- x86_64, but is built for 32-bits, so it's easiest to do this rather
-- explicitly.
-- 
let arch = "x86_64"
    opts = (options arch) { 
             optFlags = [ Str s | s <- [ "-fno-builtin",
                                           "-nostdinc",
                                           "-std=gnu99",
                                           "-m32",
                                           "-mno-red-zone",

					   -- avoid SSE instructions, SIMD is disabled
                                           "-mno-mmx",
                                           "-mno-sse",
                                           "-mno-sse2",
                                           "-mno-sse3",
                                           "-mno-sse4.1",
                                           "-mno-sse4.2",
                                           "-mno-sse4",
                                           "-mno-sse4a",
                                           "-mno-3dnow",

                                           "-fPIE",
                                           "-fno-stack-protector",
                                           "-U__linux__",
                                           "-Wall",
                                           "-Wshadow",
                                           "-Wstrict-prototypes",
                                           "-Wold-style-definition",
                                           "-Wmissing-prototypes",
                                           "-Wmissing-declarations",
                                           "-Wmissing-field-initializers",
                                           "-Wredundant-decls",
                                           "-Werror" ] ]
                          ++ [ Str "-imacros",
                               NoDep SrcTree "src" "/include/deputy/nodeputy.h" ],
             optIncludes = [ NoDep SrcTree "src" "/include",
                             NoDep SrcTree "src" "/include/oldc", 
                             NoDep SrcTree "src" "/include/c", 
                             NoDep SrcTree "src" "/include/arch/x86_32",
                             NoDep BuildTree arch "/include" ],
             optDefines = [],
             optLibs = [],
             optLdFlags = [ Str s | s <- [ "-m32", 
                                        "-fno-builtin", 
                                        "-nostdlib",
                                        "-Wl,--fatal-warnings",
                                        "-e start", 
                                        "-Wl,-Ttext,0x100000",
                                        "-Wl,--build-id=none" ]],
             optSuffix = "_for_elver" 
           }
    objs = [ objectFilePath opts f | f <- [ "boot.S", "elver.c", "lib.c",
                                            "../../lib/elf/elf64.c" ] ]
in 
  [ compileCFiles opts [ "elver.c", "lib.c", "../../lib/elf/elf64.c" ],
    assembleSFiles opts [ "boot.S" ],
    link opts objs [] "elver"
  ]
)))),
("./tools/mackerel/Hakefile", (let find fn arg = (fn allfiles "./tools/mackerel/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./tools/mackerel/Hakefile" a in
{-# LINE 1 "./tools/mackerel/Hakefile" #-}
----------------------------------------------------------------------
-- Copyright (c) 2009, ETH Zurich.
-- All rights reserved.
--
-- This file is distributed under the terms in the attached LICENSE file.
-- If you do not find this file, copies can be found by writing to:
-- ETH Zurich D-INFK, Haldeneggsteig 4, CH-8092 Zurich. Attn: Systems Group.
--
-- Hakefile for /tools/mackerel
--
----------------------------------------------------------------------

[ compileHaskell "mackerel" "Main.hs" (find withSuffices [".hs",".lhs"]) ]
)))),
("./tools/dite/Hakefile", (let find fn arg = (fn allfiles "./tools/dite/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./tools/dite/Hakefile" a in
{-# LINE 1 "./tools/dite/Hakefile" #-}
----------------------------------------------------------------------
-- Copyright (c) 2009, 2010, 2011, ETH Zurich.
-- All rights reserved.
--
-- This file is distributed under the terms in the attached LICENSE file.
-- If you do not find this file, copies can be found by writing to:
-- ETH Zurich D-INFK, Haldeneggsteig 4, CH-8092 Zurich. Attn: Systems Group.
--
-- Hakefile for dite
--
----------------------------------------------------------------------

[ compileNativeC "dite" ["dite.c", "elf32.c", "elf64.c"] ["-std=gnu99", "-g"] [] ]
)))),
("./tools/hamlet/Hakefile", (let find fn arg = (fn allfiles "./tools/hamlet/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./tools/hamlet/Hakefile" a in
{-# LINE 1 "./tools/hamlet/Hakefile" #-}
----------------------------------------------------------------------
-- Copyright (c) 2009, ETH Zurich.
-- All rights reserved.
--
-- This file is distributed under the terms in the attached LICENSE file.
-- If you do not find this file, copies can be found by writing to:
-- ETH Zurich D-INFK, Haldeneggsteig 4, CH-8092 Zurich. Attn: Systems Group.
--
-- Hakefile for /tools/hamlet
--
----------------------------------------------------------------------

[ compileHaskellWithLibs "hamlet" "Main.lhs" (find withSuffices [".hs",".lhs"])
  			 	["/tools/fof"] ]
)))),
("./errors/Hakefile", (let find fn arg = (fn allfiles "./errors/Hakefile" arg) in
Rules ((let build a = (buildFunction a) allfiles "./errors/Hakefile" a in
{-# LINE 1 "./errors/Hakefile" #-}
--------------------------------------------------------------------------
-- Copyright (c) 2007-2009, ETH Zurich.
-- All rights reserved.
--
-- This file is distributed under the terms in the attached LICENSE file.
-- If you do not find this file, copies can be found by writing to:
-- ETH Zurich D-INFK, Haldeneggsteig 4, CH-8092 Zurich. Attn: Systems Group.
--
-- Hakefile for /errors/
-- 
--------------------------------------------------------------------------

[ fuguFile (options arch) "errno" | arch <- allArchitectures ]
))))];
}
