`timescale 1ns / 1ps

module test_bench;

    reg [31:0] addr;                     // Address input
    wire [31:0] instruction;             // Instruction output

    // Instantiate the Instruction Memory
    Instruction_Memory im (
        .addr(addr),
        .instruction(instruction)
    );

    initial begin
        // Load instructions from a file
        $readmemh("instructions.mem", im.memory);  // Directly access memory in the instance
        
        // Initialize the address to 0
        addr = 0;
        
        // Iterate through all possible addresses, incrementing by 4 each time
        for (integer i = 0; i < 16; i = i + 1) begin
            #10;  // Wait for some time for the instruction to be fetched
            $display("Instruction at addr %h: %h", addr, instruction);
            addr = addr + 4;  // Increment address by 4
        end
        
        // End the simulation
        $finish;
    end

endmodule
