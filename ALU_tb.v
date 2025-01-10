`timescale 1ns / 1ps

module ALU_tb;

    reg clk;
    reg [31:0] A, B;
    reg [21:0] control_signals;
    wire [31:0] aluResult;
    wire [3:0] flags;

    // Instantiate the ALU module
    ALU alu_inst (
        .clk(clk),
        .A(A),
        .B(B),
        .control_signals(control_signals),
        .aluResult(aluResult),
        .flags(flags)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #2 clk = ~clk;  // Toggle clock every 5 time units
    end

    // Test sequence
    initial begin
        // Initialize inputs
        A = 32'h00000010;  // 16 in decimal
        B = 32'h00000004;  // 4 in decimal
        control_signals = 22'b0;

        // Monitor the outputs
        $monitor("Time: %0t | A: %h | B: %h | Result: %h | Flags: %b", $time, A, B, aluResult, flags);

        // Test addition
        #10 control_signals[9] = 1; // Set isAdd
        #10 control_signals[9] = 0; // Clear isAdd
        #10; // Allow ALU to compute
        #10 $display("Performed Addition: Result = %h | Flags = %b", aluResult, flags);

        // Test subtraction
        #10 
        $display("try");
        
        control_signals[10] = 1; // Set isSub
        #10 control_signals[10] = 0; // Clear isSub
        #10; // Allow ALU to compute
        #10 $display("Performed Subtraction: Result = %h | Flags = %b", aluResult, flags);

        // Test comparison
        #10 
        $display("Ahmad Siraj Hashmi");
        
        control_signals[11] = 1; // Set isCmp
        #10 control_signals[11] = 0; // Clear isCmp
        #10; // Allow ALU to compute
        #10 $display("Performed Comparison: Result = %h | Flags = %b", aluResult, flags);

        // Test multiplication
        #10 
        $display("you");
        
        control_signals[12] = 1; // Set isMul
        #10 control_signals[12] = 0; // Clear isMul
        #10; // Allow ALU to compute
        #10 $display("Performed Multiplication: Result = %h | Flags = %b", aluResult, flags);

        // Test division
        #10
        $display("Can"); 
        
        control_signals[13] = 1; // Set isDiv
        #10 control_signals[13] = 0; // Clear isDiv
        #10; // Allow ALU to compute
        #10 $display("Performed Division: Result = %h | Flags = %b", aluResult, flags);

        // Test modulus
        #10
        $display("Do"); 
        
        control_signals[14] = 1; // Set isMod
        #10 control_signals[14] = 0; // Clear isMod
        #10; // Allow ALU to compute
        #10 $display("Performed Modulus: Result = %h | Flags = %b", aluResult, flags);

        // Test logical operations
        #10 
        $display("it");
        
        
        control_signals[18] = 1; // Set isOr
        #10 control_signals[18] = 0; // Clear isOr
        #10; // Allow ALU to compute
        #10 $display("Performed Logical OR: Result = %h | Flags = %b", aluResult, flags);

        // Test NOT operation
        #10 
        $display("easily");
        
        control_signals[20] = 1; // Set isNot
        #10 control_signals[20] = 0; // Clear isNot
        #10; // Allow ALU to compute
        #10 $display("Performed Logical NOT: Result = %h | Flags = %b", aluResult, flags);

        // Test AND operation
        #10 control_signals[19] = 1; // Set isAnd
        #10 control_signals[19] = 0; // Clear isAnd
        #10; // Allow ALU
    end
endmodule
