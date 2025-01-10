module Fetch_Unit (
    input clk,                   // Clock signal
    input rst,                   // Reset signal
    input isBranchTaken,         // Control signal for branching
    input [31:0] branchPC,       // Branch target address
    output reg [31:0] pc,        // Current program counter (PC)
    output [31:0] instruction    // Instruction from memory
);

    // Initialize PC to zero
    initial begin
        pc = 32'd0;
    end

    // PC logic (update PC based on branching or normal increment)
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            pc <= 32'd0;  // Reset PC to 0
        end else if (isBranchTaken) begin
            pc <= branchPC;  // Set PC to branch target address if branch is taken
        end else begin
            pc <= pc + 32'd4;  // Increment PC by 4 (fetch next instruction)
        end
    end

    // Instruction Memory (you can replace this with actual memory initialization)
    Instruction_Memory inst_mem (
        .addr(pc),
        .instruction(instruction)
    );

endmodule

// Instruction memory model (replace this with actual instruction loading)
module Instruction_Memory (
    input [31:0] addr,        // PC or address input
    output reg [31:0] instruction  // Instruction output
);

    reg [31:0] memory [0:255];  // Memory with 256 instructions (adjust as needed)

    initial begin
        // You can load instructions here (using $readmemh or manually)
        $readmemh("instruction.mem", memory);  // Load instructions from a file
    end

    always @(*) begin
        instruction = memory[addr[31:2]];  // Fetch instruction at the current address
    end
endmodule

module Fetch_Unit_tb;

    // Test bench signals
    reg clk;
    reg rst;
    reg isBranchTaken;
    reg [31:0] branchPC;
    wire [31:0] pc;
    wire [31:0] instruction;

    // Instantiate the Fetch_Unit
    Fetch_Unit uut (
        .clk(clk),
        .rst(rst),
        .isBranchTaken(isBranchTaken),
        .branchPC(branchPC),
        .pc(pc),
        .instruction(instruction)
    );

    // Clock generation (50MHz)
    initial begin
        clk = 0;
        forever #10 clk = ~clk;  // 20ns period (50MHz clock)
    end

    // Test procedure
    initial begin
        // Monitor the output (PC and instruction)
        $monitor("At time %t, PC: %h, Instruction: %h", $time, pc, instruction);

        // Initialize signals
        rst = 1;           // Hold reset for a few cycles
        isBranchTaken = 0;
        branchPC = 32'd0;

        // Reset sequence
        #25 rst = 0;       // Release reset after a short delay

        // Run simulation for a while to fetch instructions
        #200 $finish;
    end

    // Branch test after a few instruction fetches
    initial begin
        // Wait for a few cycles, then branch
        #80 isBranchTaken = 1; branchPC = 32'h00000020; // Set branch to address 0x20
        #20 isBranchTaken = 0;  // Return to normal fetching
    end

endmodule
