// Instruction memory model (replace this with actual instruction loading)
module Instruction_Memory (
    input [31:0] addr,        // PC or address input
    output reg [31:0] instruction  // Instruction output
);

    reg [31:0] memory [0:1024];  // Memory with 16 instructions


    initial begin
        // You can load instructions here (using $readmemh or manually)
        $readmemh("instructions.mem", memory);  // Load instructions from a file
    end

    always @(*) begin
         //$display("Fetching instruction from addr: %h", addr);
        instruction = memory[addr[31:2]];  // Fetch instruction at the current address
    end
endmodule