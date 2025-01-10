`timescale 1ns / 1ps

module RW_stage_tb;

    // Parameters
    reg clk;
    reg rst;
    reg [31:0] pc_in;
    reg [31:0] ldResult;
    reg [31:0] aluResult;
    reg [31:0] inst_in;
    reg [21:0] control_in;

    // Outputs
    wire [3:0] reg_write_address;
    wire [31:0] reg_write_data;

    // Instantiate the RW_stage module
    RW_stage uut (
        .clk(clk),
        .rst(rst),
        .pc_in(pc_in),
        .ldResult(ldResult),
        .aluResult(aluResult),
        .inst_in(inst_in),
        .control_in(control_in),
        .reg_write_address(reg_write_address),
        .reg_write_data(reg_write_data)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10 ns clock period
    end

    // Test sequence
    initial begin
        // Initialize inputs
        rst = 1;
        pc_in = 32'b0;
        ldResult = 32'b0;
        aluResult = 32'b0;
        inst_in = 32'b0;
        control_in = 22'b0;

        // Wait for some time and then release reset
        #10 rst = 0;

        // Test case 1: Load operation
        ldResult = 32'h0000000A;  // Simulate loading value 10
        inst_in = 32'b00000000000000000000000000001000; // Dummy instruction
        control_in = 22'b000000000000000000000001; // Load control signal isLd
        #10;

        // Test case 2: Call operation
        pc_in = 32'h00000004; // PC + 4 = 4
        inst_in = 32'b00000000000000000000000000011000; // Dummy instruction
        
        control_in = 22'b000000000000000000010000; // Call control signal isCall
        #10;

        // Test case 3: ALU operation
        aluResult = 32'h00000005;  // Simulate ALU result
        inst_in = 32'b00000000000000000000000000100000; // Dummy instruction
        control_in = 22'b000000000000000000000000; // Default operation
        #10;

        // Finalize test
        $finish;
    end

    // Monitor outputs
    always @(posedge clk) begin
        if (!rst) begin
            $display("Time: %0t | reg_write_address: %h | reg_write_data: %h",
                     $time, reg_write_address, reg_write_data);
        end
    end

endmodule
