module Top (
    input clk,                      // Clock signal
    input rst,
    output [31:0] reg_writedata,               // Current program counter (PC) from OF_stage
    output [3:0] reg_write_addr  // Change from [4:0] to [3:0]
     // Control signals from OF_stage
);

    // Internal signals to connect IF_stage and IF_stage_latch
    wire isBranchTaken_latch;
    wire [31:0] branchPC_latch;

    // Signals for IF_OF_Latch
    wire [31:0] pc_out_IF;
    wire [31:0] pc_out_IF_out;
    wire [31:0] instruction_out_IF;
    wire [31:0] instruction_out_IF_out;

    // Signals for OF_stage
    wire [31:0] pc_out_IF_lat;
    wire [31:0] pc_out_IF_out_lat;
    wire [31:0] instruction_out_IF_lat;
    wire [31:0] immux_lat;
    wire [31:0] branchTarget_lat;
    wire [31:0] OP1_latch;
    wire [31:0] OP2_latch;
    wire [31:0] B_latch;
    wire [31:0] A_latch;
    wire [21:0] control_signals_OF_latch;

    wire [31:0] pc_ex;
    wire [31:0] inst_ex;
    wire [31:0] immux_ex;
    wire [31:0] branchTarget_ex;
    wire [31:0] OP1_ex;
    wire [31:0] OP2_ex;
    wire [31:0] B_ex;
    wire [31:0] A_ex;
    wire [21:0] control_ex;

    wire [31:0] pc_ex_latch;
    wire [31:0] alu_res_ex_latch;
    wire [31:0] OP2_ex_latch;
    wire [31:0] inst_ex_latch;
    wire [21:0] control_signals_ex_latch;
    wire [31:0] branchpc_ex_latch;
    wire isBranchTak_ex_latch;
    wire [3:0] flg_ex_latch;

    wire [31:0] pc_MA_in;
    wire [31:0] alu_res_MA;
    wire [31:0] op2_MA;
    wire [31:0] inst_MA;
    wire [21:0] control_MA;
    
    wire [31:0] pc_mem_out;
    wire [31:0] alu_res_MA_out;
    wire [31:0] ld_res_MA_out;
    wire [31:0] inst_MA_out;
    wire [21:0] control_MA_out;

    wire [31:0] pc_rw;
    wire [31:0] ldRes_rw;
    wire [31:0] inst_rw;
    wire [31:0] alu_res_rw;
    wire [21:0] control_signals_rw;
    
    /* IF_stage_latch instantiation
    IF_stage_latch latch (
        .clk(clk),
        .rst(rst),
        .isBranchTaken(isBranchTak_ex_latch),
        .branchPC(branchpc_ex_latch),
        .isBranchTaken_out(isBranchTaken_latch),
        .branchPC_out(branchPC_latch)
    );

    //         .branchPC(branchpc_ex_latch),
      .isBranchTaken(isBranchTak_ex_latch),
      */ 

    wire [3:0] read_por_try1;
    wire [3:0] read_por_try2;
    wire [31:0] OP1_reg;
    wire [31:0] OP2_reg;
    wire isE;
    
    wire has_data_hazard;
    Fetch_Unit IF_stage (
        .clk(clk),
        .rst(rst),
        .isBranchTaken(isBranchTak_ex_latch),
        .branchPC(branchpc_ex_latch),
        .pc(pc_out_IF),
        .instruction(instruction_out_IF)
    );

    Conflict_Detector_unit conflict_det(
        .instructionA(instruction_out_IF_out),
        .instructionB(inst_ex),
        .has_hazard(has_data_hazard)
    );

    // IF_OF_Latch instantiation
    IF_OF_Latch if_of_latch (
        .isbranch_lock_for_IF_latch(isBranchTak_ex_latch),
        .hazard_from_data_lock(has_data_hazard),
        .clk(clk),
        .rst(rst),
        .pc_in(pc_out_IF),
        .instruction_in(instruction_out_IF),
        .pc_out(pc_out_IF_out),
        .instruction_out(instruction_out_IF_out)
    );
    
    regfile toprg(
        .clk(clk),
        .write_enable(isE),
        .read_reg1(read_por_try1),
        .read_reg2(read_por_try2),
        .write_reg(reg_write_addr),
        .write_data(reg_writedata),
        .read_data1(OP1_reg),
        .read_data2(OP2_reg)
    );


    // OF_stage instantiation
    OF_stage of_stage (
        
        .signal1_from_forwarding1_for_RW_OF(signal1_for_RW_OF),
        .signal2_from_forwarding2_for_RW_OF(signal2_for_RW_OF),
        .clk(clk),
        .OP1_input(OP1_reg),
        .OP2_input(OP2_reg),
        .Data_from_rw_for_OF(reg_writedata),
        .read_port1(read_por_try1),
        .read_port2(read_por_try2),
        .pc(pc_out_IF_out),
        .inst(instruction_out_IF_out),
        .inst_out(instruction_out_IF_lat),
        .pc_out(pc_out_IF_lat),
        .immx(immux_lat),
        .branchTarget(branchTarget_lat),
        .OP1(OP1_latch),
        .OP2(OP2_latch),
        .B(B_latch),
        .A(A_latch),
        .control_signals_out(control_signals_OF_latch)
    );

    // OF_stage_latch instantiation
    OF_stage_latch of_stage_latch (
        .isbranch_lock_for_OF_latch(isBranchTak_ex_latch),
        .hazard_from_data_lock_for_of_lat(has_data_hazard),
        .clk(clk),
        .rst(rst),
        .inst_out_in(instruction_out_IF_lat),
        .pc_out_in(pc_out_IF_lat),
        .immx_in(immux_lat),
        .branchTarget_in(branchTarget_lat),
        .OP1_in(OP1_latch),
        .OP2_in(OP2_latch),
        .B_in(B_latch),
        .A_in(A_latch),
        .control_signals_out_in(control_signals_OF_latch),
        .inst_out(inst_ex),
        .pc_out(pc_ex),
        .immx(immux_ex),
        .branchTarget(branchTarget_ex),
        .OP1(OP1_ex),
        .OP2(OP2_ex),
        .B(B_ex),
        .A(A_ex),
        .control_signals_out(control_ex)
    );
    
    wire signal1_for_MA_EX;
    wire signal2_for_MA_EX;

    forwarding_unit1 forwarding_for_MA_EX_1(// this is for EX-MA stage forwarding 
        .A(inst_ex),//first instruction is going here 
        .B(inst_MA),//second instruction is going here 
        .conflict(signal1_for_MA_EX)//
    );
    forwarding_unit2 forwarding_for_MA_EX_2(
        .A(inst_ex),
        .B(inst_MA),
        .conflict(signal2_for_MA_EX)

    );
    
    wire signal1_for_RW_OF;
    wire signal2_for_RW_OF;

    forwarding_unit1 forwarding_for_RW_OF_1(// this is for EX-MA stage forwarding 
        .A(instruction_out_IF_out),
        .B(inst_rw), 
        .conflict(signal1_for_RW_OF)//
    );
    forwarding_unit2 forwarding_for_RW_OF_2(
        .A(instruction_out_IF_out),
        .B(inst_rw),//second instruction
        .conflict(signal2_for_RW_OF)
    );
    
    wire signal1_for_RW_EX;
    wire signal2_for_RW_EX;

    forwarding_unit1 forwarding_for_RW_EX_1(
        .A(inst_ex),
        .B(inst_rw),
        .conflict(signal1_for_RW_EX)
    );

    forwarding_unit2 forwarding_for_RW_EX_2(
        .A(inst_ex),
        .B(inst_rw),
        .conflict(signal2_for_RW_EX)
    );
    
    wire signal1_for_RW_MA;
    wire signal2_for_RW_MA;

    forwarding_unit1 forwarding_for_RW_MA_1(
        .A(inst_MA),
        .B(inst_rw),
        .conflict(signal1_for_RW_MA)
    );

    forwarding_unit2 forwarding_for_RW_MA_2(
         .clk(clk),
        .A(inst_MA),
        .B(inst_rw),
        .conflict(signal2_for_RW_MA)
    );

    // EX_stage instantiation
    EX_stage xstage(
        .forwarding_signal1_for_RW_EX(signal1_for_RW_EX),
        .forwarding_signal2_for_RW_EX(signal2_for_RW_EX),
        .forwarding_signal1_for_MA_EX(signal1_for_MA_EX),
        .forwarding_signal2_for_MA_EX(signal2_for_MA_EX),
        .clk(clk),
        .rst(rst),
        .inst_out(inst_ex),
        .pc_out(pc_ex),
        .branchTarget(branchTarget_ex),
        .B(B_ex),
        .A(A_ex),
        .O2(OP2_ex),
        .control_signals_out(control_ex),
        .Data_from_rw_for_EX(reg_writedata),
        .ALUres_from_bahar(alu_res_MA),
        .pc_to_ma(pc_ex_latch),
        .aluResult(alu_res_ex_latch),
        .op2(OP2_ex_latch),
        .inst_out_ex(inst_ex_latch),
        .control_signals_ex(control_signals_ex_latch),
        .branchPC(branchpc_ex_latch),
        .isBranchTaken(isBranchTak_ex_latch),
        .flags(flg_ex_latch)
    );

    // EX_stage_latch instantiation
    EX_stage_latch ex_stage_latch (
        .clk(clk),
        .rst(rst),
        .pc_to_ma_in(pc_ex_latch),
        .aluResult_in(alu_res_ex_latch),
        .op2_in(OP2_ex_latch),
        .inst_out_ex_in(inst_ex_latch),
        .control_signals_ex_in(control_signals_ex_latch),
        .flags_in(flg_ex_latch),
        .pc_to_ma(pc_MA_in),
        .aluResult(alu_res_MA),
        .op2(op2_MA),
        .inst_out_ex(inst_MA),
        .control_signals_ex(control_MA)
    );

    // MA_stage instantiation
    MA_stage ma (
        .rst(rst),
        .pc_MA_in(pc_MA_in),
        .aluResult(alu_res_MA),
        .op2(op2_MA),
        .inst_out_ex(inst_MA),
        .control_signals_ex(control_MA),
        .Data_from_rw_for_MA(reg_writedata),
        .signal1_from_forwarding_RW_MA(signal1_for_RW_MA),
        .signal2_from_forwarding_RW_MA(signal2_for_RW_MA),
        .signal_from_forwarding(1'b0),
        .pc_MA_out(pc_mem_out),
        .alu_res_MA(alu_res_MA_out),
        .ldResult(ld_res_MA_out),
        .inst_out_ma(inst_MA_out),
        .control_MA(control_MA_out)
    );

    MA_stage_latch ma_latch(
        .clk(clk),
        .rst(rst),
        .pc_MA_out_in(pc_mem_out),
        .ldResult_in(ld_res_MA_out),
        .inst_out_ma_in(inst_MA_out),
        .alu_res_MA_in(alu_res_MA_out),
        .control_MA_in(control_MA_out),
        .pc_MA_out(pc_rw),
        .ldResult(ldRes_rw),
        .inst_out_ma(inst_rw),
        .alu_res_MA(alu_res_rw),
        .control_MA(control_signals_rw)

    );


    RW_stage RW_stage(
        .clk(clk),
        .rst(rst),
        .pc_in(pc_rw),
        .ldResult(ldRes_rw),
        .aluResult(alu_res_rw),
        .inst_in(inst_rw),
        .control_in(control_signals_rw),
        .isEnable(isE),
        .reg_write_address(reg_write_addr),
        .reg_write_data(reg_writedata)
    );
endmodule
