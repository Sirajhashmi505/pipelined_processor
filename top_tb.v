`timescale 1ns / 1ps

module Top_tb;
    // Inputs to the Top module
    reg clk;
    reg rst;

    // Outputs from the Top module
    wire [31:0] reg_writedata;
    wire [3:0] reg_write_addr;

    // Instantiate the Top module
    Top uut (
        .clk(clk),
        .rst(rst),
        .reg_writedata(reg_writedata),
        .reg_write_addr(reg_write_addr)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Generate a 10ns period clock (100MHzther 5ns for a single 10ns cycle
    end

    // Stimulus process
    initial begin
        // Initialize reset
        rst = 1;
        #1;  // Hold reset for a short duration
        
        // De-assert reset after 1ns
        rst = 0;

        // Print output values
        $monitor("Time: %0t | reg_writedata: %h | reg_write_addr: %d", 
                 $time, reg_writedata, reg_write_addr);
        
        // Run the simulation for 50ns in total
        #10000 $finish;
    end

    // VCD dump generation for waveform analysis
    initial begin
        $dumpfile("simulation.vcd");  // Specify the VCD file name
        $dumpvars(0, Top_tb);          // Dump all variables in the testbench
    end
endmodule
