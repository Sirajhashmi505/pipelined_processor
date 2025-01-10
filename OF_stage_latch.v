module OF_stage_latch (
    input isbranch_lock_for_OF_latch,
    input hazard_from_data_lock_for_of_lat,
    input clk,
    input rst,
    input [31:0] inst_out_in,
    input [31:0] pc_out_in,
    input [31:0] immx_in,
    input [31:0] branchTarget_in,
    input [31:0] OP1_in,
    input [31:0] OP2_in,
    input [31:0] B_in,
    input [31:0] A_in,
    input [21:0] control_signals_out_in,

    output reg [31:0] inst_out,
    output reg [31:0] pc_out,
    output reg [31:0] immx,
    output reg [31:0] branchTarget,
    output reg [31:0] OP1,
    output reg [31:0] OP2,
    output reg [31:0] B,
    output reg [31:0] A,
    output reg [21:0] control_signals_out
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            //inst_out <= 32'b0;
            pc_out <= 32'b0;
            immx <= 32'b0;
            branchTarget <= 32'b0;
            OP1 <= 32'b0;
            OP2 <= 32'b0;
            B <= 32'b0;
            A <= 32'b0;
            control_signals_out <= 22'b0;
        end else if ((isbranch_lock_for_OF_latch)==1'b1 || (hazard_from_data_lock_for_of_lat==1'b1)) begin
            inst_out <= 32'h68000000;
            control_signals_out <= 22'b0;
        // end else if (hazard_from_data_lock_for_of_lat==1'b1) begin
        //     inst_out <= inst_out;
        //     control_signals_out <= control_signals_out;
        end else begin
            inst_out <= inst_out_in;
            pc_out <= pc_out_in;
            immx <= immx_in;
            branchTarget <= branchTarget_in;
            OP1 <= OP1_in;
            OP2 <= OP2_in;
            B <= B_in;
            A <= A_in;
            control_signals_out <= control_signals_out_in;
        end
    end

endmodule
