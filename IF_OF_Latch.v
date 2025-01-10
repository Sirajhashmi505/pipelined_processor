module IF_OF_Latch (
    input isbranch_lock_for_IF_latch,   // Branch lock signal
    input hazard_from_data_lock,
    input clk,                           // Clock signal
    input rst,                           // Reset signal
    input [31:0] pc_in,                  // Input: PC from IF stage
    input [31:0] instruction_in,         // Input: Instruction from IF stage
    output reg [31:0] pc_out,            // Output: PC to OF stage
    output reg [31:0] instruction_out   // Output: Instruction to OF stage
);

    // Reset or load values on the rising edge of the clock
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset the latch outputs to 0 on reset
            pc_out <= 32'd0;
            //instruction_out <= 32'd0;
        end
        else if (isbranch_lock_for_IF_latch) begin
            // If branch lock is active, set PC to 0 and instruction to NOP
            //pc_out <= 32'd0;
            instruction_out <= 32'h68000000;  // NOP instruction
        end
         else if (hazard_from_data_lock==1'b1) begin
                $display("hazard");
                 pc_out <= pc_out;
            instruction_out <= instruction_out;
        end
        else begin
            // Otherwise, pass the input values to the outputs
            pc_out <= pc_in;
            instruction_out <= instruction_in;
        end
    end

endmodule
