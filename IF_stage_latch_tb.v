module IF_stage_latch_tb;

    // Testbench signals
    reg clk;
    reg rst;
    reg isBranchTaken;
    reg [31:0] branchPC;
    wire isBranchTaken_out;
    wire [31:0] branchPC_out;

    // Instantiate the IF_stage_latch module
    IF_stage_latch uut (
        .clk(clk),
        .rst(rst),
        .isBranchTaken(isBranchTaken),
        .branchPC(branchPC),
        .isBranchTaken_out(isBranchTaken_out),
        .branchPC_out(branchPC_out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10 time units clock period
    end

    // Test scenario
    initial begin
        // Initial reset
        rst = 1;
        isBranchTaken = 0;
        branchPC = 32'd0;
        #10;  // Wait for one clock cycle

        // Release reset
        rst = 0;
        #10;  // Wait for the next clock edge

        // Apply first set of inputs
        isBranchTaken = 1;
        branchPC = 32'd100;
        #10;  // Wait for clock edge to latch values

        // Apply second set of inputs
        isBranchTaken = 0;
        branchPC = 32'd200;
        #10;  // Wait for clock edge to latch values

        // Assert reset again to check if outputs reset properly
        rst = 1;
        #10;

        // Release reset and provide another set of inputs
        rst = 0;
        isBranchTaken = 1;
        branchPC = 32'd300;
        #10;  // Wait for clock edge to latch values

        // End of test
        $stop;
    end

    // Monitor outputs
    initial begin
        $monitor("Time: %0t | rst: %b | isBranchTaken: %b | branchPC: %h | isBranchTaken_out: %b | branchPC_out: %h",
                 $time, rst, isBranchTaken, branchPC, isBranchTaken_out, branchPC_out);
    end

endmodule
