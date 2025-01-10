#! /usr/bin/vvp
:ivl_version "11.0 (stable)";
:ivl_delay_selection "TYPICAL";
:vpi_time_precision + 0;
:vpi_module "/usr/lib/x86_64-linux-gnu/ivl/system.vpi";
:vpi_module "/usr/lib/x86_64-linux-gnu/ivl/vhdl_sys.vpi";
:vpi_module "/usr/lib/x86_64-linux-gnu/ivl/vhdl_textio.vpi";
:vpi_module "/usr/lib/x86_64-linux-gnu/ivl/v2005_math.vpi";
:vpi_module "/usr/lib/x86_64-linux-gnu/ivl/va_math.vpi";
S_0x567eddb36940 .scope module, "Top_tb" "Top_tb" 2 1;
 .timescale 0 0;
v0x567eddb52480_0 .var "branchPC", 31 0;
v0x567eddb525b0_0 .var "clk", 0 0;
v0x567eddb52670_0 .net "instruction", 31 0, v0x567eddb1ef10_0;  1 drivers
v0x567eddb52710_0 .var "isBranchTaken", 0 0;
v0x567eddb52800_0 .net "pc", 31 0, v0x567eddb511f0_0;  1 drivers
v0x567eddb528f0_0 .var "rst", 0 0;
S_0x567eddb36ad0 .scope module, "uut" "Top" 2 12, 3 1 0, S_0x567eddb36940;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "clk";
    .port_info 1 /INPUT 1 "rst";
    .port_info 2 /INPUT 1 "isBranchTaken";
    .port_info 3 /INPUT 32 "branchPC";
    .port_info 4 /OUTPUT 32 "pc";
    .port_info 5 /OUTPUT 32 "instruction";
v0x567eddb51c20_0 .net "branchPC", 31 0, v0x567eddb52480_0;  1 drivers
v0x567eddb51d30_0 .net "branchPC_latch", 31 0, v0x567eddb517b0_0;  1 drivers
v0x567eddb51e20_0 .net "clk", 0 0, v0x567eddb525b0_0;  1 drivers
v0x567eddb51f10_0 .net "instruction", 31 0, v0x567eddb1ef10_0;  alias, 1 drivers
v0x567eddb52000_0 .net "isBranchTaken", 0 0, v0x567eddb52710_0;  1 drivers
v0x567eddb520f0_0 .net "isBranchTaken_latch", 0 0, v0x567eddb519e0_0;  1 drivers
v0x567eddb521e0_0 .net "pc", 31 0, v0x567eddb511f0_0;  alias, 1 drivers
v0x567eddb522d0_0 .net "rst", 0 0, v0x567eddb528f0_0;  1 drivers
S_0x567eddb39650 .scope module, "IF_stage" "Fetch_Unit" 3 25, 4 1 0, S_0x567eddb36ad0;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "clk";
    .port_info 1 /INPUT 1 "rst";
    .port_info 2 /INPUT 1 "isBranchTaken";
    .port_info 3 /INPUT 32 "branchPC";
    .port_info 4 /OUTPUT 32 "pc";
    .port_info 5 /OUTPUT 32 "instruction_reg";
    .port_info 6 /OUTPUT 32 "instruction";
v0x567eddb50de0_0 .net "branchPC", 31 0, v0x567eddb517b0_0;  alias, 1 drivers
v0x567eddb50ec0_0 .net "clk", 0 0, v0x567eddb525b0_0;  alias, 1 drivers
v0x567eddb50f80_0 .net "instruction", 31 0, v0x567eddb1ef10_0;  alias, 1 drivers
v0x567eddb51020_0 .var "instruction_reg", 31 0;
v0x567eddb510e0_0 .net "isBranchTaken", 0 0, v0x567eddb519e0_0;  alias, 1 drivers
v0x567eddb511f0_0 .var "pc", 31 0;
v0x567eddb512b0_0 .net "rst", 0 0, v0x567eddb528f0_0;  alias, 1 drivers
E_0x567eddb16a30 .event posedge, v0x567eddb512b0_0, v0x567eddb50ec0_0;
S_0x567eddb398e0 .scope module, "inst_mem" "Instruction_Memory" 4 30, 5 2 0, S_0x567eddb39650;
 .timescale 0 0;
    .port_info 0 /INPUT 32 "addr";
    .port_info 1 /OUTPUT 32 "instruction";
v0x567eddaf47b0_0 .net "addr", 31 0, v0x567eddb511f0_0;  alias, 1 drivers
v0x567eddb1ef10_0 .var "instruction", 31 0;
v0x567eddb1efb0 .array "memory", 15 0, 31 0;
v0x567eddb1efb0_0 .array/port v0x567eddb1efb0, 0;
v0x567eddb1efb0_1 .array/port v0x567eddb1efb0, 1;
v0x567eddb1efb0_2 .array/port v0x567eddb1efb0, 2;
E_0x567eddb20cf0/0 .event edge, v0x567eddaf47b0_0, v0x567eddb1efb0_0, v0x567eddb1efb0_1, v0x567eddb1efb0_2;
v0x567eddb1efb0_3 .array/port v0x567eddb1efb0, 3;
v0x567eddb1efb0_4 .array/port v0x567eddb1efb0, 4;
v0x567eddb1efb0_5 .array/port v0x567eddb1efb0, 5;
v0x567eddb1efb0_6 .array/port v0x567eddb1efb0, 6;
E_0x567eddb20cf0/1 .event edge, v0x567eddb1efb0_3, v0x567eddb1efb0_4, v0x567eddb1efb0_5, v0x567eddb1efb0_6;
v0x567eddb1efb0_7 .array/port v0x567eddb1efb0, 7;
v0x567eddb1efb0_8 .array/port v0x567eddb1efb0, 8;
v0x567eddb1efb0_9 .array/port v0x567eddb1efb0, 9;
v0x567eddb1efb0_10 .array/port v0x567eddb1efb0, 10;
E_0x567eddb20cf0/2 .event edge, v0x567eddb1efb0_7, v0x567eddb1efb0_8, v0x567eddb1efb0_9, v0x567eddb1efb0_10;
v0x567eddb1efb0_11 .array/port v0x567eddb1efb0, 11;
v0x567eddb1efb0_12 .array/port v0x567eddb1efb0, 12;
v0x567eddb1efb0_13 .array/port v0x567eddb1efb0, 13;
v0x567eddb1efb0_14 .array/port v0x567eddb1efb0, 14;
E_0x567eddb20cf0/3 .event edge, v0x567eddb1efb0_11, v0x567eddb1efb0_12, v0x567eddb1efb0_13, v0x567eddb1efb0_14;
v0x567eddb1efb0_15 .array/port v0x567eddb1efb0, 15;
E_0x567eddb20cf0/4 .event edge, v0x567eddb1efb0_15;
E_0x567eddb20cf0 .event/or E_0x567eddb20cf0/0, E_0x567eddb20cf0/1, E_0x567eddb20cf0/2, E_0x567eddb20cf0/3, E_0x567eddb20cf0/4;
S_0x567eddb51430 .scope module, "latch" "IF_stage_latch" 3 15, 6 1 0, S_0x567eddb36ad0;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "clk";
    .port_info 1 /INPUT 1 "rst";
    .port_info 2 /INPUT 1 "isBranchTaken";
    .port_info 3 /INPUT 32 "branchPC";
    .port_info 4 /OUTPUT 1 "isBranchTaken_out";
    .port_info 5 /OUTPUT 32 "branchPC_out";
v0x567eddb516d0_0 .net "branchPC", 31 0, v0x567eddb52480_0;  alias, 1 drivers
v0x567eddb517b0_0 .var "branchPC_out", 31 0;
v0x567eddb51870_0 .net "clk", 0 0, v0x567eddb525b0_0;  alias, 1 drivers
v0x567eddb51940_0 .net "isBranchTaken", 0 0, v0x567eddb52710_0;  alias, 1 drivers
v0x567eddb519e0_0 .var "isBranchTaken_out", 0 0;
v0x567eddb51ad0_0 .net "rst", 0 0, v0x567eddb528f0_0;  alias, 1 drivers
    .scope S_0x567eddb51430;
T_0 ;
    %wait E_0x567eddb16a30;
    %load/vec4 v0x567eddb51ad0_0;
    %flag_set/vec4 8;
    %jmp/0xz  T_0.0, 8;
    %pushi/vec4 0, 0, 1;
    %assign/vec4 v0x567eddb519e0_0, 0;
    %pushi/vec4 0, 0, 32;
    %assign/vec4 v0x567eddb517b0_0, 0;
    %jmp T_0.1;
T_0.0 ;
    %load/vec4 v0x567eddb51940_0;
    %assign/vec4 v0x567eddb519e0_0, 0;
    %load/vec4 v0x567eddb516d0_0;
    %assign/vec4 v0x567eddb517b0_0, 0;
T_0.1 ;
    %jmp T_0;
    .thread T_0;
    .scope S_0x567eddb398e0;
T_1 ;
    %vpi_call 5 12 "$readmemh", "instructions.mem", v0x567eddb1efb0 {0 0 0};
    %end;
    .thread T_1;
    .scope S_0x567eddb398e0;
T_2 ;
    %wait E_0x567eddb20cf0;
    %vpi_call 5 16 "$display", "Fetching instruction from addr: %h", v0x567eddaf47b0_0 {0 0 0};
    %load/vec4 v0x567eddaf47b0_0;
    %parti/s 30, 2, 3;
    %ix/vec4 4;
    %load/vec4a v0x567eddb1efb0, 4;
    %store/vec4 v0x567eddb1ef10_0, 0, 32;
    %jmp T_2;
    .thread T_2, $push;
    .scope S_0x567eddb39650;
T_3 ;
    %pushi/vec4 0, 0, 32;
    %store/vec4 v0x567eddb511f0_0, 0, 32;
    %pushi/vec4 0, 0, 32;
    %store/vec4 v0x567eddb51020_0, 0, 32;
    %end;
    .thread T_3;
    .scope S_0x567eddb39650;
T_4 ;
    %wait E_0x567eddb16a30;
    %load/vec4 v0x567eddb512b0_0;
    %flag_set/vec4 8;
    %jmp/0xz  T_4.0, 8;
    %pushi/vec4 0, 0, 32;
    %assign/vec4 v0x567eddb511f0_0, 0;
    %pushi/vec4 0, 0, 32;
    %assign/vec4 v0x567eddb51020_0, 0;
    %jmp T_4.1;
T_4.0 ;
    %load/vec4 v0x567eddb510e0_0;
    %flag_set/vec4 8;
    %jmp/0xz  T_4.2, 8;
    %load/vec4 v0x567eddb50de0_0;
    %assign/vec4 v0x567eddb511f0_0, 0;
    %jmp T_4.3;
T_4.2 ;
    %load/vec4 v0x567eddb511f0_0;
    %addi 4, 0, 32;
    %assign/vec4 v0x567eddb511f0_0, 0;
T_4.3 ;
T_4.1 ;
    %jmp T_4;
    .thread T_4;
    .scope S_0x567eddb39650;
T_5 ;
    %wait E_0x567eddb16a30;
    %load/vec4 v0x567eddb512b0_0;
    %flag_set/vec4 8;
    %jmp/0xz  T_5.0, 8;
    %pushi/vec4 0, 0, 32;
    %assign/vec4 v0x567eddb51020_0, 0;
    %jmp T_5.1;
T_5.0 ;
    %load/vec4 v0x567eddb50f80_0;
    %assign/vec4 v0x567eddb51020_0, 0;
T_5.1 ;
    %jmp T_5;
    .thread T_5;
    .scope S_0x567eddb36940;
T_6 ;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x567eddb525b0_0, 0, 1;
T_6.0 ;
    %delay 5, 0;
    %load/vec4 v0x567eddb525b0_0;
    %inv;
    %store/vec4 v0x567eddb525b0_0, 0, 1;
    %jmp T_6.0;
    %end;
    .thread T_6;
    .scope S_0x567eddb36940;
T_7 ;
    %pushi/vec4 1, 0, 1;
    %store/vec4 v0x567eddb528f0_0, 0, 1;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x567eddb52710_0, 0, 1;
    %pushi/vec4 0, 0, 32;
    %store/vec4 v0x567eddb52480_0, 0, 32;
    %delay 10, 0;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x567eddb528f0_0, 0, 1;
    %delay 200, 0;
    %delay 50, 0;
    %vpi_call 2 43 "$stop" {0 0 0};
    %end;
    .thread T_7;
    .scope S_0x567eddb36940;
T_8 ;
    %vpi_call 2 48 "$monitor", "Time: %0t | rst: %b | isBranchTaken: %b | pc: %h | instruction: %h", $time, v0x567eddb528f0_0, v0x567eddb52710_0, v0x567eddb52800_0, v0x567eddb52670_0 {0 0 0};
    %end;
    .thread T_8;
# The file index is used to find the file name in the following table.
:file_names 7;
    "N/A";
    "<interactive>";
    "top_tb.v";
    "Top.v";
    "IF_stage.v";
    "Instruction_memory.v";
    "IF_stage_latch.v";
