`timescale 1ns / 1ps

module tb_Instruction_Memory;

    // Inputs
    reg [31:0] addr;

    // Outputs
    wire [31:0] instruction;

    // Instantiate the Instruction Memory module
    Instruction_Memory im (
        .addr(addr),
        .instruction(instruction)
    );

    // Memory initialization (for simulation purposes)
    initial begin
        // Load instructions from file
        $readmemh("instructions.mem", im.memory);
    end

    // Testbench procedure
    initial begin
        // Test cases
        // Test address 0 (should read first instruction)
        addr = 32'h0;
        #10;  // Wait for 10 ns
        $display("Address: %h, Instruction: %h", addr, instruction);

        // Test address 4 (should read second instruction)
        addr = 32'h4;
        #10;
        $display("Address: %h, Instruction: %h", addr, instruction);

        // Test address 8 (should read third instruction)
        addr = 32'h8;
        #10;
        $display("Address: %h, Instruction: %h", addr, instruction);

        // Test address 12 (should read fourth instruction)
        addr = 32'hC;
        #10;
        $display("Address: %h, Instruction: %h", addr, instruction);

        // Test address 16 (out of range for 16 instructions)
        addr = 32'h10; // This address may not have a valid instruction
        #10;
        $display("Address: %h, Instruction: %h", addr, instruction); // Expecting undefined or zero

        // End simulation
        $finish;
    end

endmodule
