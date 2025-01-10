module tb_IF_and_Latch();

    // Testbench signals
    reg clk;
    reg rst;
    reg isBranchTaken;
    reg [31:0] branchPC;
    reg if_of_enable;
    wire [31:0] pc;
    wire [31:0] instruction;
    wire [31:0] pc_out;
    wire [31:0] instruction_out;

    // Instantiate the Fetch_Unit (IF stage)
    Fetch_Unit fetch_unit (
        .clk(clk),
        .rst(rst),
        .isBranchTaken(isBranchTaken),
        .branchPC(branchPC),
        .pc(pc),
        .instruction(instruction)  // Use the instruction output
    );

    // Instantiate the IF_OF_Latch
    IF_OF_Latch if_of_latch (
        .clk(clk),
        .rst(rst),
        .pc_in(pc),
        .instruction_in(instruction), // Connect instruction to instruction_in
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
        isBranchTaken = 0;
        branchPC = 32'd0;
        if_of_enable = 0;

        // Hold reset for 3 clock cycles
        #30;
        rst = 0;            // Deassert reset

        // Enable latch to start capturing PC and instruction
        if_of_enable = 1;   // Enable latch
        #40;                // Wait for 2 clock cycles

        // Check and print all instructions in memory by driving the PC
        $display("Instructions in Memory:");
        for (integer i = 0; i < 16; i = i + 1) begin
            fetch_unit.pc = i * 4;  // Set PC to read each instruction
            #20;  // Wait for instruction to be fetched
            $display("Address: 0x%0h, Instruction: 0x%0h", i * 4, instruction);
        end

        // Finish the simulation
        $finish;
    end

endmodule
