module EX_stage (
    input clk,
    input rst,
    input [31:0] inst_out,
    input [31:0] pc_out,
    input [31:0] branchTarget,
    input [31:0] B,
    input [31:0] A,
    input [31:0] O2,
    input [21:0] control_signals_out,
    input [31:0] Data_from_rw_for_EX,
    input [31:0] ALUres_from_bahar,
    input forwarding_signal1_for_RW_EX,
    input forwarding_signal2_for_RW_EX,
    input forwarding_signal1_for_MA_EX,
    input forwarding_signal2_for_MA_EX,
    output reg [31:0] pc_to_ma,
    output reg signed [31:0] aluResult,
    output reg [31:0] op2,
    output reg [31:0] inst_out_ex,
    output reg [21:0] control_signals_ex,
    output wire [31:0] branchPC,
    output wire isBranchTaken,
    output reg [3:0] flags // Status flags from ALU
);

    wire [31:0] alu_result_wire;
    wire [3:0] alu_flags;
    wire [31:0] final_op2;
    wire [31:0] final_A_for_ALU;
    wire [31:0] final_B_for_ALU;


    new_mux_3to1 mux1_for_forwarding(

        .a(A),
        .l(Data_from_rw_for_EX),
        .p(ALUres_from_bahar),
          .sel0(forwarding_signal1_for_RW_EX),
        .sel1(forwarding_signal1_for_MA_EX),

        .result(final_A_for_ALU)
    );    

     new_mux_3to1 mux2_for_forwarding(

        .a(B),
        .l(Data_from_rw_for_EX),
        .p(ALUres_from_bahar),
        .sel0(forwarding_signal2_for_RW_EX),
        .sel1(forwarding_signal2_for_MA_EX),
     

        .result(final_B_for_ALU)
    );

    Mux2x1_32bit op2_mux_in_EX(
        .in0(O2),
        .in1(Data_from_rw_for_EX),
        .sel(forwarding_signal2_for_RW_EX),       
        .out(final_op2)
    );
    //Above are forwarding muxes 
    // ALU instantiation
    ALU alu (
        .A(final_A_for_ALU),
        .B(final_B_for_ALU),
        .control_signals(control_signals_out),
        .aluResult(alu_result_wire),
        .flags(alu_flags)
    );

    Mux2x1_32bit mux(
        .in0(branchTarget),
        .in1(A),
        .sel(control_signals_out[4]),       // Use control_signals[4] (isImmediate)
        .out(branchPC)
    );
    


    // Branch Unit Logic
    Branch_unit bunit(
        .alu_flg(alu_flags),
        .control_signals(control_signals_out),
        .iBRT(isBranchTaken)
    );

    always @(*) begin
        // Combinational Logic
        pc_to_ma = pc_out;
        aluResult = alu_result_wire;
        flags = alu_flags;
        control_signals_ex = control_signals_out;
        op2 = final_op2;
        inst_out_ex = inst_out;
    end
endmodule


module Branch_unit(
    input [3:0] alu_flg,         // Flags from ALU
    input [21:0] control_signals,   // Control signals
    output reg iBRT          // Branch taken signal (branch target address or indicator)
);

    // Decode flags from alu_flags input
    wire E_flag = alu_flg[0];     // Zero flag
    wire GT_flag = alu_flg[1];    // Greater than zero flag

    // Decode control signals
    wire isBeq = control_signals[2];    // Branch if equal
    wire isBgt = control_signals[3];    // Branch if greater than zero
    wire isUbranch = control_signals[7]; // Unconditional branch

    // Determine if branch is taken
    wire isBranchTaken = (isBeq && E_flag) || (isBgt && GT_flag) || isUbranch;

    always @(*) begin
        if (isBranchTaken) begin
            iBRT <= 1'b1;  // Branch taken
        end else begin
            iBRT <= 1'b0;  // No branch taken
        end
    end


endmodule
