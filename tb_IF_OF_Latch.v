module tb_IF_OF_Latch();

    // Testbench signals
    reg clk;
    reg rst;
    reg if_of_enable;
    reg [31:0] pc_in;
    reg [31:0] instruction_in;
    wire [31:0] pc_out;
    wire [31:0] instruction_out;

    // Instantiate the IF_OF_Latch module
    IF_OF_Latch dut (
        .clk(clk),
        .rst(rst),
        .pc_in(pc_in),
        .instruction_in(instruction_in),
        .if_of_enable(if_of_enable),
        .pc_out(pc_out),
        .instruction_out(instruction_out)
    );

    // Clock generation (50 MHz clock, 20 ns period)
    always #10 clk = ~clk;

    // Testbench logic
    initial begin
        // Initialize the clock, reset, and inputs
        clk = 0;
        rst = 1;            // Apply reset
        if_of_enable = 0;
        pc_in = 32'd0;
        instruction_in = 32'd0;

        // Hold reset for 3 clock cycles
        #30;
        rst = 0;            // Deassert reset

        // Test case 1: PC = 4, Instruction = 0x12345678, if_of_enable = 1
        pc_in = 32'd4;
        instruction_in = 32'h12345678;
        if_of_enable = 1;   // Enable the latch
        #20;                // Wait for one clock cycle

        // Check if values are latched correctly
        $display("Time: %0d, PC_out: 0x%h, Instruction_out: 0x%h", $time, pc_out, instruction_out);

        // Test case 2: PC = 8, Instruction = 0x87654321, if_of_enable = 1
        pc_in = 32'd8;
        instruction_in = 32'h87654321;
        #20;                // Wait for one clock cycle

        // Check if new values are latched correctly
        $display("Time: %0d, PC_out: 0x%h, Instruction_out: 0x%h", $time, pc_out, instruction_out);

        // Test case 3: Change inputs but disable the latch
        pc_in = 32'd12;
        instruction_in = 32'hAABBCCDD;
        if_of_enable = 0;   // Disable the latch
        #20;                // Wait for one clock cycle

        // Check if values remain unchanged
        $display("Time: %0d, PC_out: 0x%h, Instruction_out: 0x%h", $time, pc_out, instruction_out);

        // Test case 4: Apply reset while latch is enabled
        rst = 1;
        #20;                // Wait for one clock cycle

        // Check if the outputs are reset to 0
        $display("Time: %0d, PC_out: 0x%h, Instruction_out: 0x%h (After Reset)", $time, pc_out, instruction_out);

        // Finish the simulation
        $finish;
    end

endmodule
