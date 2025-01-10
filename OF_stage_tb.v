`timescale 1ns / 1ps

module OF_stage_tb;

    reg clk;
    reg rst;
    reg [31:0] pc;
    reg [31:0] inst;
    wire [31:0] immx;
    wire [31:0] branchTarget;
    wire [3:0] read_port1;
    wire [3:0] read_port2;

    // Instantiate the OF_stage module
    OF_stage uut (
        .clk(clk),
        .rst(rst),
        .pc(pc),
        .inst(inst),
        .immx(immx),
        .branchTarget(branchTarget),
        .read_port1(read_port1),
        .read_port2(read_port2)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Toggle clock every 5 time units
    end

    initial begin
        rst = 1;                // Assert reset
        pc = 32'h00000000;      // Initialize program counter
        inst = 32'h00000000;    // Initialize instruction
        #10 rst = 0;            // De-assert reset

        // Apply test vectors
        #10 inst = 32'b00000000000000000000000000000000; // Test case 1
        #10 inst = 32'b00000000000000000000000000000001; // Test case 2
        #10 inst = 32'b00000000000000000000000000000010; // Test case 3
        #10 inst = 32'b00000000000000000000000000000011; // Test case 4
        
        $display("Test Complete");
        #10 $finish; // Finish simulation
    end

    // Monitor outputs
    initial begin
        $monitor("Time: %0t | read_port1: %b | read_port2: %b", $time, read_port1, read_port2);
    end

endmodule
