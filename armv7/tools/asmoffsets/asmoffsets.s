	.cpu cortex-a9
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 2
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"asmoffsets.c"
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.align	2
	.global	dummy
	.type	dummy, %function
dummy:
.LFB37:
	.file 1 "./tools/asmoffsets/asmoffsets.c"
	.loc 1 79 0
	.cfi_startproc
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	.loc 1 81 0
#APP
@ 81 "./tools/asmoffsets/asmoffsets.c" 1
	
#ifndef ASMOFFSETS_H
#define ASMOFFSETS_H

@ 0 "" 2
	.loc 1 82 0
@ 82 "./tools/asmoffsets/asmoffsets.c" 1
	
#define OFFSETOF_DCB_DISP	#0

@ 0 "" 2
	.loc 1 83 0
@ 83 "./tools/asmoffsets/asmoffsets.c" 1
	
#define OFFSETOF_DCB_DISABLED	#4

@ 0 "" 2
	.loc 1 85 0
@ 85 "./tools/asmoffsets/asmoffsets.c" 1
	
#define OFFSETOF_DCB_VSPACE	#8

@ 0 "" 2
	.loc 1 89 0
@ 89 "./tools/asmoffsets/asmoffsets.c" 1
	
#define OFFSETOF_DCB_RBED_NEXT	#40

@ 0 "" 2
	.loc 1 94 0
@ 94 "./tools/asmoffsets/asmoffsets.c" 1
	
#define OFFSETOF_DISP_DISABLED	#0

@ 0 "" 2
	.loc 1 95 0
@ 95 "./tools/asmoffsets/asmoffsets.c" 1
	
#define OFFSETOF_DISP_RUN	#24

@ 0 "" 2
	.loc 1 96 0
@ 96 "./tools/asmoffsets/asmoffsets.c" 1
	
#define OFFSETOF_DISP_LRPC	#28

@ 0 "" 2
	.loc 1 97 0
@ 97 "./tools/asmoffsets/asmoffsets.c" 1
	
#define OFFSETOF_DISP_UDISP	#8

@ 0 "" 2
	.loc 1 98 0
@ 98 "./tools/asmoffsets/asmoffsets.c" 1
	
#define OFFSETOF_DISP_LMP_DELIVERED	#12

@ 0 "" 2
	.loc 1 99 0
@ 99 "./tools/asmoffsets/asmoffsets.c" 1
	
#define OFFSETOF_DISP_SYSTIME	#48

@ 0 "" 2
	.loc 1 101 0
@ 101 "./tools/asmoffsets/asmoffsets.c" 1
	
#define OFFSETOF_DISP_PRIV_STACK_LIMIT	#12800

@ 0 "" 2
	.loc 1 102 0
@ 102 "./tools/asmoffsets/asmoffsets.c" 1
	
#define OFFSETOF_DISP_PRIV_TRAP_STACK_LIMIT	#6400

@ 0 "" 2
	.loc 1 126 0
@ 126 "./tools/asmoffsets/asmoffsets.c" 1
	
#define OFFSETOF_DISP_SAVE_AREA	#92

@ 0 "" 2
	.loc 1 127 0
@ 127 "./tools/asmoffsets/asmoffsets.c" 1
	
#define OFFSETOF_DISP_GENERIC	#160

@ 0 "" 2
	.loc 1 144 0
@ 144 "./tools/asmoffsets/asmoffsets.c" 1
	
#define SYS_ERR_OK	#0

@ 0 "" 2
	.loc 1 145 0
@ 145 "./tools/asmoffsets/asmoffsets.c" 1
	
#define SYS_ERR_LMP_TARGET_DISABLED	#10

@ 0 "" 2
	.loc 1 146 0
@ 146 "./tools/asmoffsets/asmoffsets.c" 1
	
#define SYS_ERR_LMP_BUF_OVERFLOW	#11

@ 0 "" 2
	.loc 1 147 0
@ 147 "./tools/asmoffsets/asmoffsets.c" 1
	
#define SYS_ERR_LRPC_SLOT_INVALID	#17

@ 0 "" 2
	.loc 1 148 0
@ 148 "./tools/asmoffsets/asmoffsets.c" 1
	
#define SYS_ERR_LRPC_NOT_ENDPOINT	#18

@ 0 "" 2
	.loc 1 163 0
@ 163 "./tools/asmoffsets/asmoffsets.c" 1
	
#define SIZEOF_STRUCT_SYSRET	#8

@ 0 "" 2
	.loc 1 166 0
@ 166 "./tools/asmoffsets/asmoffsets.c" 1
	
#endif /* ASMOFFSETS_H */

@ 0 "" 2
	.loc 1 167 0
	bx	lr
	.cfi_endproc
.LFE37:
	.size	dummy, .-dummy
.Letext0:
	.file 2 "./lib/newlib/newlib/libc/include/stdint.h"
	.file 3 "./include/barrelfish_kpi/types.h"
	.file 4 "./include/k_r_malloc.h"
	.file 5 "./include/barrelfish/core_state.h"
	.file 6 "./include/arch/arm/barrelfish/core_state_arch.h"
	.file 7 "./include/barrelfish/dispatcher.h"
	.file 8 "./armv7/include/errors/errno.h"
	.file 9 "./kernel/include/dispatch.h"
	.section	.debug_info,"",%progbits
.Ldebug_info0:
	.4byte	0x13b6
	.2byte	0x2
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.4byte	.LASF675
	.byte	0x1
	.4byte	.LASF676
	.4byte	.LASF677
	.4byte	.Ltext0
	.4byte	.Letext0
	.4byte	.Ldebug_line0
	.uleb128 0x2
	.byte	0x4
	.byte	0x5
	.ascii	"int\000"
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.4byte	.LASF0
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.4byte	.LASF1
	.uleb128 0x4
	.4byte	.LASF6
	.byte	0x2
	.byte	0x2a
	.4byte	0x45
	.uleb128 0x3
	.byte	0x1
	.byte	0x8
	.4byte	.LASF2
	.uleb128 0x3
	.byte	0x2
	.byte	0x5
	.4byte	.LASF3
	.uleb128 0x3
	.byte	0x2
	.byte	0x7
	.4byte	.LASF4
	.uleb128 0x3
	.byte	0x4
	.byte	0x5
	.4byte	.LASF5
	.uleb128 0x4
	.4byte	.LASF7
	.byte	0x2
	.byte	0x50
	.4byte	0x6c
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.4byte	.LASF8
	.uleb128 0x3
	.byte	0x8
	.byte	0x5
	.4byte	.LASF9
	.uleb128 0x4
	.4byte	.LASF10
	.byte	0x2
	.byte	0x78
	.4byte	0x85
	.uleb128 0x3
	.byte	0x8
	.byte	0x7
	.4byte	.LASF11
	.uleb128 0x5
	.4byte	.LASF12
	.byte	0x2
	.2byte	0x103
	.4byte	0x6c
	.uleb128 0x3
	.byte	0x1
	.byte	0x8
	.4byte	.LASF13
	.uleb128 0x4
	.4byte	.LASF14
	.byte	0x3
	.byte	0x51
	.4byte	0x3a
	.uleb128 0x4
	.4byte	.LASF15
	.byte	0x3
	.byte	0x65
	.4byte	0x61
	.uleb128 0x6
	.4byte	.LASF678
	.byte	0x4
	.byte	0x8
	.byte	0xb
	.4byte	0x11d8
	.uleb128 0x7
	.4byte	.LASF16
	.sleb128 0
	.uleb128 0x7
	.4byte	.LASF17
	.sleb128 3
	.uleb128 0x7
	.4byte	.LASF18
	.sleb128 4
	.uleb128 0x7
	.4byte	.LASF19
	.sleb128 5
	.uleb128 0x7
	.4byte	.LASF20
	.sleb128 6
	.uleb128 0x7
	.4byte	.LASF21
	.sleb128 7
	.uleb128 0x7
	.4byte	.LASF22
	.sleb128 8
	.uleb128 0x7
	.4byte	.LASF23
	.sleb128 9
	.uleb128 0x7
	.4byte	.LASF24
	.sleb128 10
	.uleb128 0x7
	.4byte	.LASF25
	.sleb128 11
	.uleb128 0x7
	.4byte	.LASF26
	.sleb128 12
	.uleb128 0x7
	.4byte	.LASF27
	.sleb128 13
	.uleb128 0x7
	.4byte	.LASF28
	.sleb128 14
	.uleb128 0x7
	.4byte	.LASF29
	.sleb128 15
	.uleb128 0x7
	.4byte	.LASF30
	.sleb128 16
	.uleb128 0x7
	.4byte	.LASF31
	.sleb128 17
	.uleb128 0x7
	.4byte	.LASF32
	.sleb128 18
	.uleb128 0x7
	.4byte	.LASF33
	.sleb128 19
	.uleb128 0x7
	.4byte	.LASF34
	.sleb128 20
	.uleb128 0x7
	.4byte	.LASF35
	.sleb128 21
	.uleb128 0x7
	.4byte	.LASF36
	.sleb128 22
	.uleb128 0x7
	.4byte	.LASF37
	.sleb128 23
	.uleb128 0x7
	.4byte	.LASF38
	.sleb128 24
	.uleb128 0x7
	.4byte	.LASF39
	.sleb128 25
	.uleb128 0x7
	.4byte	.LASF40
	.sleb128 26
	.uleb128 0x7
	.4byte	.LASF41
	.sleb128 27
	.uleb128 0x7
	.4byte	.LASF42
	.sleb128 28
	.uleb128 0x7
	.4byte	.LASF43
	.sleb128 29
	.uleb128 0x7
	.4byte	.LASF44
	.sleb128 30
	.uleb128 0x7
	.4byte	.LASF45
	.sleb128 31
	.uleb128 0x7
	.4byte	.LASF46
	.sleb128 32
	.uleb128 0x7
	.4byte	.LASF47
	.sleb128 33
	.uleb128 0x7
	.4byte	.LASF48
	.sleb128 34
	.uleb128 0x7
	.4byte	.LASF49
	.sleb128 35
	.uleb128 0x7
	.4byte	.LASF50
	.sleb128 36
	.uleb128 0x7
	.4byte	.LASF51
	.sleb128 37
	.uleb128 0x7
	.4byte	.LASF52
	.sleb128 38
	.uleb128 0x7
	.4byte	.LASF53
	.sleb128 39
	.uleb128 0x7
	.4byte	.LASF54
	.sleb128 40
	.uleb128 0x7
	.4byte	.LASF55
	.sleb128 41
	.uleb128 0x7
	.4byte	.LASF56
	.sleb128 42
	.uleb128 0x7
	.4byte	.LASF57
	.sleb128 43
	.uleb128 0x7
	.4byte	.LASF58
	.sleb128 44
	.uleb128 0x7
	.4byte	.LASF59
	.sleb128 45
	.uleb128 0x7
	.4byte	.LASF60
	.sleb128 46
	.uleb128 0x7
	.4byte	.LASF61
	.sleb128 47
	.uleb128 0x7
	.4byte	.LASF62
	.sleb128 48
	.uleb128 0x7
	.4byte	.LASF63
	.sleb128 49
	.uleb128 0x7
	.4byte	.LASF64
	.sleb128 50
	.uleb128 0x7
	.4byte	.LASF65
	.sleb128 51
	.uleb128 0x7
	.4byte	.LASF66
	.sleb128 52
	.uleb128 0x7
	.4byte	.LASF67
	.sleb128 53
	.uleb128 0x7
	.4byte	.LASF68
	.sleb128 54
	.uleb128 0x7
	.4byte	.LASF69
	.sleb128 55
	.uleb128 0x7
	.4byte	.LASF70
	.sleb128 56
	.uleb128 0x7
	.4byte	.LASF71
	.sleb128 57
	.uleb128 0x7
	.4byte	.LASF72
	.sleb128 58
	.uleb128 0x7
	.4byte	.LASF73
	.sleb128 59
	.uleb128 0x7
	.4byte	.LASF74
	.sleb128 60
	.uleb128 0x7
	.4byte	.LASF75
	.sleb128 61
	.uleb128 0x7
	.4byte	.LASF76
	.sleb128 62
	.uleb128 0x7
	.4byte	.LASF77
	.sleb128 63
	.uleb128 0x7
	.4byte	.LASF78
	.sleb128 64
	.uleb128 0x7
	.4byte	.LASF79
	.sleb128 65
	.uleb128 0x7
	.4byte	.LASF80
	.sleb128 66
	.uleb128 0x7
	.4byte	.LASF81
	.sleb128 67
	.uleb128 0x7
	.4byte	.LASF82
	.sleb128 68
	.uleb128 0x7
	.4byte	.LASF83
	.sleb128 69
	.uleb128 0x7
	.4byte	.LASF84
	.sleb128 70
	.uleb128 0x7
	.4byte	.LASF85
	.sleb128 71
	.uleb128 0x7
	.4byte	.LASF86
	.sleb128 72
	.uleb128 0x7
	.4byte	.LASF87
	.sleb128 73
	.uleb128 0x7
	.4byte	.LASF88
	.sleb128 74
	.uleb128 0x7
	.4byte	.LASF89
	.sleb128 75
	.uleb128 0x7
	.4byte	.LASF90
	.sleb128 76
	.uleb128 0x7
	.4byte	.LASF91
	.sleb128 77
	.uleb128 0x7
	.4byte	.LASF92
	.sleb128 78
	.uleb128 0x7
	.4byte	.LASF93
	.sleb128 79
	.uleb128 0x7
	.4byte	.LASF94
	.sleb128 80
	.uleb128 0x7
	.4byte	.LASF95
	.sleb128 81
	.uleb128 0x7
	.4byte	.LASF96
	.sleb128 82
	.uleb128 0x7
	.4byte	.LASF97
	.sleb128 83
	.uleb128 0x7
	.4byte	.LASF98
	.sleb128 84
	.uleb128 0x7
	.4byte	.LASF99
	.sleb128 85
	.uleb128 0x7
	.4byte	.LASF100
	.sleb128 86
	.uleb128 0x7
	.4byte	.LASF101
	.sleb128 87
	.uleb128 0x7
	.4byte	.LASF102
	.sleb128 88
	.uleb128 0x7
	.4byte	.LASF103
	.sleb128 89
	.uleb128 0x7
	.4byte	.LASF104
	.sleb128 90
	.uleb128 0x7
	.4byte	.LASF105
	.sleb128 91
	.uleb128 0x7
	.4byte	.LASF106
	.sleb128 92
	.uleb128 0x7
	.4byte	.LASF107
	.sleb128 93
	.uleb128 0x7
	.4byte	.LASF108
	.sleb128 94
	.uleb128 0x7
	.4byte	.LASF109
	.sleb128 95
	.uleb128 0x7
	.4byte	.LASF110
	.sleb128 96
	.uleb128 0x7
	.4byte	.LASF111
	.sleb128 97
	.uleb128 0x7
	.4byte	.LASF112
	.sleb128 98
	.uleb128 0x7
	.4byte	.LASF113
	.sleb128 99
	.uleb128 0x7
	.4byte	.LASF114
	.sleb128 100
	.uleb128 0x7
	.4byte	.LASF115
	.sleb128 101
	.uleb128 0x7
	.4byte	.LASF116
	.sleb128 102
	.uleb128 0x7
	.4byte	.LASF117
	.sleb128 103
	.uleb128 0x7
	.4byte	.LASF118
	.sleb128 104
	.uleb128 0x7
	.4byte	.LASF119
	.sleb128 105
	.uleb128 0x7
	.4byte	.LASF120
	.sleb128 106
	.uleb128 0x7
	.4byte	.LASF121
	.sleb128 107
	.uleb128 0x7
	.4byte	.LASF122
	.sleb128 108
	.uleb128 0x7
	.4byte	.LASF123
	.sleb128 109
	.uleb128 0x7
	.4byte	.LASF124
	.sleb128 110
	.uleb128 0x7
	.4byte	.LASF125
	.sleb128 111
	.uleb128 0x7
	.4byte	.LASF126
	.sleb128 112
	.uleb128 0x7
	.4byte	.LASF127
	.sleb128 113
	.uleb128 0x7
	.4byte	.LASF128
	.sleb128 114
	.uleb128 0x7
	.4byte	.LASF129
	.sleb128 115
	.uleb128 0x7
	.4byte	.LASF130
	.sleb128 116
	.uleb128 0x7
	.4byte	.LASF131
	.sleb128 117
	.uleb128 0x7
	.4byte	.LASF132
	.sleb128 118
	.uleb128 0x7
	.4byte	.LASF133
	.sleb128 119
	.uleb128 0x7
	.4byte	.LASF134
	.sleb128 120
	.uleb128 0x7
	.4byte	.LASF135
	.sleb128 121
	.uleb128 0x7
	.4byte	.LASF136
	.sleb128 122
	.uleb128 0x7
	.4byte	.LASF137
	.sleb128 123
	.uleb128 0x7
	.4byte	.LASF138
	.sleb128 124
	.uleb128 0x7
	.4byte	.LASF139
	.sleb128 125
	.uleb128 0x7
	.4byte	.LASF140
	.sleb128 126
	.uleb128 0x7
	.4byte	.LASF141
	.sleb128 127
	.uleb128 0x7
	.4byte	.LASF142
	.sleb128 128
	.uleb128 0x7
	.4byte	.LASF143
	.sleb128 129
	.uleb128 0x7
	.4byte	.LASF144
	.sleb128 130
	.uleb128 0x7
	.4byte	.LASF145
	.sleb128 131
	.uleb128 0x7
	.4byte	.LASF146
	.sleb128 132
	.uleb128 0x7
	.4byte	.LASF147
	.sleb128 133
	.uleb128 0x7
	.4byte	.LASF148
	.sleb128 134
	.uleb128 0x7
	.4byte	.LASF149
	.sleb128 135
	.uleb128 0x7
	.4byte	.LASF150
	.sleb128 136
	.uleb128 0x7
	.4byte	.LASF151
	.sleb128 137
	.uleb128 0x7
	.4byte	.LASF152
	.sleb128 138
	.uleb128 0x7
	.4byte	.LASF153
	.sleb128 139
	.uleb128 0x7
	.4byte	.LASF154
	.sleb128 140
	.uleb128 0x7
	.4byte	.LASF155
	.sleb128 141
	.uleb128 0x7
	.4byte	.LASF156
	.sleb128 142
	.uleb128 0x7
	.4byte	.LASF157
	.sleb128 143
	.uleb128 0x7
	.4byte	.LASF158
	.sleb128 144
	.uleb128 0x7
	.4byte	.LASF159
	.sleb128 145
	.uleb128 0x7
	.4byte	.LASF160
	.sleb128 146
	.uleb128 0x7
	.4byte	.LASF161
	.sleb128 147
	.uleb128 0x7
	.4byte	.LASF162
	.sleb128 148
	.uleb128 0x7
	.4byte	.LASF163
	.sleb128 149
	.uleb128 0x7
	.4byte	.LASF164
	.sleb128 150
	.uleb128 0x7
	.4byte	.LASF165
	.sleb128 151
	.uleb128 0x7
	.4byte	.LASF166
	.sleb128 152
	.uleb128 0x7
	.4byte	.LASF167
	.sleb128 153
	.uleb128 0x7
	.4byte	.LASF168
	.sleb128 154
	.uleb128 0x7
	.4byte	.LASF169
	.sleb128 155
	.uleb128 0x7
	.4byte	.LASF170
	.sleb128 156
	.uleb128 0x7
	.4byte	.LASF171
	.sleb128 157
	.uleb128 0x7
	.4byte	.LASF172
	.sleb128 158
	.uleb128 0x7
	.4byte	.LASF173
	.sleb128 159
	.uleb128 0x7
	.4byte	.LASF174
	.sleb128 160
	.uleb128 0x7
	.4byte	.LASF175
	.sleb128 161
	.uleb128 0x7
	.4byte	.LASF176
	.sleb128 162
	.uleb128 0x7
	.4byte	.LASF177
	.sleb128 163
	.uleb128 0x7
	.4byte	.LASF178
	.sleb128 164
	.uleb128 0x7
	.4byte	.LASF179
	.sleb128 165
	.uleb128 0x7
	.4byte	.LASF180
	.sleb128 166
	.uleb128 0x7
	.4byte	.LASF181
	.sleb128 167
	.uleb128 0x7
	.4byte	.LASF182
	.sleb128 168
	.uleb128 0x7
	.4byte	.LASF183
	.sleb128 169
	.uleb128 0x7
	.4byte	.LASF184
	.sleb128 170
	.uleb128 0x7
	.4byte	.LASF185
	.sleb128 171
	.uleb128 0x7
	.4byte	.LASF186
	.sleb128 172
	.uleb128 0x7
	.4byte	.LASF187
	.sleb128 173
	.uleb128 0x7
	.4byte	.LASF188
	.sleb128 174
	.uleb128 0x7
	.4byte	.LASF189
	.sleb128 175
	.uleb128 0x7
	.4byte	.LASF190
	.sleb128 176
	.uleb128 0x7
	.4byte	.LASF191
	.sleb128 177
	.uleb128 0x7
	.4byte	.LASF192
	.sleb128 178
	.uleb128 0x7
	.4byte	.LASF193
	.sleb128 179
	.uleb128 0x7
	.4byte	.LASF194
	.sleb128 180
	.uleb128 0x7
	.4byte	.LASF195
	.sleb128 181
	.uleb128 0x7
	.4byte	.LASF196
	.sleb128 182
	.uleb128 0x7
	.4byte	.LASF197
	.sleb128 183
	.uleb128 0x7
	.4byte	.LASF198
	.sleb128 184
	.uleb128 0x7
	.4byte	.LASF199
	.sleb128 185
	.uleb128 0x7
	.4byte	.LASF200
	.sleb128 186
	.uleb128 0x7
	.4byte	.LASF201
	.sleb128 187
	.uleb128 0x7
	.4byte	.LASF202
	.sleb128 188
	.uleb128 0x7
	.4byte	.LASF203
	.sleb128 189
	.uleb128 0x7
	.4byte	.LASF204
	.sleb128 190
	.uleb128 0x7
	.4byte	.LASF205
	.sleb128 191
	.uleb128 0x7
	.4byte	.LASF206
	.sleb128 192
	.uleb128 0x7
	.4byte	.LASF207
	.sleb128 193
	.uleb128 0x7
	.4byte	.LASF208
	.sleb128 194
	.uleb128 0x7
	.4byte	.LASF209
	.sleb128 195
	.uleb128 0x7
	.4byte	.LASF210
	.sleb128 196
	.uleb128 0x7
	.4byte	.LASF211
	.sleb128 197
	.uleb128 0x7
	.4byte	.LASF212
	.sleb128 198
	.uleb128 0x7
	.4byte	.LASF213
	.sleb128 199
	.uleb128 0x7
	.4byte	.LASF214
	.sleb128 200
	.uleb128 0x7
	.4byte	.LASF215
	.sleb128 201
	.uleb128 0x7
	.4byte	.LASF216
	.sleb128 202
	.uleb128 0x7
	.4byte	.LASF217
	.sleb128 203
	.uleb128 0x7
	.4byte	.LASF218
	.sleb128 204
	.uleb128 0x7
	.4byte	.LASF219
	.sleb128 205
	.uleb128 0x7
	.4byte	.LASF220
	.sleb128 206
	.uleb128 0x7
	.4byte	.LASF221
	.sleb128 207
	.uleb128 0x7
	.4byte	.LASF222
	.sleb128 208
	.uleb128 0x7
	.4byte	.LASF223
	.sleb128 209
	.uleb128 0x7
	.4byte	.LASF224
	.sleb128 210
	.uleb128 0x7
	.4byte	.LASF225
	.sleb128 211
	.uleb128 0x7
	.4byte	.LASF226
	.sleb128 212
	.uleb128 0x7
	.4byte	.LASF227
	.sleb128 213
	.uleb128 0x7
	.4byte	.LASF228
	.sleb128 214
	.uleb128 0x7
	.4byte	.LASF229
	.sleb128 215
	.uleb128 0x7
	.4byte	.LASF230
	.sleb128 216
	.uleb128 0x7
	.4byte	.LASF231
	.sleb128 217
	.uleb128 0x7
	.4byte	.LASF232
	.sleb128 218
	.uleb128 0x7
	.4byte	.LASF233
	.sleb128 219
	.uleb128 0x7
	.4byte	.LASF234
	.sleb128 220
	.uleb128 0x7
	.4byte	.LASF235
	.sleb128 221
	.uleb128 0x7
	.4byte	.LASF236
	.sleb128 222
	.uleb128 0x7
	.4byte	.LASF237
	.sleb128 223
	.uleb128 0x7
	.4byte	.LASF238
	.sleb128 224
	.uleb128 0x7
	.4byte	.LASF239
	.sleb128 225
	.uleb128 0x7
	.4byte	.LASF240
	.sleb128 226
	.uleb128 0x7
	.4byte	.LASF241
	.sleb128 227
	.uleb128 0x7
	.4byte	.LASF242
	.sleb128 228
	.uleb128 0x7
	.4byte	.LASF243
	.sleb128 229
	.uleb128 0x7
	.4byte	.LASF244
	.sleb128 230
	.uleb128 0x7
	.4byte	.LASF245
	.sleb128 231
	.uleb128 0x7
	.4byte	.LASF246
	.sleb128 232
	.uleb128 0x7
	.4byte	.LASF247
	.sleb128 233
	.uleb128 0x7
	.4byte	.LASF248
	.sleb128 234
	.uleb128 0x7
	.4byte	.LASF249
	.sleb128 235
	.uleb128 0x7
	.4byte	.LASF250
	.sleb128 236
	.uleb128 0x7
	.4byte	.LASF251
	.sleb128 237
	.uleb128 0x7
	.4byte	.LASF252
	.sleb128 238
	.uleb128 0x7
	.4byte	.LASF253
	.sleb128 239
	.uleb128 0x7
	.4byte	.LASF254
	.sleb128 240
	.uleb128 0x7
	.4byte	.LASF255
	.sleb128 241
	.uleb128 0x7
	.4byte	.LASF256
	.sleb128 242
	.uleb128 0x7
	.4byte	.LASF257
	.sleb128 243
	.uleb128 0x7
	.4byte	.LASF258
	.sleb128 244
	.uleb128 0x7
	.4byte	.LASF259
	.sleb128 245
	.uleb128 0x7
	.4byte	.LASF260
	.sleb128 246
	.uleb128 0x7
	.4byte	.LASF261
	.sleb128 247
	.uleb128 0x7
	.4byte	.LASF262
	.sleb128 248
	.uleb128 0x7
	.4byte	.LASF263
	.sleb128 249
	.uleb128 0x7
	.4byte	.LASF264
	.sleb128 250
	.uleb128 0x7
	.4byte	.LASF265
	.sleb128 251
	.uleb128 0x7
	.4byte	.LASF266
	.sleb128 252
	.uleb128 0x7
	.4byte	.LASF267
	.sleb128 253
	.uleb128 0x7
	.4byte	.LASF268
	.sleb128 254
	.uleb128 0x7
	.4byte	.LASF269
	.sleb128 255
	.uleb128 0x7
	.4byte	.LASF270
	.sleb128 256
	.uleb128 0x7
	.4byte	.LASF271
	.sleb128 257
	.uleb128 0x7
	.4byte	.LASF272
	.sleb128 258
	.uleb128 0x7
	.4byte	.LASF273
	.sleb128 259
	.uleb128 0x7
	.4byte	.LASF274
	.sleb128 260
	.uleb128 0x7
	.4byte	.LASF275
	.sleb128 261
	.uleb128 0x7
	.4byte	.LASF276
	.sleb128 262
	.uleb128 0x7
	.4byte	.LASF277
	.sleb128 263
	.uleb128 0x7
	.4byte	.LASF278
	.sleb128 264
	.uleb128 0x7
	.4byte	.LASF279
	.sleb128 265
	.uleb128 0x7
	.4byte	.LASF280
	.sleb128 266
	.uleb128 0x7
	.4byte	.LASF281
	.sleb128 267
	.uleb128 0x7
	.4byte	.LASF282
	.sleb128 268
	.uleb128 0x7
	.4byte	.LASF283
	.sleb128 269
	.uleb128 0x7
	.4byte	.LASF284
	.sleb128 270
	.uleb128 0x7
	.4byte	.LASF285
	.sleb128 271
	.uleb128 0x7
	.4byte	.LASF286
	.sleb128 272
	.uleb128 0x7
	.4byte	.LASF287
	.sleb128 273
	.uleb128 0x7
	.4byte	.LASF288
	.sleb128 274
	.uleb128 0x7
	.4byte	.LASF289
	.sleb128 275
	.uleb128 0x7
	.4byte	.LASF290
	.sleb128 276
	.uleb128 0x7
	.4byte	.LASF291
	.sleb128 277
	.uleb128 0x7
	.4byte	.LASF292
	.sleb128 278
	.uleb128 0x7
	.4byte	.LASF293
	.sleb128 279
	.uleb128 0x7
	.4byte	.LASF294
	.sleb128 280
	.uleb128 0x7
	.4byte	.LASF295
	.sleb128 281
	.uleb128 0x7
	.4byte	.LASF296
	.sleb128 282
	.uleb128 0x7
	.4byte	.LASF297
	.sleb128 283
	.uleb128 0x7
	.4byte	.LASF298
	.sleb128 284
	.uleb128 0x7
	.4byte	.LASF299
	.sleb128 285
	.uleb128 0x7
	.4byte	.LASF300
	.sleb128 286
	.uleb128 0x7
	.4byte	.LASF301
	.sleb128 287
	.uleb128 0x7
	.4byte	.LASF302
	.sleb128 288
	.uleb128 0x7
	.4byte	.LASF303
	.sleb128 289
	.uleb128 0x7
	.4byte	.LASF304
	.sleb128 290
	.uleb128 0x7
	.4byte	.LASF305
	.sleb128 291
	.uleb128 0x7
	.4byte	.LASF306
	.sleb128 292
	.uleb128 0x7
	.4byte	.LASF307
	.sleb128 293
	.uleb128 0x7
	.4byte	.LASF308
	.sleb128 294
	.uleb128 0x7
	.4byte	.LASF309
	.sleb128 295
	.uleb128 0x7
	.4byte	.LASF310
	.sleb128 296
	.uleb128 0x7
	.4byte	.LASF311
	.sleb128 297
	.uleb128 0x7
	.4byte	.LASF312
	.sleb128 298
	.uleb128 0x7
	.4byte	.LASF313
	.sleb128 299
	.uleb128 0x7
	.4byte	.LASF314
	.sleb128 300
	.uleb128 0x7
	.4byte	.LASF315
	.sleb128 301
	.uleb128 0x7
	.4byte	.LASF316
	.sleb128 302
	.uleb128 0x7
	.4byte	.LASF317
	.sleb128 303
	.uleb128 0x7
	.4byte	.LASF318
	.sleb128 304
	.uleb128 0x7
	.4byte	.LASF319
	.sleb128 305
	.uleb128 0x7
	.4byte	.LASF320
	.sleb128 306
	.uleb128 0x7
	.4byte	.LASF321
	.sleb128 307
	.uleb128 0x7
	.4byte	.LASF322
	.sleb128 308
	.uleb128 0x7
	.4byte	.LASF323
	.sleb128 309
	.uleb128 0x7
	.4byte	.LASF324
	.sleb128 310
	.uleb128 0x7
	.4byte	.LASF325
	.sleb128 311
	.uleb128 0x7
	.4byte	.LASF326
	.sleb128 312
	.uleb128 0x7
	.4byte	.LASF327
	.sleb128 313
	.uleb128 0x7
	.4byte	.LASF328
	.sleb128 314
	.uleb128 0x7
	.4byte	.LASF329
	.sleb128 315
	.uleb128 0x7
	.4byte	.LASF330
	.sleb128 316
	.uleb128 0x7
	.4byte	.LASF331
	.sleb128 317
	.uleb128 0x7
	.4byte	.LASF332
	.sleb128 318
	.uleb128 0x7
	.4byte	.LASF333
	.sleb128 319
	.uleb128 0x7
	.4byte	.LASF334
	.sleb128 320
	.uleb128 0x7
	.4byte	.LASF335
	.sleb128 321
	.uleb128 0x7
	.4byte	.LASF336
	.sleb128 322
	.uleb128 0x7
	.4byte	.LASF337
	.sleb128 323
	.uleb128 0x7
	.4byte	.LASF338
	.sleb128 324
	.uleb128 0x7
	.4byte	.LASF339
	.sleb128 325
	.uleb128 0x7
	.4byte	.LASF340
	.sleb128 326
	.uleb128 0x7
	.4byte	.LASF341
	.sleb128 327
	.uleb128 0x7
	.4byte	.LASF342
	.sleb128 328
	.uleb128 0x7
	.4byte	.LASF343
	.sleb128 329
	.uleb128 0x7
	.4byte	.LASF344
	.sleb128 330
	.uleb128 0x7
	.4byte	.LASF345
	.sleb128 331
	.uleb128 0x7
	.4byte	.LASF346
	.sleb128 332
	.uleb128 0x7
	.4byte	.LASF347
	.sleb128 333
	.uleb128 0x7
	.4byte	.LASF348
	.sleb128 334
	.uleb128 0x7
	.4byte	.LASF349
	.sleb128 335
	.uleb128 0x7
	.4byte	.LASF350
	.sleb128 336
	.uleb128 0x7
	.4byte	.LASF351
	.sleb128 337
	.uleb128 0x7
	.4byte	.LASF352
	.sleb128 338
	.uleb128 0x7
	.4byte	.LASF353
	.sleb128 339
	.uleb128 0x7
	.4byte	.LASF354
	.sleb128 340
	.uleb128 0x7
	.4byte	.LASF355
	.sleb128 341
	.uleb128 0x7
	.4byte	.LASF356
	.sleb128 342
	.uleb128 0x7
	.4byte	.LASF357
	.sleb128 343
	.uleb128 0x7
	.4byte	.LASF358
	.sleb128 344
	.uleb128 0x7
	.4byte	.LASF359
	.sleb128 345
	.uleb128 0x7
	.4byte	.LASF360
	.sleb128 346
	.uleb128 0x7
	.4byte	.LASF361
	.sleb128 347
	.uleb128 0x7
	.4byte	.LASF362
	.sleb128 348
	.uleb128 0x7
	.4byte	.LASF363
	.sleb128 349
	.uleb128 0x7
	.4byte	.LASF364
	.sleb128 350
	.uleb128 0x7
	.4byte	.LASF365
	.sleb128 351
	.uleb128 0x7
	.4byte	.LASF366
	.sleb128 352
	.uleb128 0x7
	.4byte	.LASF367
	.sleb128 353
	.uleb128 0x7
	.4byte	.LASF368
	.sleb128 354
	.uleb128 0x7
	.4byte	.LASF369
	.sleb128 355
	.uleb128 0x7
	.4byte	.LASF370
	.sleb128 356
	.uleb128 0x7
	.4byte	.LASF371
	.sleb128 357
	.uleb128 0x7
	.4byte	.LASF372
	.sleb128 358
	.uleb128 0x7
	.4byte	.LASF373
	.sleb128 359
	.uleb128 0x7
	.4byte	.LASF374
	.sleb128 360
	.uleb128 0x7
	.4byte	.LASF375
	.sleb128 361
	.uleb128 0x7
	.4byte	.LASF376
	.sleb128 362
	.uleb128 0x7
	.4byte	.LASF377
	.sleb128 363
	.uleb128 0x7
	.4byte	.LASF378
	.sleb128 364
	.uleb128 0x7
	.4byte	.LASF379
	.sleb128 365
	.uleb128 0x7
	.4byte	.LASF380
	.sleb128 366
	.uleb128 0x7
	.4byte	.LASF381
	.sleb128 367
	.uleb128 0x7
	.4byte	.LASF382
	.sleb128 368
	.uleb128 0x7
	.4byte	.LASF383
	.sleb128 369
	.uleb128 0x7
	.4byte	.LASF384
	.sleb128 370
	.uleb128 0x7
	.4byte	.LASF385
	.sleb128 371
	.uleb128 0x7
	.4byte	.LASF386
	.sleb128 372
	.uleb128 0x7
	.4byte	.LASF387
	.sleb128 373
	.uleb128 0x7
	.4byte	.LASF388
	.sleb128 374
	.uleb128 0x7
	.4byte	.LASF389
	.sleb128 375
	.uleb128 0x7
	.4byte	.LASF390
	.sleb128 376
	.uleb128 0x7
	.4byte	.LASF391
	.sleb128 377
	.uleb128 0x7
	.4byte	.LASF392
	.sleb128 378
	.uleb128 0x7
	.4byte	.LASF393
	.sleb128 379
	.uleb128 0x7
	.4byte	.LASF394
	.sleb128 380
	.uleb128 0x7
	.4byte	.LASF395
	.sleb128 381
	.uleb128 0x7
	.4byte	.LASF396
	.sleb128 382
	.uleb128 0x7
	.4byte	.LASF397
	.sleb128 383
	.uleb128 0x7
	.4byte	.LASF398
	.sleb128 384
	.uleb128 0x7
	.4byte	.LASF399
	.sleb128 385
	.uleb128 0x7
	.4byte	.LASF400
	.sleb128 386
	.uleb128 0x7
	.4byte	.LASF401
	.sleb128 387
	.uleb128 0x7
	.4byte	.LASF402
	.sleb128 388
	.uleb128 0x7
	.4byte	.LASF403
	.sleb128 389
	.uleb128 0x7
	.4byte	.LASF404
	.sleb128 390
	.uleb128 0x7
	.4byte	.LASF405
	.sleb128 391
	.uleb128 0x7
	.4byte	.LASF406
	.sleb128 392
	.uleb128 0x7
	.4byte	.LASF407
	.sleb128 393
	.uleb128 0x7
	.4byte	.LASF408
	.sleb128 394
	.uleb128 0x7
	.4byte	.LASF409
	.sleb128 395
	.uleb128 0x7
	.4byte	.LASF410
	.sleb128 396
	.uleb128 0x7
	.4byte	.LASF411
	.sleb128 397
	.uleb128 0x7
	.4byte	.LASF412
	.sleb128 398
	.uleb128 0x7
	.4byte	.LASF413
	.sleb128 399
	.uleb128 0x7
	.4byte	.LASF414
	.sleb128 400
	.uleb128 0x7
	.4byte	.LASF415
	.sleb128 401
	.uleb128 0x7
	.4byte	.LASF416
	.sleb128 402
	.uleb128 0x7
	.4byte	.LASF417
	.sleb128 403
	.uleb128 0x7
	.4byte	.LASF418
	.sleb128 404
	.uleb128 0x7
	.4byte	.LASF419
	.sleb128 405
	.uleb128 0x7
	.4byte	.LASF420
	.sleb128 406
	.uleb128 0x7
	.4byte	.LASF421
	.sleb128 407
	.uleb128 0x7
	.4byte	.LASF422
	.sleb128 408
	.uleb128 0x7
	.4byte	.LASF423
	.sleb128 409
	.uleb128 0x7
	.4byte	.LASF424
	.sleb128 410
	.uleb128 0x7
	.4byte	.LASF425
	.sleb128 411
	.uleb128 0x7
	.4byte	.LASF426
	.sleb128 412
	.uleb128 0x7
	.4byte	.LASF427
	.sleb128 413
	.uleb128 0x7
	.4byte	.LASF428
	.sleb128 414
	.uleb128 0x7
	.4byte	.LASF429
	.sleb128 415
	.uleb128 0x7
	.4byte	.LASF430
	.sleb128 416
	.uleb128 0x7
	.4byte	.LASF431
	.sleb128 417
	.uleb128 0x7
	.4byte	.LASF432
	.sleb128 418
	.uleb128 0x7
	.4byte	.LASF433
	.sleb128 419
	.uleb128 0x7
	.4byte	.LASF434
	.sleb128 420
	.uleb128 0x7
	.4byte	.LASF435
	.sleb128 421
	.uleb128 0x7
	.4byte	.LASF436
	.sleb128 422
	.uleb128 0x7
	.4byte	.LASF437
	.sleb128 423
	.uleb128 0x7
	.4byte	.LASF438
	.sleb128 424
	.uleb128 0x7
	.4byte	.LASF439
	.sleb128 425
	.uleb128 0x7
	.4byte	.LASF440
	.sleb128 426
	.uleb128 0x7
	.4byte	.LASF441
	.sleb128 427
	.uleb128 0x7
	.4byte	.LASF442
	.sleb128 428
	.uleb128 0x7
	.4byte	.LASF443
	.sleb128 429
	.uleb128 0x7
	.4byte	.LASF444
	.sleb128 430
	.uleb128 0x7
	.4byte	.LASF445
	.sleb128 431
	.uleb128 0x7
	.4byte	.LASF446
	.sleb128 432
	.uleb128 0x7
	.4byte	.LASF447
	.sleb128 433
	.uleb128 0x7
	.4byte	.LASF448
	.sleb128 434
	.uleb128 0x7
	.4byte	.LASF449
	.sleb128 435
	.uleb128 0x7
	.4byte	.LASF450
	.sleb128 436
	.uleb128 0x7
	.4byte	.LASF451
	.sleb128 437
	.uleb128 0x7
	.4byte	.LASF452
	.sleb128 438
	.uleb128 0x7
	.4byte	.LASF453
	.sleb128 439
	.uleb128 0x7
	.4byte	.LASF454
	.sleb128 440
	.uleb128 0x7
	.4byte	.LASF455
	.sleb128 441
	.uleb128 0x7
	.4byte	.LASF456
	.sleb128 442
	.uleb128 0x7
	.4byte	.LASF457
	.sleb128 443
	.uleb128 0x7
	.4byte	.LASF458
	.sleb128 444
	.uleb128 0x7
	.4byte	.LASF459
	.sleb128 445
	.uleb128 0x7
	.4byte	.LASF460
	.sleb128 446
	.uleb128 0x7
	.4byte	.LASF461
	.sleb128 447
	.uleb128 0x7
	.4byte	.LASF462
	.sleb128 448
	.uleb128 0x7
	.4byte	.LASF463
	.sleb128 449
	.uleb128 0x7
	.4byte	.LASF464
	.sleb128 450
	.uleb128 0x7
	.4byte	.LASF465
	.sleb128 451
	.uleb128 0x7
	.4byte	.LASF466
	.sleb128 452
	.uleb128 0x7
	.4byte	.LASF467
	.sleb128 453
	.uleb128 0x7
	.4byte	.LASF468
	.sleb128 454
	.uleb128 0x7
	.4byte	.LASF469
	.sleb128 455
	.uleb128 0x7
	.4byte	.LASF470
	.sleb128 456
	.uleb128 0x7
	.4byte	.LASF471
	.sleb128 457
	.uleb128 0x7
	.4byte	.LASF472
	.sleb128 458
	.uleb128 0x7
	.4byte	.LASF473
	.sleb128 459
	.uleb128 0x7
	.4byte	.LASF474
	.sleb128 460
	.uleb128 0x7
	.4byte	.LASF475
	.sleb128 461
	.uleb128 0x7
	.4byte	.LASF476
	.sleb128 462
	.uleb128 0x7
	.4byte	.LASF477
	.sleb128 463
	.uleb128 0x7
	.4byte	.LASF478
	.sleb128 464
	.uleb128 0x7
	.4byte	.LASF479
	.sleb128 465
	.uleb128 0x7
	.4byte	.LASF480
	.sleb128 466
	.uleb128 0x7
	.4byte	.LASF481
	.sleb128 467
	.uleb128 0x7
	.4byte	.LASF482
	.sleb128 468
	.uleb128 0x7
	.4byte	.LASF483
	.sleb128 469
	.uleb128 0x7
	.4byte	.LASF484
	.sleb128 470
	.uleb128 0x7
	.4byte	.LASF485
	.sleb128 471
	.uleb128 0x7
	.4byte	.LASF486
	.sleb128 472
	.uleb128 0x7
	.4byte	.LASF487
	.sleb128 473
	.uleb128 0x7
	.4byte	.LASF488
	.sleb128 474
	.uleb128 0x7
	.4byte	.LASF489
	.sleb128 475
	.uleb128 0x7
	.4byte	.LASF490
	.sleb128 476
	.uleb128 0x7
	.4byte	.LASF491
	.sleb128 477
	.uleb128 0x7
	.4byte	.LASF492
	.sleb128 478
	.uleb128 0x7
	.4byte	.LASF493
	.sleb128 479
	.uleb128 0x7
	.4byte	.LASF494
	.sleb128 480
	.uleb128 0x7
	.4byte	.LASF495
	.sleb128 481
	.uleb128 0x7
	.4byte	.LASF496
	.sleb128 482
	.uleb128 0x7
	.4byte	.LASF497
	.sleb128 483
	.uleb128 0x7
	.4byte	.LASF498
	.sleb128 484
	.uleb128 0x7
	.4byte	.LASF499
	.sleb128 485
	.uleb128 0x7
	.4byte	.LASF500
	.sleb128 486
	.uleb128 0x7
	.4byte	.LASF501
	.sleb128 487
	.uleb128 0x7
	.4byte	.LASF502
	.sleb128 488
	.uleb128 0x7
	.4byte	.LASF503
	.sleb128 489
	.uleb128 0x7
	.4byte	.LASF504
	.sleb128 490
	.uleb128 0x7
	.4byte	.LASF505
	.sleb128 491
	.uleb128 0x7
	.4byte	.LASF506
	.sleb128 492
	.uleb128 0x7
	.4byte	.LASF507
	.sleb128 493
	.uleb128 0x7
	.4byte	.LASF508
	.sleb128 494
	.uleb128 0x7
	.4byte	.LASF509
	.sleb128 495
	.uleb128 0x7
	.4byte	.LASF510
	.sleb128 496
	.uleb128 0x7
	.4byte	.LASF511
	.sleb128 497
	.uleb128 0x7
	.4byte	.LASF512
	.sleb128 498
	.uleb128 0x7
	.4byte	.LASF513
	.sleb128 499
	.uleb128 0x7
	.4byte	.LASF514
	.sleb128 500
	.uleb128 0x7
	.4byte	.LASF515
	.sleb128 501
	.uleb128 0x7
	.4byte	.LASF516
	.sleb128 502
	.uleb128 0x7
	.4byte	.LASF517
	.sleb128 503
	.uleb128 0x7
	.4byte	.LASF518
	.sleb128 504
	.uleb128 0x7
	.4byte	.LASF519
	.sleb128 505
	.uleb128 0x7
	.4byte	.LASF520
	.sleb128 506
	.uleb128 0x7
	.4byte	.LASF521
	.sleb128 507
	.uleb128 0x7
	.4byte	.LASF522
	.sleb128 508
	.uleb128 0x7
	.4byte	.LASF523
	.sleb128 509
	.uleb128 0x7
	.4byte	.LASF524
	.sleb128 510
	.uleb128 0x7
	.4byte	.LASF525
	.sleb128 511
	.uleb128 0x7
	.4byte	.LASF526
	.sleb128 512
	.uleb128 0x7
	.4byte	.LASF527
	.sleb128 513
	.uleb128 0x7
	.4byte	.LASF528
	.sleb128 514
	.uleb128 0x7
	.4byte	.LASF529
	.sleb128 515
	.uleb128 0x7
	.4byte	.LASF530
	.sleb128 516
	.uleb128 0x7
	.4byte	.LASF531
	.sleb128 517
	.uleb128 0x7
	.4byte	.LASF532
	.sleb128 518
	.uleb128 0x7
	.4byte	.LASF533
	.sleb128 519
	.uleb128 0x7
	.4byte	.LASF534
	.sleb128 520
	.uleb128 0x7
	.4byte	.LASF535
	.sleb128 521
	.uleb128 0x7
	.4byte	.LASF536
	.sleb128 522
	.uleb128 0x7
	.4byte	.LASF537
	.sleb128 1
	.uleb128 0x7
	.4byte	.LASF538
	.sleb128 523
	.uleb128 0x7
	.4byte	.LASF539
	.sleb128 524
	.uleb128 0x7
	.4byte	.LASF540
	.sleb128 525
	.uleb128 0x7
	.4byte	.LASF541
	.sleb128 526
	.uleb128 0x7
	.4byte	.LASF542
	.sleb128 527
	.uleb128 0x7
	.4byte	.LASF543
	.sleb128 528
	.uleb128 0x7
	.4byte	.LASF544
	.sleb128 529
	.uleb128 0x7
	.4byte	.LASF545
	.sleb128 530
	.uleb128 0x7
	.4byte	.LASF546
	.sleb128 531
	.uleb128 0x7
	.4byte	.LASF547
	.sleb128 2
	.uleb128 0x7
	.4byte	.LASF548
	.sleb128 532
	.uleb128 0x7
	.4byte	.LASF549
	.sleb128 533
	.uleb128 0x7
	.4byte	.LASF550
	.sleb128 534
	.uleb128 0x7
	.4byte	.LASF551
	.sleb128 535
	.uleb128 0x7
	.4byte	.LASF552
	.sleb128 536
	.uleb128 0x7
	.4byte	.LASF553
	.sleb128 537
	.uleb128 0x7
	.4byte	.LASF554
	.sleb128 538
	.uleb128 0x7
	.4byte	.LASF555
	.sleb128 539
	.uleb128 0x7
	.4byte	.LASF556
	.sleb128 540
	.uleb128 0x7
	.4byte	.LASF557
	.sleb128 541
	.uleb128 0x7
	.4byte	.LASF558
	.sleb128 542
	.uleb128 0x7
	.4byte	.LASF559
	.sleb128 543
	.uleb128 0x7
	.4byte	.LASF560
	.sleb128 544
	.uleb128 0x7
	.4byte	.LASF561
	.sleb128 545
	.uleb128 0x7
	.4byte	.LASF562
	.sleb128 546
	.uleb128 0x7
	.4byte	.LASF563
	.sleb128 547
	.uleb128 0x7
	.4byte	.LASF564
	.sleb128 548
	.uleb128 0x7
	.4byte	.LASF565
	.sleb128 549
	.uleb128 0x7
	.4byte	.LASF566
	.sleb128 550
	.uleb128 0x7
	.4byte	.LASF567
	.sleb128 551
	.uleb128 0x7
	.4byte	.LASF568
	.sleb128 552
	.uleb128 0x7
	.4byte	.LASF569
	.sleb128 553
	.uleb128 0x7
	.4byte	.LASF570
	.sleb128 554
	.uleb128 0x7
	.4byte	.LASF571
	.sleb128 555
	.uleb128 0x7
	.4byte	.LASF572
	.sleb128 556
	.uleb128 0x7
	.4byte	.LASF573
	.sleb128 557
	.uleb128 0x7
	.4byte	.LASF574
	.sleb128 558
	.uleb128 0x7
	.4byte	.LASF575
	.sleb128 559
	.uleb128 0x7
	.4byte	.LASF576
	.sleb128 560
	.uleb128 0x7
	.4byte	.LASF577
	.sleb128 561
	.uleb128 0x7
	.4byte	.LASF578
	.sleb128 562
	.uleb128 0x7
	.4byte	.LASF579
	.sleb128 563
	.uleb128 0x7
	.4byte	.LASF580
	.sleb128 564
	.uleb128 0x7
	.4byte	.LASF581
	.sleb128 565
	.uleb128 0x7
	.4byte	.LASF582
	.sleb128 566
	.uleb128 0x7
	.4byte	.LASF583
	.sleb128 567
	.uleb128 0x7
	.4byte	.LASF584
	.sleb128 568
	.uleb128 0x7
	.4byte	.LASF585
	.sleb128 569
	.uleb128 0x7
	.4byte	.LASF586
	.sleb128 570
	.uleb128 0x7
	.4byte	.LASF587
	.sleb128 571
	.uleb128 0x7
	.4byte	.LASF588
	.sleb128 572
	.uleb128 0x7
	.4byte	.LASF589
	.sleb128 573
	.uleb128 0x7
	.4byte	.LASF590
	.sleb128 574
	.uleb128 0x7
	.4byte	.LASF591
	.sleb128 575
	.uleb128 0x7
	.4byte	.LASF592
	.sleb128 576
	.uleb128 0x7
	.4byte	.LASF593
	.sleb128 577
	.uleb128 0x7
	.4byte	.LASF594
	.sleb128 578
	.uleb128 0x7
	.4byte	.LASF595
	.sleb128 579
	.uleb128 0x7
	.4byte	.LASF596
	.sleb128 580
	.uleb128 0x7
	.4byte	.LASF597
	.sleb128 581
	.uleb128 0x7
	.4byte	.LASF598
	.sleb128 582
	.uleb128 0x7
	.4byte	.LASF599
	.sleb128 583
	.uleb128 0x7
	.4byte	.LASF600
	.sleb128 584
	.uleb128 0x7
	.4byte	.LASF601
	.sleb128 585
	.uleb128 0x7
	.4byte	.LASF602
	.sleb128 586
	.uleb128 0x7
	.4byte	.LASF603
	.sleb128 587
	.uleb128 0x7
	.4byte	.LASF604
	.sleb128 588
	.uleb128 0x7
	.4byte	.LASF605
	.sleb128 589
	.uleb128 0x7
	.4byte	.LASF606
	.sleb128 590
	.uleb128 0x7
	.4byte	.LASF607
	.sleb128 591
	.uleb128 0x7
	.4byte	.LASF608
	.sleb128 592
	.uleb128 0x7
	.4byte	.LASF609
	.sleb128 593
	.uleb128 0x7
	.4byte	.LASF610
	.sleb128 594
	.uleb128 0x7
	.4byte	.LASF611
	.sleb128 595
	.uleb128 0x7
	.4byte	.LASF612
	.sleb128 596
	.uleb128 0x7
	.4byte	.LASF613
	.sleb128 597
	.uleb128 0x7
	.4byte	.LASF614
	.sleb128 598
	.uleb128 0x7
	.4byte	.LASF615
	.sleb128 599
	.uleb128 0x7
	.4byte	.LASF616
	.sleb128 600
	.uleb128 0x7
	.4byte	.LASF617
	.sleb128 601
	.uleb128 0x7
	.4byte	.LASF618
	.sleb128 602
	.uleb128 0x7
	.4byte	.LASF619
	.sleb128 603
	.uleb128 0x7
	.4byte	.LASF620
	.sleb128 604
	.uleb128 0x7
	.4byte	.LASF621
	.sleb128 605
	.uleb128 0x7
	.4byte	.LASF622
	.sleb128 606
	.uleb128 0x7
	.4byte	.LASF623
	.sleb128 607
	.uleb128 0x7
	.4byte	.LASF624
	.sleb128 608
	.uleb128 0x7
	.4byte	.LASF625
	.sleb128 609
	.uleb128 0x7
	.4byte	.LASF626
	.sleb128 610
	.uleb128 0x7
	.4byte	.LASF627
	.sleb128 611
	.uleb128 0x7
	.4byte	.LASF628
	.sleb128 612
	.uleb128 0x7
	.4byte	.LASF629
	.sleb128 613
	.uleb128 0x7
	.4byte	.LASF630
	.sleb128 614
	.uleb128 0x7
	.4byte	.LASF631
	.sleb128 615
	.uleb128 0x7
	.4byte	.LASF632
	.sleb128 616
	.uleb128 0x7
	.4byte	.LASF633
	.sleb128 617
	.uleb128 0x7
	.4byte	.LASF634
	.sleb128 618
	.uleb128 0x7
	.4byte	.LASF635
	.sleb128 619
	.uleb128 0x7
	.4byte	.LASF636
	.sleb128 620
	.uleb128 0x7
	.4byte	.LASF637
	.sleb128 621
	.uleb128 0x7
	.4byte	.LASF638
	.sleb128 622
	.uleb128 0x7
	.4byte	.LASF639
	.sleb128 623
	.uleb128 0x7
	.4byte	.LASF640
	.sleb128 624
	.uleb128 0x7
	.4byte	.LASF641
	.sleb128 625
	.uleb128 0x7
	.4byte	.LASF642
	.sleb128 626
	.uleb128 0x7
	.4byte	.LASF643
	.sleb128 627
	.uleb128 0x7
	.4byte	.LASF644
	.sleb128 628
	.uleb128 0x7
	.4byte	.LASF645
	.sleb128 629
	.uleb128 0x7
	.4byte	.LASF646
	.sleb128 630
	.uleb128 0x7
	.4byte	.LASF647
	.sleb128 631
	.uleb128 0x7
	.4byte	.LASF648
	.sleb128 632
	.uleb128 0x7
	.4byte	.LASF649
	.sleb128 633
	.byte	0
	.uleb128 0x3
	.byte	0x1
	.byte	0x2
	.4byte	.LASF650
	.uleb128 0x4
	.4byte	.LASF651
	.byte	0x4
	.byte	0xa
	.4byte	0x73
	.uleb128 0x8
	.byte	0x8
	.byte	0x4
	.byte	0xd
	.4byte	0x120f
	.uleb128 0x9
	.ascii	"ptr\000"
	.byte	0x4
	.byte	0xe
	.4byte	0x122e
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0xa
	.4byte	.LASF652
	.byte	0x4
	.byte	0xf
	.4byte	0x2c
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.byte	0
	.uleb128 0xb
	.4byte	.LASF679
	.byte	0x8
	.byte	0x4
	.byte	0xc
	.4byte	0x122e
	.uleb128 0xc
	.ascii	"s\000"
	.byte	0x4
	.byte	0x10
	.4byte	0x11ea
	.uleb128 0xc
	.ascii	"x\000"
	.byte	0x4
	.byte	0x11
	.4byte	0x11df
	.byte	0
	.uleb128 0xd
	.byte	0x4
	.4byte	0x120f
	.uleb128 0x4
	.4byte	.LASF653
	.byte	0x4
	.byte	0x14
	.4byte	0x120f
	.uleb128 0xe
	.4byte	.LASF656
	.byte	0x10
	.byte	0x5
	.byte	0x14
	.4byte	0x1268
	.uleb128 0xa
	.4byte	.LASF654
	.byte	0x5
	.byte	0x15
	.4byte	0x1234
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0xa
	.4byte	.LASF655
	.byte	0x5
	.byte	0x16
	.4byte	0x1268
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.byte	0
	.uleb128 0xd
	.byte	0x4
	.4byte	0x1234
	.uleb128 0xe
	.4byte	.LASF657
	.byte	0x10
	.byte	0x5
	.byte	0x19
	.4byte	0x1289
	.uleb128 0xa
	.4byte	.LASF656
	.byte	0x5
	.byte	0x1a
	.4byte	0x123f
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.byte	0
	.uleb128 0xe
	.4byte	.LASF658
	.byte	0x10
	.byte	0x6
	.byte	0x14
	.4byte	0x12a2
	.uleb128 0x9
	.ascii	"c\000"
	.byte	0x6
	.byte	0x15
	.4byte	0x126e
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.byte	0
	.uleb128 0xf
	.4byte	.LASF659
	.2byte	0x3238
	.byte	0x7
	.byte	0x19
	.4byte	0x1363
	.uleb128 0xa
	.4byte	.LASF660
	.byte	0x7
	.byte	0x1b
	.4byte	0x1363
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0xa
	.4byte	.LASF661
	.byte	0x7
	.byte	0x1d
	.4byte	0x1363
	.byte	0x3
	.byte	0x23
	.uleb128 0x1900
	.uleb128 0xa
	.4byte	.LASF662
	.byte	0x7
	.byte	0x20
	.4byte	0x137a
	.byte	0x3
	.byte	0x23
	.uleb128 0x3200
	.uleb128 0xa
	.4byte	.LASF663
	.byte	0x7
	.byte	0x23
	.4byte	0x137a
	.byte	0x3
	.byte	0x23
	.uleb128 0x3204
	.uleb128 0xa
	.4byte	.LASF664
	.byte	0x7
	.byte	0x26
	.4byte	0x1386
	.byte	0x3
	.byte	0x23
	.uleb128 0x3208
	.uleb128 0xa
	.4byte	.LASF665
	.byte	0x7
	.byte	0x29
	.4byte	0x9f
	.byte	0x3
	.byte	0x23
	.uleb128 0x320c
	.uleb128 0xa
	.4byte	.LASF666
	.byte	0x7
	.byte	0x2b
	.4byte	0x8c
	.byte	0x3
	.byte	0x23
	.uleb128 0x3210
	.uleb128 0xa
	.4byte	.LASF667
	.byte	0x7
	.byte	0x2e
	.4byte	0x1289
	.byte	0x3
	.byte	0x23
	.uleb128 0x3218
	.uleb128 0xa
	.4byte	.LASF668
	.byte	0x7
	.byte	0x31
	.4byte	0x1392
	.byte	0x3
	.byte	0x23
	.uleb128 0x3228
	.uleb128 0xa
	.4byte	.LASF669
	.byte	0x7
	.byte	0x33
	.4byte	0x137a
	.byte	0x3
	.byte	0x23
	.uleb128 0x322c
	.uleb128 0xa
	.4byte	.LASF670
	.byte	0x7
	.byte	0x36
	.4byte	0x137a
	.byte	0x3
	.byte	0x23
	.uleb128 0x3230
	.uleb128 0xa
	.4byte	.LASF671
	.byte	0x7
	.byte	0x39
	.4byte	0xaa
	.byte	0x3
	.byte	0x23
	.uleb128 0x3234
	.byte	0
	.uleb128 0x10
	.4byte	0x8c
	.4byte	0x1374
	.uleb128 0x11
	.4byte	0x2c
	.2byte	0x63f
	.byte	0
	.uleb128 0x12
	.4byte	.LASF672
	.byte	0x1
	.uleb128 0xd
	.byte	0x4
	.4byte	0x1374
	.uleb128 0x12
	.4byte	.LASF673
	.byte	0x1
	.uleb128 0xd
	.byte	0x4
	.4byte	0x1380
	.uleb128 0x12
	.4byte	.LASF674
	.byte	0x1
	.uleb128 0xd
	.byte	0x4
	.4byte	0x138c
	.uleb128 0x13
	.byte	0x1
	.4byte	.LASF680
	.byte	0x1
	.byte	0x4d
	.byte	0x1
	.4byte	.LFB37
	.4byte	.LFE37
	.byte	0x2
	.byte	0x7d
	.sleb128 0
	.uleb128 0x14
	.4byte	.LASF681
	.byte	0x9
	.byte	0x16
	.4byte	0x7a
	.byte	0x1
	.byte	0x1
	.byte	0
	.section	.debug_abbrev,"",%progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x10
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x4
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x28
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1c
	.uleb128 0xd
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x13
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x17
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0x5
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0x5
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x13
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3c
	.uleb128 0xc
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3c
	.uleb128 0xc
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_aranges,"",%progbits
	.4byte	0x1c
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0
	.2byte	0
	.2byte	0
	.4byte	.Ltext0
	.4byte	.Letext0-.Ltext0
	.4byte	0
	.4byte	0
	.section	.debug_line,"",%progbits
.Ldebug_line0:
	.section	.debug_str,"MS",%progbits,1
.LASF340:
	.ascii	"MON_ERR_SPAWN_DOMAIN\000"
.LASF365:
	.ascii	"MON_ERR_INCOMPLETE_ROUTE\000"
.LASF149:
	.ascii	"LIB_ERR_SLOT_ALLOC\000"
.LASF579:
	.ascii	"NFS_ERR_FBIG\000"
.LASF231:
	.ascii	"LIB_ERR_LMP_CHAN_SEND\000"
.LASF23:
	.ascii	"SYS_ERR_LMP_NO_TARGET\000"
.LASF443:
	.ascii	"SPAWN_ERR_COPY_PERF_MON\000"
.LASF114:
	.ascii	"LIB_ERR_MALLOC_FAIL\000"
.LASF529:
	.ascii	"ACPI_ERR_SET_IRQ\000"
.LASF260:
	.ascii	"LIB_ERR_SEND_RUN_FUNC_REQUEST\000"
.LASF321:
	.ascii	"MON_ERR_IDC_BIND_NOT_SAME_CORE\000"
.LASF188:
	.ascii	"LIB_ERR_MEMOBJ_DUPLICATE_FILL\000"
.LASF214:
	.ascii	"LIB_ERR_LMP_RECV_BUF_OVERFLOW\000"
.LASF677:
	.ascii	"/home/panandr/git/aos\000"
.LASF428:
	.ascii	"SPAWN_ERR_SETUP_INHERITED_CAPS\000"
.LASF265:
	.ascii	"LIB_ERR_MORECORE_INIT\000"
.LASF373:
	.ascii	"ROUTE_ERR_BIND\000"
.LASF350:
	.ascii	"MON_ERR_WRONG_CAP_TYPE\000"
.LASF618:
	.ascii	"OCT_ERR_UNSUPPORTED_BINDING\000"
.LASF142:
	.ascii	"LIB_ERR_SLOT_ALLOC_NO_SPACE\000"
.LASF679:
	.ascii	"header\000"
.LASF97:
	.ascii	"SYS_ERR_VMKIT_ENDPOINT_INVALID\000"
.LASF197:
	.ascii	"LIB_ERR_PMAP_MODIFY_FLAGS\000"
.LASF649:
	.ascii	"ERR_NOTIMP\000"
.LASF198:
	.ascii	"LIB_ERR_PMAP_GET_PTABLE\000"
.LASF518:
	.ascii	"PCI_ERR_MINT_IOCAP\000"
.LASF416:
	.ascii	"SPAWN_ERR_MAP_ARGSPG_TO_NEW\000"
.LASF534:
	.ascii	"SKB_ERR_RUN\000"
.LASF399:
	.ascii	"SPAWN_ERR_FREE\000"
.LASF259:
	.ascii	"LIB_ERR_NO_SPANNED_DISP\000"
.LASF131:
	.ascii	"LIB_ERR_CAP_RETYPE\000"
.LASF96:
	.ascii	"SYS_ERR_VMKIT_ENDPOINT\000"
.LASF74:
	.ascii	"SYS_ERR_IRQ_NO_LISTENER\000"
.LASF545:
	.ascii	"FS_ERR_BULK_NOT_INIT\000"
.LASF477:
	.ascii	"INIT_ERR_SETUP_MEM_SERV_CHAN\000"
.LASF590:
	.ascii	"NFS_ERR_BAD_COOKIE\000"
.LASF423:
	.ascii	"SPAWN_ERR_MAP_MODULE\000"
.LASF512:
	.ascii	"TRACE_ERR_MAP_BUF\000"
.LASF319:
	.ascii	"MON_CLIENT_ERR_SPAN_DOMAIN_REQUEST\000"
.LASF184:
	.ascii	"LIB_ERR_MEMOBJ_FRAME_ALLOC\000"
.LASF493:
	.ascii	"ETHERSRV_ERR_TOO_MANY_VNICS\000"
.LASF415:
	.ascii	"SPAWN_ERR_MAP_DISPATCHER_TO_SELF\000"
.LASF285:
	.ascii	"LIB_ERR_NO_EVENT\000"
.LASF63:
	.ascii	"SYS_ERR_VNODE_SLOT_RESERVED\000"
.LASF354:
	.ascii	"MON_ERR_UNICAST_SET\000"
.LASF505:
	.ascii	"FILTER_ERR_BUFF_NOT_FOUND\000"
.LASF310:
	.ascii	"CHIPS_ERR_GET_SERVICE_IREF\000"
.LASF432:
	.ascii	"SPAWN_ERR_FDSPG_OVERFLOW\000"
.LASF190:
	.ascii	"LIB_ERR_PMAP_CURRENT_INIT\000"
.LASF22:
	.ascii	"SYS_ERR_INVALID_USER_BUFFER\000"
.LASF202:
	.ascii	"LIB_ERR_PMAP_EXISTING_MAPPING\000"
.LASF592:
	.ascii	"NFS_ERR_TOOSMALL\000"
.LASF171:
	.ascii	"LIB_ERR_MEMOBJ_CREATE_ANON\000"
.LASF179:
	.ascii	"LIB_ERR_MEMOBJ_UNPIN_REGION\000"
.LASF240:
	.ascii	"LIB_ERR_RCK_NOTIFY\000"
.LASF535:
	.ascii	"SKB_ERR_GOAL_FAILURE\000"
.LASF385:
	.ascii	"SPAWN_ERR_SPAN\000"
.LASF673:
	.ascii	"deferred_event\000"
.LASF242:
	.ascii	"LIB_ERR_MONITOR_CLIENT_BIND\000"
.LASF446:
	.ascii	"SPAWN_ERR_DOMAIN_NOTFOUND\000"
.LASF338:
	.ascii	"MON_ERR_REMOTE_CAP_RETRY\000"
.LASF666:
	.ascii	"timeslice\000"
.LASF407:
	.ascii	"SPAWN_ERR_CREATE_DISPATCHER_FRAME\000"
.LASF379:
	.ascii	"ROUTE_ERR_CALL_INIT\000"
.LASF129:
	.ascii	"LIB_ERR_CAP_MINT\000"
.LASF86:
	.ascii	"SYS_ERR_KERNEL_MEM_LOOKUP\000"
.LASF352:
	.ascii	"MON_ERR_ROUTE_RESET\000"
.LASF530:
	.ascii	"ACPI_ERR_NO_MADT_TABLE\000"
.LASF404:
	.ascii	"SPAWN_ERR_CREATE_VNODE\000"
.LASF595:
	.ascii	"NFS_ERR_JUKEBOX\000"
.LASF134:
	.ascii	"LIB_ERR_CAP_DESTROY\000"
.LASF132:
	.ascii	"LIB_ERR_DEVFRAME_TYPE\000"
.LASF309:
	.ascii	"CHIPS_ERR_GET_SERVICE_REFERENCE\000"
.LASF36:
	.ascii	"SYS_ERR_CNODE_RIGHTS\000"
.LASF262:
	.ascii	"LIB_ERR_CAP_COPY_FAIL\000"
.LASF280:
	.ascii	"LIB_ERR_THREAD_DETACHED\000"
.LASF612:
	.ascii	"OCT_ERR_NO_RECORD\000"
.LASF180:
	.ascii	"LIB_ERR_MEMOBJ_FILL\000"
.LASF411:
	.ascii	"SPAWN_ERR_COPY_FDCAP\000"
.LASF597:
	.ascii	"LWIP_ERR_BUF\000"
.LASF78:
	.ascii	"SYS_ERR_DISP_CSPACE_INVALID\000"
.LASF366:
	.ascii	"MON_ERR_RSRC_ALLOC\000"
.LASF136:
	.ascii	"LIB_ERR_ENDPOINT_CREATE\000"
.LASF680:
	.ascii	"dummy\000"
.LASF177:
	.ascii	"LIB_ERR_MEMOBJ_UNMAP_REGION\000"
.LASF361:
	.ascii	"MON_ERR_MULTICAST_CONNECT\000"
.LASF557:
	.ascii	"VFS_ERR_BCACHE_LIMIT\000"
.LASF182:
	.ascii	"LIB_ERR_MEMOBJ_PAGER_FREE\000"
.LASF287:
	.ascii	"LIB_ERR_EVENT_ALREADY_RUN\000"
.LASF186:
	.ascii	"LIB_ERR_MEMOBJ_UNFILL_TOO_HIGH_OFFSET\000"
.LASF5:
	.ascii	"long int\000"
.LASF585:
	.ascii	"NFS_ERR_DQUOT\000"
.LASF229:
	.ascii	"LIB_ERR_LMP_CHAN_RECV\000"
.LASF619:
	.ascii	"OCT_ERR_PARSER_FAIL\000"
.LASF243:
	.ascii	"LIB_ERR_MONITOR_CLIENT_ACCEPT\000"
.LASF647:
	.ascii	"FS_CACHE_NOTPRESENT\000"
.LASF193:
	.ascii	"LIB_ERR_PMAP_MAP\000"
.LASF451:
	.ascii	"ELF_ERR_ALLOCATE\000"
.LASF600:
	.ascii	"LWIP_ERR_ABRT\000"
.LASF275:
	.ascii	"LIB_ERR_SERIAL_BIND\000"
.LASF547:
	.ascii	"VFS_ERR_EOF\000"
.LASF549:
	.ascii	"VFS_ERR_MOUNTPOINT_IN_USE\000"
.LASF447:
	.ascii	"SPAWN_ERR_DOMAIN_RUNNING\000"
.LASF209:
	.ascii	"LIB_ERR_INVOKE_PERFMON_SETUP\000"
.LASF452:
	.ascii	"ELF_ERR_NOT_PAGE_ALIGNED\000"
.LASF357:
	.ascii	"MON_ERR_BCAST_CONNECT\000"
.LASF435:
	.ascii	"SPAWN_ERR_DELETE_ROOTCN\000"
.LASF664:
	.ascii	"deferred_events\000"
.LASF222:
	.ascii	"LIB_ERR_LMP_ENDPOINT_REGISTER\000"
.LASF127:
	.ascii	"LIB_ERR_RAM_ALLOC_WRONG_SIZE\000"
.LASF25:
	.ascii	"SYS_ERR_LMP_BUF_OVERFLOW\000"
.LASF457:
	.ascii	"MM_ERR_SLOT_ALLOC_INIT\000"
.LASF161:
	.ascii	"LIB_ERR_VSPACE_PAGEFAULT_ADDR_NOT_FOUND\000"
.LASF431:
	.ascii	"SPAWN_ERR_SETUP_FDCAP\000"
.LASF526:
	.ascii	"ACPI_ERR_NO_MCFG_TABLE\000"
.LASF528:
	.ascii	"ACPI_ERR_GET_RESOURCES\000"
.LASF66:
	.ascii	"SYS_ERR_VNODE_LOOKUP_NEXT\000"
.LASF125:
	.ascii	"LIB_ERR_CNODE_CREATE_FROM_MEM\000"
.LASF413:
	.ascii	"SPAWN_ERR_CREATE_SLOTALLOC_CNODE\000"
.LASF17:
	.ascii	"SYS_ERR_ILLEGAL_SYSCALL\000"
.LASF314:
	.ascii	"CHIPS_ERR_PUT_CAP\000"
.LASF258:
	.ascii	"LIB_ERR_BULK_UNKNOWN_ID\000"
.LASF583:
	.ascii	"NFS_ERR_NAMETOOLONG\000"
.LASF658:
	.ascii	"core_state_arch\000"
.LASF1:
	.ascii	"signed char\000"
.LASF224:
	.ascii	"LIB_ERR_CHAN_DEREGISTER_SEND\000"
.LASF6:
	.ascii	"uint8_t\000"
.LASF166:
	.ascii	"LIB_ERR_VREGION_MAP_FIXED\000"
.LASF133:
	.ascii	"LIB_ERR_CAP_DELETE\000"
.LASF438:
	.ascii	"SPAWN_ERR_FREE_TASKCN\000"
.LASF204:
	.ascii	"LIB_ERR_SERIALISE_BUFOVERFLOW\000"
.LASF316:
	.ascii	"CHIPS_ERR_OUT_OF_SEMAPHORES\000"
.LASF646:
	.ascii	"FS_CACHE_FULL\000"
.LASF580:
	.ascii	"NFS_ERR_NOSPC\000"
.LASF602:
	.ascii	"LWIP_ERR_CLSD\000"
.LASF498:
	.ascii	"ETHERSRV_ERR_FRAME_CAP_MAP\000"
.LASF98:
	.ascii	"SYS_ERR_SERIAL_PORT_INVALID\000"
.LASF393:
	.ascii	"SPAWN_ERR_DETERMINE_CPUTYPE\000"
.LASF44:
	.ascii	"SYS_ERR_INVALID_SOURCE_TYPE\000"
.LASF487:
	.ascii	"INIT_ERR_COPY_PACN_CAP\000"
.LASF2:
	.ascii	"unsigned char\000"
.LASF328:
	.ascii	"MON_ERR_NO_MONITOR_FOR_CORE\000"
.LASF67:
	.ascii	"SYS_ERR_VNODE_NOT_INSTALLED\000"
.LASF232:
	.ascii	"LIB_ERR_LMP_CHAN_BIND\000"
.LASF290:
	.ascii	"LIB_ERR_LDT_FULL\000"
.LASF555:
	.ascii	"VFS_ERR_IN_STAT\000"
.LASF128:
	.ascii	"LIB_ERR_RAM_ALLOC_MS_CONSTRAINTS\000"
.LASF58:
	.ascii	"SYS_ERR_RETRY_THROUGH_MONITOR\000"
.LASF668:
	.ascii	"trace_buf\000"
.LASF341:
	.ascii	"MON_ERR_INTERN_NEW_MONITOR\000"
.LASF660:
	.ascii	"trap_stack\000"
.LASF488:
	.ascii	"INIT_ERR_COPY_IRQ_CAP\000"
.LASF674:
	.ascii	"trace_buffer\000"
.LASF544:
	.ascii	"FS_ERR_NOTEMPTY\000"
.LASF442:
	.ascii	"SPAWN_ERR_COPY_IO_CAP\000"
.LASF626:
	.ascii	"OCT_ERR_CAP_OVERWRITE\000"
.LASF236:
	.ascii	"LIB_ERR_LMP_ALLOC_RECV_SLOT\000"
.LASF248:
	.ascii	"LIB_ERR_BIND_UMP_REQ\000"
.LASF153:
	.ascii	"LIB_ERR_VSPACE_INIT\000"
.LASF278:
	.ascii	"LIB_ERR_THREAD_JOIN\000"
.LASF409:
	.ascii	"SPAWN_ERR_CREATE_ARGSPG\000"
.LASF650:
	.ascii	"_Bool\000"
.LASF489:
	.ascii	"INIT_ERR_COPY_IO_CAP\000"
.LASF492:
	.ascii	"ETHERSRV_ERR_TOO_MANY_BUFFERS\000"
.LASF506:
	.ascii	"FILTER_ERR_FILTER_BUSY\000"
.LASF348:
	.ascii	"MON_ERR_RAM_ALLOC_RETERR\000"
.LASF398:
	.ascii	"SPAWN_ERR_MONITOR_CLIENT\000"
.LASF119:
	.ascii	"LIB_ERR_NOT_CNODE\000"
.LASF509:
	.ascii	"FILTER_ERR_BUFFER_NOT_FOUND\000"
.LASF87:
	.ascii	"SYS_ERR_KERNEL_MEM_INVALID\000"
.LASF468:
	.ascii	"MM_ERR_RESIZE_NODE\000"
.LASF678:
	.ascii	"err_code\000"
.LASF511:
	.ascii	"TRACE_ERR_NO_BUFFER\000"
.LASF13:
	.ascii	"char\000"
.LASF79:
	.ascii	"SYS_ERR_DISP_VSPACE_ROOT\000"
.LASF137:
	.ascii	"LIB_ERR_FRAME_IDENTIFY\000"
.LASF113:
	.ascii	"LIB_ERR_WHILE_FREEING_SLOT\000"
.LASF332:
	.ascii	"MON_ERR_RCAP_DB_NOT_FOUND\000"
.LASF425:
	.ascii	"SPAWN_ERR_CREATE_SMALLCN\000"
.LASF644:
	.ascii	"SATA_ERR_INVALID_TYPE\000"
.LASF296:
	.ascii	"FLOUNDER_ERR_RX_INVALID_LENGTH\000"
.LASF162:
	.ascii	"LIB_ERR_VSPACE_PINNED_INIT\000"
.LASF313:
	.ascii	"CHIPS_ERR_GET_CAP\000"
.LASF594:
	.ascii	"NFS_ERR_BADTYPE\000"
.LASF669:
	.ascii	"cleanupthread\000"
.LASF422:
	.ascii	"SPAWN_ERR_FIND_MODULE\000"
.LASF464:
	.ascii	"MM_ERR_ALREADY_ALLOCATED\000"
.LASF551:
	.ascii	"VFS_ERR_UNKNOWN_FILESYSTEM\000"
.LASF346:
	.ascii	"MON_ERR_MAP_URPC_CHAN\000"
.LASF212:
	.ascii	"LIB_ERR_CORESET_GET_NEXT_DONE\000"
.LASF48:
	.ascii	"SYS_ERR_DEST_CNODE_INVALID\000"
.LASF185:
	.ascii	"LIB_ERR_MEMOBJ_VREGION_ALREADY_MAPPED\000"
.LASF55:
	.ascii	"SYS_ERR_SLOTS_IN_USE\000"
.LASF515:
	.ascii	"TRACE_ERR_KERNEL_INVOKE\000"
.LASF43:
	.ascii	"SYS_ERR_GUARD_SIZE_OVERFLOW\000"
.LASF156:
	.ascii	"LIB_ERR_VSPACE_REGION_OVERLAP\000"
.LASF601:
	.ascii	"LWIP_ERR_RST\000"
.LASF615:
	.ascii	"OCT_ERR_QUERY_SIZE\000"
.LASF29:
	.ascii	"SYS_ERR_LMP_CAPTRANSFER_DST_CNODE_INVALID\000"
.LASF283:
	.ascii	"LIB_ERR_WAITSET_IN_USE\000"
.LASF109:
	.ascii	"CAPS_ERR_MDB_DUPLICATE_ENTRY\000"
.LASF92:
	.ascii	"SYS_ERR_VMKIT_VMCB\000"
.LASF75:
	.ascii	"SYS_ERR_IRQ_INVALID\000"
.LASF261:
	.ascii	"LIB_ERR_SEND_CAP_REQUEST\000"
.LASF654:
	.ascii	"header_base\000"
.LASF331:
	.ascii	"MON_ERR_CAP_REMOTE\000"
.LASF584:
	.ascii	"NFS_ERR_NOTEMPTY\000"
.LASF665:
	.ascii	"core_id\000"
.LASF643:
	.ascii	"AHCI_ERR_ILLEGAL_ARGUMENT\000"
.LASF653:
	.ascii	"Header\000"
.LASF217:
	.ascii	"LIB_ERR_LMP_BUFLEN_INVALID\000"
.LASF576:
	.ascii	"NFS_ERR_NOTDIR\000"
.LASF491:
	.ascii	"INIT_ERR_NO_MATCHING_RAM_CAP\000"
.LASF16:
	.ascii	"SYS_ERR_OK\000"
.LASF343:
	.ascii	"MON_ERR_CAP_SEND_TRANSIENT\000"
.LASF33:
	.ascii	"SYS_ERR_INVALID_EPLEN\000"
.LASF662:
	.ascii	"current\000"
.LASF599:
	.ascii	"LWIP_ERR_RTE\000"
.LASF659:
	.ascii	"dispatcher_generic\000"
.LASF57:
	.ascii	"SYS_ERR_NO_LOCAL_COPIES\000"
.LASF536:
	.ascii	"SKB_ERR_UNEXPECTED_OUTPUT\000"
.LASF83:
	.ascii	"SYS_ERR_DISP_NOT_RUNNABLE\000"
.LASF591:
	.ascii	"NFS_ERR_NOTSUPP\000"
.LASF569:
	.ascii	"NFS_ERR_NOENT\000"
.LASF402:
	.ascii	"SPAWN_ERR_MINT_TASKCN\000"
.LASF130:
	.ascii	"LIB_ERR_CAP_COPY\000"
.LASF539:
	.ascii	"FS_ERR_NOTDIR\000"
.LASF255:
	.ascii	"LIB_ERR_BIND_MULTIHOP_REQ\000"
.LASF560:
	.ascii	"NFS_ERR_MNT_NOENT\000"
.LASF524:
	.ascii	"PCI_ERR_MEM_ALLOC\000"
.LASF216:
	.ascii	"LIB_ERR_UMP_CHAN_FULL\000"
.LASF226:
	.ascii	"LIB_ERR_CHAN_DEREGISTER_RECV\000"
.LASF45:
	.ascii	"SYS_ERR_ILLEGAL_DEST_TYPE\000"
.LASF270:
	.ascii	"LIB_ERR_GET_MON_BLOCKING_IREF\000"
.LASF228:
	.ascii	"LIB_ERR_UMP_CHAN_INIT\000"
.LASF215:
	.ascii	"LIB_ERR_NO_UMP_MSG\000"
.LASF38:
	.ascii	"SYS_ERR_GUARD_MISMATCH\000"
.LASF235:
	.ascii	"LIB_ERR_UMP_CHAN_ACCEPT\000"
.LASF384:
	.ascii	"SPAWN_ERR_LOAD\000"
.LASF286:
	.ascii	"LIB_ERR_EVENT_DISPATCH\000"
.LASF614:
	.ascii	"OCT_ERR_CONSTRAINT_MISMATCH\000"
.LASF593:
	.ascii	"NFS_ERR_SERVERFAULT\000"
.LASF463:
	.ascii	"MM_ERR_ALREADY_PRESENT\000"
.LASF181:
	.ascii	"LIB_ERR_MEMOBJ_PAGEFAULT_HANDLER\000"
.LASF335:
	.ascii	"MON_ERR_RCAP_DB_ADD\000"
.LASF372:
	.ascii	"ROUTE_ERR_LOOKUP\000"
.LASF611:
	.ascii	"DIST_ERR_NS_LOOKUP\000"
.LASF381:
	.ascii	"ROUTE_ERR_SET_GROUP_RPC\000"
.LASF256:
	.ascii	"LIB_ERR_NO_MULTIHOP_BIND_HANDLER\000"
.LASF89:
	.ascii	"SYS_ERR_INVALID_YIELD_TARGET\000"
.LASF387:
	.ascii	"SPAWN_ERR_VSPACE_MAP\000"
.LASF207:
	.ascii	"LIB_ERR_VSPACE_MMU_AWARE_MAP\000"
.LASF624:
	.ascii	"OCT_ERR_INVALID_ID\000"
.LASF479:
	.ascii	"INIT_ERR_RUN_MEM_SERV\000"
.LASF574:
	.ascii	"NFS_ERR_XDEV\000"
.LASF628:
	.ascii	"KALUGA_ERR_MODULE_NOT_FOUND\000"
.LASF174:
	.ascii	"LIB_ERR_MEMOBJ_CREATE_PINNED\000"
.LASF138:
	.ascii	"LIB_ERR_VNODE_MAP\000"
.LASF531:
	.ascii	"SKB_ERR_CONVERSION_ERROR\000"
.LASF302:
	.ascii	"FLOUNDER_ERR_UMP_ALLOC_NOTIFY\000"
.LASF378:
	.ascii	"ROUTE_ERR_WRONG_GROUP_ID\000"
.LASF145:
	.ascii	"LIB_ERR_SINGLE_SLOT_ALLOC_INIT\000"
.LASF424:
	.ascii	"SPAWN_ERR_CREATE_SEGCN\000"
.LASF374:
	.ascii	"ROUTE_ERR_CORE_NOT_FOUND\000"
.LASF150:
	.ascii	"LIB_ERR_SLOT_FREE\000"
.LASF90:
	.ascii	"SYS_ERR_DISP_OCAP_LOOKUP\000"
.LASF607:
	.ascii	"LWIP_ERR_IF\000"
.LASF88:
	.ascii	"SYS_ERR_CORE_NOT_FOUND\000"
.LASF412:
	.ascii	"SPAWN_ERR_MINT_ROOTCN\000"
.LASF364:
	.ascii	"MON_ERR_SPAWN_XCORE_MONITOR\000"
.LASF630:
	.ascii	"KALUGA_ERR_DRIVER_NOT_AUTO\000"
.LASF189:
	.ascii	"LIB_ERR_PMAP_INIT\000"
.LASF30:
	.ascii	"SYS_ERR_LMP_CAPTRANSFER_DST_SLOT_OCCUPIED\000"
.LASF533:
	.ascii	"SKB_ERR_EVALUATE\000"
.LASF324:
	.ascii	"MON_ERR_IREF_ALLOC\000"
.LASF396:
	.ascii	"SPAWN_ERR_ELF_MAP\000"
.LASF8:
	.ascii	"long unsigned int\000"
.LASF392:
	.ascii	"SPAWN_ERR_SETUP_CSPACE\000"
.LASF633:
	.ascii	"MS_ERR_INIT_PEERS\000"
.LASF414:
	.ascii	"SPAWN_ERR_MAP_DISPATCHER_TO_NEW\000"
.LASF257:
	.ascii	"LIB_ERR_BIND_MULTIHOP_SAME_CORE\000"
.LASF486:
	.ascii	"INIT_ERR_COPY_MODULECN_CAP\000"
.LASF636:
	.ascii	"LOX_ERR_NO_LOCKS\000"
.LASF449:
	.ascii	"ELF_ERR_HEADER\000"
.LASF421:
	.ascii	"SPAWN_ERR_MAP_BOOTINFO\000"
.LASF120:
	.ascii	"LIB_ERR_FRAME_ALLOC\000"
.LASF218:
	.ascii	"LIB_ERR_NO_ENDPOINT_SPACE\000"
.LASF56:
	.ascii	"SYS_ERR_RETYPE_CREATE\000"
.LASF123:
	.ascii	"LIB_ERR_VNODE_CREATE\000"
.LASF587:
	.ascii	"NFS_ERR_REMOTE\000"
.LASF329:
	.ascii	"MON_ERR_CAP_IDENTIFY\000"
.LASF155:
	.ascii	"LIB_ERR_VSPACE_DESTROY\000"
.LASF76:
	.ascii	"SYS_ERR_IO_PORT_INVALID\000"
.LASF500:
	.ascii	"PORT_ERR_NO_MORE_PORT\000"
.LASF106:
	.ascii	"SYS_ERR_I2C_WAIT_FOR_BUS\000"
.LASF358:
	.ascii	"MON_ERR_CCAST_INIT\000"
.LASF623:
	.ascii	"OCT_ERR_MAX_SUBSCRIPTIONS\000"
.LASF483:
	.ascii	"INIT_ERR_MAP_BOOTINFO\000"
.LASF12:
	.ascii	"uintptr_t\000"
.LASF355:
	.ascii	"MON_ERR_MULTICAST_SET\000"
.LASF282:
	.ascii	"LIB_ERR_CHAN_NOT_REGISTERED\000"
.LASF154:
	.ascii	"LIB_ERR_VSPACE_LAYOUT_INIT\000"
.LASF221:
	.ascii	"LIB_ERR_UMP_FRAME_OVERFLOW\000"
.LASF143:
	.ascii	"LIB_ERR_SLOT_ALLOC_WRONG_CNODE\000"
.LASF312:
	.ascii	"CHIPS_ERR_EXISTS\000"
.LASF362:
	.ascii	"MON_ERR_UNICAST_INIT\000"
.LASF345:
	.ascii	"MON_ERR_SPAN_DOMAIN\000"
.LASF508:
	.ascii	"FILTER_ERR_FILTER_NOT_FOUND\000"
.LASF139:
	.ascii	"LIB_ERR_VNODE_UNMAP\000"
.LASF342:
	.ascii	"MON_ERR_CAP_SEND\000"
.LASF60:
	.ascii	"SYS_ERR_VNODE_SLOT_INVALID\000"
.LASF353:
	.ascii	"MON_ERR_MAP_MULTIBOOT\000"
.LASF85:
	.ascii	"SYS_ERR_DISP_CAP_INVALID\000"
.LASF19:
	.ascii	"SYS_ERR_CALLER_ENABLED\000"
.LASF170:
	.ascii	"LIB_ERR_VREGION_BAD_ALIGNMENT\000"
.LASF219:
	.ascii	"LIB_ERR_UMP_BUFSIZE_INVALID\000"
.LASF466:
	.ascii	"MM_ERR_MISSING_CAPS\000"
.LASF304:
	.ascii	"FLOUNDER_ERR_BIND\000"
.LASF91:
	.ascii	"SYS_ERR_VMKIT_UNAVAIL\000"
.LASF266:
	.ascii	"LIB_ERR_MONITOR_CLIENT_INIT\000"
.LASF389:
	.ascii	"SPAWN_ERR_SETUP_ENV\000"
.LASF571:
	.ascii	"NFS_ERR_NXIO\000"
.LASF326:
	.ascii	"MON_ERR_SEND_REMOTE_MSG\000"
.LASF403:
	.ascii	"SPAWN_ERR_CREATE_PAGECN\000"
.LASF9:
	.ascii	"long long int\000"
.LASF523:
	.ascii	"PCI_ERR_DEVICE_INIT\000"
.LASF24:
	.ascii	"SYS_ERR_LMP_TARGET_DISABLED\000"
.LASF639:
	.ascii	"AHCI_ERR_PORT_INVALID\000"
.LASF521:
	.ascii	"PCI_ERR_UNKNOWN_GSI\000"
.LASF472:
	.ascii	"INIT_ERR_SPAWN_MONITOR\000"
.LASF655:
	.ascii	"header_freep\000"
.LASF53:
	.ascii	"SYS_ERR_INVALID_SIZE_BITS\000"
.LASF147:
	.ascii	"LIB_ERR_MULTI_SLOT_ALLOC_INIT_RAW\000"
.LASF80:
	.ascii	"SYS_ERR_DISP_VSPACE_INVALID\000"
.LASF327:
	.ascii	"MON_ERR_INVALID_MON_ID\000"
.LASF538:
	.ascii	"FS_ERR_INVALID_FH\000"
.LASF604:
	.ascii	"LWIP_ERR_VAL\000"
.LASF395:
	.ascii	"SPAWN_ERR_SETUP_DISPATCHER\000"
.LASF116:
	.ascii	"LIB_ERR_SLAB_REFILL\000"
.LASF46:
	.ascii	"SYS_ERR_SOURCE_CAP_LOOKUP\000"
.LASF497:
	.ascii	"ETHERSRV_ERR_INVALID_STATE\000"
.LASF173:
	.ascii	"LIB_ERR_MEMOBJ_CREATE_ONE_FRAME_ONE_MAP\000"
.LASF405:
	.ascii	"SPAWN_ERR_COPY_VNODE\000"
.LASF124:
	.ascii	"LIB_ERR_CNODE_CREATE\000"
.LASF520:
	.ascii	"PCI_ERR_IRQTABLE_SET\000"
.LASF667:
	.ascii	"core_state\000"
.LASF390:
	.ascii	"SPAWN_ERR_UNKNOWN_TARGET_ARCH\000"
.LASF465:
	.ascii	"MM_ERR_NOT_FOUND\000"
.LASF609:
	.ascii	"LWIP_ERR_INPROGRESS\000"
.LASF613:
	.ascii	"OCT_ERR_NO_RECORD_NAME\000"
.LASF670:
	.ascii	"fpu_thread\000"
.LASF279:
	.ascii	"LIB_ERR_THREAD_JOIN_DETACHED\000"
.LASF277:
	.ascii	"LIB_ERR_THREAD_CREATE\000"
.LASF554:
	.ascii	"VFS_ERR_IN_OPEN\000"
.LASF501:
	.ascii	"PORT_ERR_IN_USE\000"
.LASF211:
	.ascii	"LIB_ERR_CORESET_NEW\000"
.LASF294:
	.ascii	"FLOUNDER_ERR_RX_EMPTY_MSG\000"
.LASF369:
	.ascii	"MON_ERR_RSRC_NOT_FOUND\000"
.LASF681:
	.ascii	"context_switch_counter\000"
.LASF140:
	.ascii	"LIB_ERR_IDC_ENDPOINT_ALLOC\000"
.LASF401:
	.ascii	"SPAWN_ERR_CREATE_TASKCN\000"
.LASF608:
	.ascii	"LWIP_ERR_ISCONN\000"
.LASF0:
	.ascii	"unsigned int\000"
.LASF101:
	.ascii	"SYS_ERR_SYNC_MISS\000"
.LASF386:
	.ascii	"SPAWN_ERR_RUN\000"
.LASF250:
	.ascii	"LIB_ERR_BIND_UMP_REPLY\000"
.LASF540:
	.ascii	"FS_ERR_NOTFILE\000"
.LASF367:
	.ascii	"MON_ERR_RSRC_MEMBER_LIMIT\000"
.LASF274:
	.ascii	"LIB_ERR_NAMESERVICE_CLIENT_INIT\000"
.LASF460:
	.ascii	"MM_ERR_MM_FREE\000"
.LASF111:
	.ascii	"CAPS_ERR_CAP_NOT_FOUND\000"
.LASF183:
	.ascii	"LIB_ERR_MEMOBJ_WRONG_OFFSET\000"
.LASF656:
	.ascii	"morecore_state\000"
.LASF14:
	.ascii	"coreid_t\000"
.LASF339:
	.ascii	"MON_ERR_SPAWN_CORE\000"
.LASF249:
	.ascii	"LIB_ERR_BIND_LMP_REPLY\000"
.LASF616:
	.ascii	"OCT_ERR_INVALID_FORMAT\000"
.LASF330:
	.ascii	"MON_ERR_CAP_CREATE\000"
.LASF371:
	.ascii	"ROUTE_ERR_EXPORT\000"
.LASF663:
	.ascii	"runq\000"
.LASF213:
	.ascii	"LIB_ERR_NO_LMP_MSG\000"
.LASF81:
	.ascii	"SYS_ERR_DISP_FRAME\000"
.LASF104:
	.ascii	"SYS_ERR_I2C_UNINITIALIZED\000"
.LASF572:
	.ascii	"NFS_ERR_ACCES\000"
.LASF499:
	.ascii	"PORT_ERR_NOT_ENOUGH_MEMORY\000"
.LASF164:
	.ascii	"LIB_ERR_VSPACE_PINNED_INVALID_TYPE\000"
.LASF562:
	.ascii	"NFS_ERR_MNT_ACCES\000"
.LASF459:
	.ascii	"MM_ERR_MM_ADD\000"
.LASF433:
	.ascii	"SPAWN_ERR_SETUP_SIDCAP\000"
.LASF299:
	.ascii	"FLOUNDER_ERR_GENERIC_BIND_NO_MORE_DRIVERS\000"
.LASF581:
	.ascii	"NFS_ERR_ROFS\000"
.LASF648:
	.ascii	"FS_CACHE_CONFLICT\000"
.LASF344:
	.ascii	"MON_ERR_ROUTE_SET\000"
.LASF42:
	.ascii	"SYS_ERR_SLOT_LOOKUP_FAIL\000"
.LASF237:
	.ascii	"LIB_ERR_LMP_NOT_CONNECTED\000"
.LASF470:
	.ascii	"INIT_ERR_SPAWN_MEM_SERV\000"
.LASF291:
	.ascii	"LIB_ERR_LDT_SELECTOR_INVALID\000"
.LASF95:
	.ascii	"SYS_ERR_VMKIT_CTRL_INVALID\000"
.LASF406:
	.ascii	"SPAWN_ERR_CREATE_DISPATCHER\000"
.LASF272:
	.ascii	"LIB_ERR_GET_NAME_IREF\000"
.LASF94:
	.ascii	"SYS_ERR_VMKIT_CTRL\000"
.LASF503:
	.ascii	"PORT_ERR_NOT_FOUND\000"
.LASF426:
	.ascii	"SPAWN_ERR_ARGSPG_OVERFLOW\000"
.LASF334:
	.ascii	"MON_ERR_RCAP_DB_UNLOCK\000"
.LASF227:
	.ascii	"LIB_ERR_LMP_CHAN_INIT\000"
.LASF458:
	.ascii	"MM_ERR_MM_INIT\000"
.LASF172:
	.ascii	"LIB_ERR_MEMOBJ_CREATE_ONE_FRAME\000"
.LASF475:
	.ascii	"INIT_ERR_COPY_EP_TO_MONITOR\000"
.LASF469:
	.ascii	"MM_ERR_REALLOC_RANGE\000"
.LASF490:
	.ascii	"INIT_ERR_COPY_UMP_CAP\000"
.LASF632:
	.ascii	"MS_ERR_SKB\000"
.LASF363:
	.ascii	"MON_ERR_MULTICAST_INIT\000"
.LASF146:
	.ascii	"LIB_ERR_MULTI_SLOT_ALLOC_INIT\000"
.LASF263:
	.ascii	"LIB_ERR_CAP_DELETE_FAIL\000"
.LASF273:
	.ascii	"LIB_ERR_GET_RAMFS_IREF\000"
.LASF241:
	.ascii	"LIB_ERR_IPI_NOTIFY\000"
.LASF100:
	.ascii	"SYS_ERR_PERFMON_NOT_AVAILABLE\000"
.LASF461:
	.ascii	"MM_ERR_NEW_NODE\000"
.LASF301:
	.ascii	"FLOUNDER_ERR_CHANGE_MONITOR_WAITSET\000"
.LASF641:
	.ascii	"AHCI_ERR_PORT_MISMATCH\000"
.LASF482:
	.ascii	"INIT_ERR_COPY_SUPERCN_CAP\000"
.LASF169:
	.ascii	"LIB_ERR_VREGION_PAGEFAULT_HANDLER\000"
.LASF652:
	.ascii	"size\000"
.LASF481:
	.ascii	"INIT_ERR_FREE_MEM_SERV\000"
.LASF276:
	.ascii	"LIB_ERR_KBD_BIND\000"
.LASF651:
	.ascii	"Align\000"
.LASF238:
	.ascii	"LIB_ERR_MSGBUF_OVERFLOW\000"
.LASF563:
	.ascii	"NFS_ERR_MNT_NOTDIR\000"
.LASF305:
	.ascii	"FLOUNDER_ERR_CREATE_MSG\000"
.LASF645:
	.ascii	"FAT_ERR_BAD_FS\000"
.LASF28:
	.ascii	"SYS_ERR_LMP_CAPTRANSFER_DST_CNODE_LOOKUP\000"
.LASF151:
	.ascii	"LIB_ERR_SLOT_UNALLOCATED\000"
.LASF160:
	.ascii	"LIB_ERR_VSPACE_VREGION_NOT_FOUND\000"
.LASF480:
	.ascii	"INIT_ERR_FREE_MONITOR\000"
.LASF642:
	.ascii	"AHCI_ERR_NO_FREE_PRD\000"
.LASF239:
	.ascii	"LIB_ERR_MSGBUF_CANNOT_GROW\000"
.LASF582:
	.ascii	"NFS_ERR_MLINK\000"
.LASF315:
	.ascii	"CHIPS_ERR_REMOVE_CAP\000"
.LASF485:
	.ascii	"INIT_ERR_COPY_PERF_MON\000"
.LASF318:
	.ascii	"BCAST_ERR_SEND_SSF\000"
.LASF380:
	.ascii	"ROUTE_ERR_CREATE_GROUP_RPC\000"
.LASF484:
	.ascii	"INIT_ERR_COPY_KERNEL_CAP\000"
.LASF245:
	.ascii	"LIB_ERR_NAMESERVICE_UNKNOWN_NAME\000"
.LASF391:
	.ascii	"SPAWN_ERR_UNSUPPORTED_TARGET_ARCH\000"
.LASF289:
	.ascii	"LIB_ERR_SEGBASE_OVER_4G_LIMIT\000"
.LASF234:
	.ascii	"LIB_ERR_LMP_CHAN_ACCEPT\000"
.LASF418:
	.ascii	"SPAWN_ERR_MAP_FDSPG_TO_NEW\000"
.LASF476:
	.ascii	"INIT_ERR_SETUP_MONITOR_CHAN\000"
.LASF178:
	.ascii	"LIB_ERR_MEMOBJ_PIN_REGION\000"
.LASF671:
	.ascii	"domain_id\000"
.LASF49:
	.ascii	"SYS_ERR_ROOT_CAP_LOOKUP\000"
.LASF21:
	.ascii	"SYS_ERR_ILLEGAL_INVOCATION\000"
.LASF622:
	.ascii	"OCT_ERR_NO_SUBSCRIBERS\000"
.LASF11:
	.ascii	"long long unsigned int\000"
.LASF307:
	.ascii	"FLOUNDER_ERR_DEMARSHALLING\000"
.LASF556:
	.ascii	"VFS_ERR_IN_READ\000"
.LASF320:
	.ascii	"MON_CLIENT_ERR_URPC_BLOCK\000"
.LASF84:
	.ascii	"SYS_ERR_DISP_CAP_LOOKUP\000"
.LASF18:
	.ascii	"SYS_ERR_INVARGS_SYSCALL\000"
.LASF223:
	.ascii	"LIB_ERR_CHAN_REGISTER_SEND\000"
.LASF629:
	.ascii	"KALUGA_ERR_DRIVER_ALREADY_STARTED\000"
.LASF617:
	.ascii	"OCT_ERR_UNKNOWN_ATTRIBUTE\000"
.LASF507:
	.ascii	"FILTER_ERR_NO_NETD_MEM\000"
.LASF31:
	.ascii	"SYS_ERR_LRPC_SLOT_INVALID\000"
.LASF77:
	.ascii	"SYS_ERR_DISP_CSPACE_ROOT\000"
.LASF471:
	.ascii	"INIT_ERR_INIT_MEM_SERV\000"
.LASF253:
	.ascii	"LIB_ERR_MONITOR_CAP_SEND\000"
.LASF69:
	.ascii	"SYS_ERR_VM_MAP_SIZE\000"
.LASF68:
	.ascii	"SYS_ERR_VM_ALREADY_MAPPED\000"
.LASF525:
	.ascii	"PCI_ERR_WRONG_INDEX\000"
.LASF561:
	.ascii	"NFS_ERR_MNT_IO\000"
.LASF573:
	.ascii	"NFS_ERR_EXIST\000"
.LASF208:
	.ascii	"LIB_ERR_VSPACE_MMU_AWARE_NO_SPACE\000"
.LASF351:
	.ascii	"MON_ERR_INTERN_SET\000"
.LASF496:
	.ascii	"ETHERSRV_ERR_CANT_TRANSMIT\000"
.LASF82:
	.ascii	"SYS_ERR_DISP_FRAME_INVALID\000"
.LASF570:
	.ascii	"NFS_ERR_IO\000"
.LASF598:
	.ascii	"LWIP_ERR_TIMEOUT\000"
.LASF474:
	.ascii	"INIT_ERR_COPY_EP_TO_MEM_SERV\000"
.LASF176:
	.ascii	"LIB_ERR_MEMOBJ_MAP_REGION\000"
.LASF439:
	.ascii	"SPAWN_ERR_COPY_PACN\000"
.LASF382:
	.ascii	"ROUTE_ERR_GET_GROUP_RPC\000"
.LASF519:
	.ascii	"PCI_ERR_ROUTING_IRQ\000"
.LASF543:
	.ascii	"FS_ERR_EXISTS\000"
.LASF115:
	.ascii	"LIB_ERR_SLAB_ALLOC_FAIL\000"
.LASF251:
	.ascii	"LIB_ERR_NO_LMP_BIND_HANDLER\000"
.LASF397:
	.ascii	"SPAWN_ERR_SET_CAPS\000"
.LASF271:
	.ascii	"LIB_ERR_GET_MEM_IREF\000"
.LASF410:
	.ascii	"SPAWN_ERR_CREATE_FDSPG\000"
.LASF565:
	.ascii	"NFS_ERR_MNT_NAMETOOLONG\000"
.LASF537:
	.ascii	"SKB_ERR_IO_OUTPUT\000"
.LASF40:
	.ascii	"SYS_ERR_IDENTIFY_LOOKUP\000"
.LASF20:
	.ascii	"SYS_ERR_CALLER_DISABLED\000"
.LASF288:
	.ascii	"LIB_ERR_EVENT_QUEUE_EMPTY\000"
.LASF303:
	.ascii	"FLOUNDER_ERR_UMP_STORE_NOTIFY\000"
.LASF368:
	.ascii	"MON_ERR_RSRC_ILL_MANIFEST\000"
.LASF577:
	.ascii	"NFS_ERR_ISDIR\000"
.LASF39:
	.ascii	"SYS_ERR_CAP_NOT_FOUND\000"
.LASF440:
	.ascii	"SPAWN_ERR_COPY_MODULECN\000"
.LASF467:
	.ascii	"MM_ERR_CHUNK_SLOT_ALLOC\000"
.LASF356:
	.ascii	"MON_ERR_BCAST_INIT\000"
.LASF37:
	.ascii	"SYS_ERR_DEPTH_EXCEEDED\000"
.LASF281:
	.ascii	"LIB_ERR_CHAN_ALREADY_REGISTERED\000"
.LASF621:
	.ascii	"OCT_ERR_NO_SUBSCRIPTION\000"
.LASF436:
	.ascii	"SPAWN_ERR_FREE_ROOTCN\000"
.LASF311:
	.ascii	"CHIPS_ERR_UNKNOWN_NAME\000"
.LASF298:
	.ascii	"FLOUNDER_ERR_BUF_SEND_MORE\000"
.LASF201:
	.ascii	"LIB_ERR_PMAP_FIND_VNODE\000"
.LASF317:
	.ascii	"BCAST_ERR_SEND\000"
.LASF306:
	.ascii	"FLOUNDER_ERR_MARSHALLING\000"
.LASF336:
	.ascii	"MON_ERR_SAME_CORE\000"
.LASF420:
	.ascii	"SPAWN_ERR_FILL_SMALLCN\000"
.LASF527:
	.ascii	"ACPI_ERR_INVALID_PATH_NAME\000"
.LASF516:
	.ascii	"DRIVERKIT_NO_CAP_FOUND\000"
.LASF284:
	.ascii	"LIB_ERR_WAITSET_CHAN_CANCEL\000"
.LASF203:
	.ascii	"LIB_ERR_OUT_OF_VIRTUAL_ADDR\000"
.LASF455:
	.ascii	"MM_ERR_SLOT_MM_ALLOC\000"
.LASF517:
	.ascii	"PCI_ERR_IOAPIC_INIT\000"
.LASF388:
	.ascii	"SPAWN_ERR_GET_CMDLINE_ARGS\000"
.LASF448:
	.ascii	"ELF_ERR_FILESZ\000"
.LASF672:
	.ascii	"thread\000"
.LASF347:
	.ascii	"MON_ERR_RAM_ALLOC_ERR\000"
.LASF247:
	.ascii	"LIB_ERR_BIND_LMP_REQ\000"
.LASF564:
	.ascii	"NFS_ERR_MNT_INVAL\000"
.LASF553:
	.ascii	"VFS_ERR_NOT_SUPPORTED\000"
.LASF308:
	.ascii	"FLOUNDER_ERR_RPC_MISMATCH\000"
.LASF65:
	.ascii	"SYS_ERR_VNODE_TYPE\000"
.LASF375:
	.ascii	"ROUTE_ERR_SET_EXPECTED\000"
.LASF325:
	.ascii	"MON_ERR_SPAN_STATE_ALLOC\000"
.LASF99:
	.ascii	"SYS_ERR_SERIAL_PORT_UNAVAILABLE\000"
.LASF3:
	.ascii	"short int\000"
.LASF620:
	.ascii	"OCT_ERR_ENGINE_FAIL\000"
.LASF187:
	.ascii	"LIB_ERR_MEMOBJ_PROTECT\000"
.LASF26:
	.ascii	"SYS_ERR_LMP_EP_STATE_INVALID\000"
.LASF559:
	.ascii	"NFS_ERR_MNT_PERM\000"
.LASF10:
	.ascii	"uint64_t\000"
.LASF578:
	.ascii	"NFS_ERR_INVAL\000"
.LASF513:
	.ascii	"TRACE_ERR_CREATE_CAP\000"
.LASF376:
	.ascii	"ROUTE_ERR_SEND\000"
.LASF546:
	.ascii	"FS_ERR_BULK_ALREADY_INIT\000"
.LASF360:
	.ascii	"MON_ERR_UNICAST_CONNECT\000"
.LASF430:
	.ascii	"SPAWN_ERR_COPY_ARGCN\000"
.LASF596:
	.ascii	"LWIP_ERR_MEM\000"
.LASF419:
	.ascii	"SPAWN_ERR_MAP_FDSPG_TO_SELF\000"
.LASF566:
	.ascii	"NFS_ERR_MNT_NOTSUPP\000"
.LASF252:
	.ascii	"LIB_ERR_NO_UMP_BIND_HANDLER\000"
.LASF141:
	.ascii	"LIB_ERR_SLOT_ALLOC_INIT\000"
.LASF605:
	.ascii	"LWIP_ERR_ARG\000"
.LASF175:
	.ascii	"LIB_ERR_MEMOBJ_CREATE_VFS\000"
.LASF462:
	.ascii	"MM_ERR_OUT_OF_BOUNDS\000"
.LASF575:
	.ascii	"NFS_ERR_NODEV\000"
.LASF93:
	.ascii	"SYS_ERR_VMKIT_VMCB_INVALID\000"
.LASF105:
	.ascii	"SYS_ERR_I2C_ZERO_LENGTH_MSG\000"
.LASF408:
	.ascii	"SPAWN_ERR_CREATE_SELFEP\000"
.LASF661:
	.ascii	"stack\000"
.LASF323:
	.ascii	"MON_ERR_INVALID_IREF\000"
.LASF32:
	.ascii	"SYS_ERR_LRPC_NOT_ENDPOINT\000"
.LASF244:
	.ascii	"LIB_ERR_NAMESERVICE_NOT_BOUND\000"
.LASF225:
	.ascii	"LIB_ERR_CHAN_REGISTER_RECV\000"
.LASF292:
	.ascii	"FLOUNDER_ERR_INVALID_STATE\000"
.LASF165:
	.ascii	"LIB_ERR_VREGION_MAP\000"
.LASF676:
	.ascii	"./tools/asmoffsets/asmoffsets.c\000"
.LASF657:
	.ascii	"core_state_generic\000"
.LASF168:
	.ascii	"LIB_ERR_VREGION_DESTROY\000"
.LASF427:
	.ascii	"SPAWN_ERR_SERIALISE_VSPACE\000"
.LASF383:
	.ascii	"ROUTE_ERR_ALLOC_NID_RPC\000"
.LASF27:
	.ascii	"SYS_ERR_LMP_CAPTRANSFER_SRC_LOOKUP\000"
.LASF522:
	.ascii	"PCI_ERR_INVALID_VECTOR\000"
.LASF107:
	.ascii	"SYS_ERR_I2C_FAILURE\000"
.LASF453:
	.ascii	"MM_ERR_FIND_NODE\000"
.LASF456:
	.ascii	"MM_ERR_SLOT_NOSLOTS\000"
.LASF210:
	.ascii	"LIB_ERR_INVOKE_PERFMON_WRITE\000"
.LASF47:
	.ascii	"SYS_ERR_DEST_CNODE_LOOKUP\000"
.LASF333:
	.ascii	"MON_ERR_RCAP_DB_LOCK\000"
.LASF59:
	.ascii	"SYS_ERR_TYPE_NOT_CREATABLE\000"
.LASF269:
	.ascii	"LIB_ERR_DOMAIN_INIT\000"
.LASF194:
	.ascii	"LIB_ERR_PMAP_DO_SINGLE_MAP\000"
.LASF635:
	.ascii	"LOX_ERR_INIT_LOCKS\000"
.LASF163:
	.ascii	"LIB_ERR_VSPACE_PINNED_ALLOC\000"
.LASF603:
	.ascii	"LWIP_ERR_CONN\000"
.LASF15:
	.ascii	"domainid_t\000"
.LASF504:
	.ascii	"FILTER_ERR_NOT_ENOUGH_MEMORY\000"
.LASF35:
	.ascii	"SYS_ERR_CNODE_TYPE\000"
.LASF199:
	.ascii	"LIB_ERR_PMAP_ALLOC_VNODE\000"
.LASF637:
	.ascii	"VBE_ERR_MODE_NOT_FOUND\000"
.LASF444:
	.ascii	"SPAWN_ERR_DISPATCHER_SETUP\000"
.LASF297:
	.ascii	"FLOUNDER_ERR_BUF_RECV_MORE\000"
.LASF196:
	.ascii	"LIB_ERR_PMAP_DO_SINGLE_UNMAP\000"
.LASF72:
	.ascii	"SYS_ERR_IRQ_LOOKUP\000"
.LASF445:
	.ascii	"SPAWN_ERR_DOMAIN_ALLOCATE\000"
.LASF610:
	.ascii	"DIST_ERR_NS_REG\000"
.LASF110:
	.ascii	"CAPS_ERR_MDB_ENTRY_NOTFOUND\000"
.LASF268:
	.ascii	"LIB_ERR_TERMINAL_INIT\000"
.LASF586:
	.ascii	"NFS_ERR_STALE\000"
.LASF675:
	.ascii	"GNU C 4.6.3\000"
.LASF121:
	.ascii	"LIB_ERR_FRAME_CREATE\000"
.LASF606:
	.ascii	"LWIP_ERR_USE\000"
.LASF254:
	.ascii	"LIB_ERR_MONITOR_RPC_BIND\000"
.LASF434:
	.ascii	"SPAWN_ERR_COPY_SIDCAP\000"
.LASF322:
	.ascii	"MON_ERR_INVALID_CORE_ID\000"
.LASF246:
	.ascii	"LIB_ERR_NAMESERVICE_INVALID_NAME\000"
.LASF542:
	.ascii	"FS_ERR_NOTFOUND\000"
.LASF638:
	.ascii	"VBE_ERR_BIOS_CALL_FAILED\000"
.LASF51:
	.ascii	"SYS_ERR_INVALID_RETYPE\000"
.LASF7:
	.ascii	"uint32_t\000"
.LASF167:
	.ascii	"LIB_ERR_VREGION_NOT_FOUND\000"
.LASF206:
	.ascii	"LIB_ERR_VSPACE_MMU_AWARE_INIT\000"
.LASF567:
	.ascii	"NFS_ERR_MNT_SERVERFAULT\000"
.LASF117:
	.ascii	"LIB_ERR_NOT_IMPLEMENTED\000"
.LASF429:
	.ascii	"SPAWN_ERR_SETUP_ARGCN\000"
.LASF394:
	.ascii	"SPAWN_ERR_VSPACE_INIT\000"
.LASF541:
	.ascii	"FS_ERR_INDEX_BOUNDS\000"
.LASF337:
	.ascii	"MON_ERR_REMOTE_CAP_NEED_REVOKE\000"
.LASF478:
	.ascii	"INIT_ERR_RUN_MONITOR\000"
.LASF122:
	.ascii	"LIB_ERR_FRAME_CREATE_MS_CONSTRAINTS\000"
.LASF192:
	.ascii	"LIB_ERR_PMAP_DO_MAP\000"
.LASF634:
	.ascii	"STARTD_ERR_BOOTMODULES\000"
.LASF589:
	.ascii	"NFS_ERR_NOT_SYNC\000"
.LASF359:
	.ascii	"MON_ERR_CCAST_CONNECT\000"
.LASF437:
	.ascii	"SPAWN_ERR_DELETE_TASKCN\000"
.LASF108:
	.ascii	"CAPS_ERR_INVALID_ARGS\000"
.LASF158:
	.ascii	"LIB_ERR_VSPACE_REMOVE_REGION\000"
.LASF152:
	.ascii	"LIB_ERR_VSPACE_CURRENT_INIT\000"
.LASF191:
	.ascii	"LIB_ERR_PMAP_DETERMINE_ADDR\000"
.LASF264:
	.ascii	"LIB_ERR_RAM_ALLOC_SET\000"
.LASF377:
	.ascii	"ROUTE_ERR_NO_SLOTS\000"
.LASF112:
	.ascii	"LIB_ERR_WHILE_DELETING\000"
.LASF454:
	.ascii	"MM_ERR_CHUNK_NODE\000"
.LASF4:
	.ascii	"short unsigned int\000"
.LASF61:
	.ascii	"SYS_ERR_WRONG_MAPPING\000"
.LASF514:
	.ascii	"TRACE_ERR_CAP_COPY\000"
.LASF441:
	.ascii	"SPAWN_ERR_COPY_IRQ_CAP\000"
.LASF450:
	.ascii	"ELF_ERR_PROGHDR\000"
.LASF502:
	.ascii	"PORT_ERR_REDIRECT\000"
.LASF631:
	.ascii	"THC_CANCELED\000"
.LASF532:
	.ascii	"SKB_ERR_EXECUTION\000"
.LASF144:
	.ascii	"LIB_ERR_SINGLE_SLOT_ALLOC_INIT_RAW\000"
.LASF370:
	.ascii	"ROUTE_ERR_NEW_ROUTE\000"
.LASF118:
	.ascii	"LIB_ERR_SHOULD_NOT_GET_HERE\000"
.LASF220:
	.ascii	"LIB_ERR_UMP_BUFADDR_INVALID\000"
.LASF495:
	.ascii	"ETHERSRV_ERR_NOT_ENOUGH_MEM\000"
.LASF400:
	.ascii	"SPAWN_ERR_CREATE_ROOTCN\000"
.LASF41:
	.ascii	"SYS_ERR_SLOT_IN_USE\000"
.LASF103:
	.ascii	"SYS_ERR_ID_SPACE_EXHAUSTED\000"
.LASF54:
	.ascii	"SYS_ERR_SLOTS_INVALID\000"
.LASF205:
	.ascii	"LIB_ERR_VSPACE_MAP\000"
.LASF71:
	.ascii	"SYS_ERR_VM_RETRY_SINGLE\000"
.LASF295:
	.ascii	"FLOUNDER_ERR_RX_INVALID_MSGNUM\000"
.LASF558:
	.ascii	"NFS_ERR_TRANSPORT\000"
.LASF640:
	.ascii	"AHCI_ERR_PORT_BUSY\000"
.LASF230:
	.ascii	"LIB_ERR_UMP_CHAN_RECV\000"
.LASF627:
	.ascii	"KALUGA_ERR_PARSE_MODULES\000"
.LASF510:
	.ascii	"TERM_ERR_REGISTER_HANDLER\000"
.LASF34:
	.ascii	"SYS_ERR_IDC_MSG_BOUNDS\000"
.LASF200:
	.ascii	"LIB_ERR_PMAP_ADDR_NOT_FREE\000"
.LASF233:
	.ascii	"LIB_ERR_UMP_CHAN_BIND\000"
.LASF159:
	.ascii	"LIB_ERR_VSPACE_PAGEFAULT_HANDER\000"
.LASF300:
	.ascii	"FLOUNDER_ERR_CHANGE_WAITSET\000"
.LASF568:
	.ascii	"NFS_ERR_PERM\000"
.LASF417:
	.ascii	"SPAWN_ERR_MAP_ARGSPG_TO_SELF\000"
.LASF52:
	.ascii	"SYS_ERR_REVOKE_FIRST\000"
.LASF126:
	.ascii	"LIB_ERR_RAM_ALLOC\000"
.LASF548:
	.ascii	"VFS_ERR_BAD_MOUNTPOINT\000"
.LASF267:
	.ascii	"LIB_ERR_MONITOR_CLIENT_CONNECT\000"
.LASF64:
	.ascii	"SYS_ERR_VNODE_SLOT_INUSE\000"
.LASF349:
	.ascii	"MON_ERR_MULTICAST_PAGE_MAP\000"
.LASF550:
	.ascii	"VFS_ERR_BAD_URI\000"
.LASF148:
	.ascii	"LIB_ERR_SINGLE_SLOT_ALLOC\000"
.LASF625:
	.ascii	"OCT_ERR_CAP_NAME_UNKNOWN\000"
.LASF135:
	.ascii	"LIB_ERR_CAP_INVOKE\000"
.LASF157:
	.ascii	"LIB_ERR_VSPACE_ADD_REGION\000"
.LASF473:
	.ascii	"INIT_ERR_INIT_MONITOR\000"
.LASF70:
	.ascii	"SYS_ERR_VM_MAP_OFFSET\000"
.LASF195:
	.ascii	"LIB_ERR_PMAP_UNMAP\000"
.LASF494:
	.ascii	"ETHERSRV_ERR_BUFFER_NOT_FOUND\000"
.LASF293:
	.ascii	"FLOUNDER_ERR_TX_BUSY\000"
.LASF73:
	.ascii	"SYS_ERR_IRQ_NOT_ENDPOINT\000"
.LASF50:
	.ascii	"SYS_ERR_DEST_TYPE_INVALID\000"
.LASF102:
	.ascii	"SYS_ERR_CROSS_MC\000"
.LASF588:
	.ascii	"NFS_ERR_BADHANDLE\000"
.LASF552:
	.ascii	"VFS_ERR_MOUNTPOINT_NOTFOUND\000"
.LASF62:
	.ascii	"SYS_ERR_FRAME_OFFSET_INVALID\000"
	.ident	"GCC: (Sourcery CodeBench Lite 2012.03-57) 4.6.3"
	.section	.note.GNU-stack,"",%progbits
