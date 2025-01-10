module EX_stage_latch (
    input clk,
    input rst,
    input [31:0] pc_to_ma_in,
    input [31:0] aluResult_in,
    input [31:0] op2_in,
    input [31:0] inst_out_ex_in,
    input [21:0] control_signals_ex_in,
    input [31:0] branchPC_in,
    input isBranchTaken_in,
    input [3:0] flags_in,

    output reg [31:0] pc_to_ma,
    output reg [31:0] aluResult,
    output reg [31:0] op2,
    output reg [31:0] inst_out_ex,
    output reg [21:0] control_signals_ex,
    output reg [31:0] branchPC,
    output reg isBranchTaken,
    output reg [3:0] flags
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset all outputs to zero when reset is active
            pc_to_ma <= 32'b0;
            aluResult <= 32'b0;
            op2 <= 32'b0;
            //inst_out_ex <= 32'b0;
            control_signals_ex <= 22'b0;
            branchPC <= 32'b0;
            isBranchTaken <= 1'b0;
            flags <= 4'b0;
        end else begin
            // On positive edge of the clock, latch all inputs to outputs
            pc_to_ma <= pc_to_ma_in;
            aluResult <= aluResult_in;
            op2 <= op2_in;
            inst_out_ex <= inst_out_ex_in;
            control_signals_ex <= control_signals_ex_in;
            branchPC <= branchPC_in;
            isBranchTaken <= isBranchTaken_in;
            flags <= flags_in;
        end
    end

endmodule
