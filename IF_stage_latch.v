module IF_stage_latch (
    
    input clk,                   // Clock signal
    input rst,                   // Reset signal
    input isBranchTaken,         // Control signal for branching
    input [31:0] branchPC,       // Branch target address
    output reg isBranchTaken_out, // Output for isBranchTaken
    output reg [31:0] branchPC_out // Output for branchPC
);
    // On clock edge, update outputs or reset
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset outputs
            isBranchTaken_out <= 1'b0; // Reset output of isBranchTaken
            branchPC_out <= 32'b0;      // Reset output of branchPC
        end else begin
            // Latch the inputs
            isBranchTaken_out <= isBranchTaken; // Latch the input
            branchPC_out <= branchPC;           // Latch the input
        end
    end
endmodule
