module Fetch_Unit (
    input has_data_hazard_for_IF_stage,
    input clk,                   
    input rst,                   
    input isBranchTaken,         
    input [31:0] branchPC,       
    output reg [31:0] pc,      
    output reg [31:0] instruction_reg, 
    output [31:0] instruction    
);

    // Initialize PC to zero
    initial begin
        pc = 32'd0;
        instruction_reg = 32'd0;  
    end

   // wire temp = isBranchTaken ? branchPC : pc + 32'd4;

    // PC logic (update PC based on branching or normal increment)
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            pc <= 32'd0;  
            // instruction_reg <= 32'd0; 
        end 
        else if (isBranchTaken) begin
            //pc<=32'b0;
            pc = branchPC;  
        // end else if (has_data_hazard_for_IF_stage==1'b0) begin
        end else begin
             pc <= pc + 32'd4;
        end
        // else begin
        //     pc = temp;
        // end
    end

    // Instruction Memory: Fetch the instruction
    Instruction_Memory inst_mem (
        .addr(pc),
        .instruction(instruction) 
    );

    // Latch the instruction into the instruction register on every clock cycle
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            instruction_reg <= 32'd0;  
        end else begin
            instruction_reg <= instruction;  
        end
    end

endmodule
