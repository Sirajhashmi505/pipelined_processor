module MA_stage_latch (
    input clk,                           // Clock signal
    input rst,                           // Reset signal
    input [31:0] pc_MA_out_in,           // Program counter input from MA stage
    input [31:0] ldResult_in,            // Load result from MA stage
    input [31:0] inst_out_ma_in,         // Instruction output from MA stage
    input [31:0] alu_res_MA_in,          // ALU result from MA stage
    input [21:0] control_MA_in,          // Control signals from MA stage

    output reg [31:0] pc_MA_out,         // Program counter output to next stage
    output reg [31:0] ldResult,          // Load result output to next stage
    output reg [31:0] inst_out_ma,       // Instruction output to next stage
    output reg [31:0] alu_res_MA,        // ALU result output to next stage
    output reg [21:0] control_MA         // Control signals output to next stage
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset outputs
            pc_MA_out <= 32'b0;
            ldResult <= 32'b0;
            //inst_out_ma <= 32'b0;
            alu_res_MA <= 32'b0;
            control_MA <= 22'b0;
        end else begin
            // Latch inputs to outputs on positive clock edge
            pc_MA_out <= pc_MA_out_in;
            ldResult <= ldResult_in;
            inst_out_ma <= inst_out_ma_in;
            alu_res_MA <= alu_res_MA_in;
            control_MA <= control_MA_in;
        end
    end
endmodule
